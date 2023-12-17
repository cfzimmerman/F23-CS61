#include "m61.hh"
#include "hexdump.hh"
#include <algorithm>
#include <cassert>
#include <cinttypes>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <exception>
#include <fstream>
#include <ios>
#include <iostream>
#include <iterator>
#include <map>
#include <ostream>
#include <stdexcept>
#include <sys/mman.h>
#include <utility>

struct m61_memory_buffer {
  char *buffer;
  size_t pos = 0;
  size_t size = 8 << 20; /* 8 MiB */

  m61_memory_buffer();
  ~m61_memory_buffer();
};

static m61_memory_buffer default_buffer;

const uintptr_t buf_start = (uintptr_t)&default_buffer.buffer[0];
m61_meta meta(buf_start, buf_start + default_buffer.size - 1);

/** EXPORTS */

void *m61_malloc(size_t sz, const char *file, int line) {
  return meta.alloc_mem(sz, file, line);
}

void m61_free(void *ptr, const char *file, int line) {
  if (ptr == nullptr) {
    return;
  }
  switch (meta.validate_free(ptr)) {
  case m61_err::none:
    break;
  case m61_err::out_of_bounds: {
    fprintf(stderr,
            "MEMORY BUG: %s:%d: invalid free of pointer "
            "%p, not in heap\n",
            file, line, ptr);
    return;
  }
  case m61_err::double_free: {
    fprintf(stderr,
            "MEMORY BUG: %s:%d: invalid free of pointer "
            "%p, double free\n",
            file, line, ptr);
    return;
  }
  case m61_err::not_alloc: {
    fprintf(stderr,
            "MEMORY BUG: %s:%d: invalid free of pointer "
            "%p, not allocated\n",
            file, line, ptr);
    return;
  }
  case m61_err::wild_write: {
    fprintf(
        stderr,
        "MEMORY BUG: %s:%d: detected wild write during free of pointer %p\n ",
        file, line, ptr);
    return;
  }
  case m61_err::wild_free: {
    wild_free_report details = meta.investigate_wild_free((uintptr_t)ptr);
    fprintf(
        stderr,
        "MEMORY BUG: %s:%d: invalid free of pointer %p, not allocated\n%s:%d: "
        "%p is %lu bytes inside a %lu byte region allocated here\n",
        file, line, ptr, file, details.region_alloc_line, ptr,
        details.incursion_depth, details.region_size);
    return;
  }
  default:
    std::throw_with_nested(
        std::logic_error("enum m61_err was inexhaustively matched"));
  }
  meta.dealloc_mem(ptr);
  return;
}

void *m61_calloc(size_t count, size_t sz, const char *file, int line) {
  assert(count > 0);
  size_t total_space = count * sz;
  if (total_space < count || total_space < sz) {
    // Integer overflowed and wrapped around. This will trigger a failure.
    total_space = SIZE_MAX;
  }
  void *ptr = m61_malloc(total_space, file, line);
  if (ptr != nullptr) {
    memset(ptr, 0, total_space);
  }
  return ptr;
}

m61_memory_buffer::m61_memory_buffer() {
  void *buf = mmap(nullptr,    // Place the buffer at a random address
                   this->size, // Buffer should be 8 MiB big
                   PROT_WRITE, // We want to read and write the buffer
                   MAP_ANON | MAP_PRIVATE, -1, 0);
  // We want memory freshly allocated by the OS
  assert(buf != MAP_FAILED);
  this->buffer = (char *)buf;
}

m61_memory_buffer::~m61_memory_buffer() { munmap(this->buffer, this->size); }

m61_statistics m61_get_statistics() { return meta.stats; }

void m61_print_statistics() {
  m61_statistics stats = m61_get_statistics();
  printf("alloc count: active %10llu   total %10llu   fail %10llu\n",
         stats.nactive, stats.ntotal, stats.nfail);
  printf("alloc size:  active %10llu   total %10llu   fail %10llu\n",
         stats.active_size, stats.total_size, stats.fail_size);
}

void m61_print_leak_report() { meta.report_leaks(); }

/** M61_META: PUBLIC MEMORY ALLOCATION */

void *m61_meta::alloc_mem(size_t req_sz, const char *debug_file,
                          int debug_line) {
  assert(req_sz > 0);
  if (req_sz > default_buffer.size) {
    update_counters_failed_alloc(req_sz);
    return nullptr;
  }
  // Every allocation we make should have size % (max alignment) == 0, which
  // enables us to coalesce much more effectively.
  size_t internal_sz = round_up_alignment(req_sz);
  if (internal_sz > default_buffer.size) {
    update_counters_failed_alloc(req_sz);
    return nullptr;
  }
  t_free_chunk_iter cursor = find_free_space(internal_sz);
  if (cursor == free_chunks.end()) {
    update_counters_failed_alloc(req_sz);
    return nullptr;
  }

  uintptr_t old_unalloc_start = cursor->first;
  uintptr_t old_unalloc_end = cursor->second;

  uintptr_t new_mem_start = round_up_alignment(old_unalloc_start);
  // Because mem_end is inclusive
  uintptr_t mem_end_with_padding = new_mem_start + internal_sz - 1;
  uintptr_t mem_end_without_padding = new_mem_start + req_sz - 1;

  assert(old_unalloc_start <= new_mem_start);
  assert(new_mem_start <= mem_end_with_padding);
  assert(mem_end_with_padding <= old_unalloc_end);

  free_chunks.erase(cursor);
  if (old_unalloc_start < new_mem_start) {
    t_free_insert_pair mem_segment =
        free_chunks.insert({old_unalloc_start, new_mem_start - 1});
    coalesce_free_chunks(mem_segment.first);
  }
  if (mem_end_with_padding < old_unalloc_end) {
    t_free_insert_pair mem_segment =
        free_chunks.insert({mem_end_with_padding + 1, old_unalloc_end});
    coalesce_free_chunks(mem_segment.first);
  }
  used_chunks.insert(
      {new_mem_start, {mem_end_without_padding, debug_line, debug_file}});
  update_counters_alloc(new_mem_start, req_sz);
  if (mem_end_without_padding < mem_end_with_padding) {
    uintptr_t padding_begins = mem_end_without_padding + 1;
    uintptr_t padding_size = mem_end_with_padding - mem_end_without_padding;
    assert(padding_size > 0);
    std::memset((void *)padding_begins, PADDING_MEM, padding_size);
  }
  return reinterpret_cast<void *>(new_mem_start);
}

void m61_meta::dealloc_mem(void *ptr) {
  if (ptr == nullptr) {
    return;
  }
  uintptr_t addr = (uintptr_t)ptr;
  t_used_chunk_iter chunk = used_chunks.find(addr);
  assert(chunk != used_chunks.end());

  uintptr_t chunk_sz_without_padding =
      chunk->second.end_addr - chunk->first + 1;
  uintptr_t chunk_sz_with_padding =
      round_up_alignment(chunk_sz_without_padding);
  uintptr_t alloc_chunk_end = chunk->first + chunk_sz_with_padding - 1;
  assert((alloc_chunk_end + 1) % alignof(max_align_t) == 0);

  t_free_insert_pair freed_chunk =
      free_chunks.insert({chunk->first, alloc_chunk_end});

  coalesce_free_chunks(freed_chunk.first);
  update_counters_dealloc(chunk_sz_without_padding);
  used_chunks.erase(chunk);
  char *mem_start = (char *)ptr;
  *mem_start = FREED_MEM;
}

/** M61_META: PUBLIC UTILITIES */

m61_err m61_meta::validate_free(void *ptr) {
  assert(ptr != nullptr);
  uintptr_t addr = (uintptr_t)ptr;
  if (addr < MEM_START || MEM_END < addr) {
    return m61_err::out_of_bounds;
  }
  t_used_chunk_iter mem_entry = used_chunks.find(addr);
  if (mem_entry == used_chunks.end()) {
    return analyze_free_unalloc_addr(ptr);
  }
  if (found_wild_write(mem_entry->second.end_addr)) {
    return m61_err::wild_write;
  }
  return m61_err::none;
}

void m61_meta::report_leaks() {
  for (t_used_chunk_iter it = used_chunks.begin(); it != used_chunks.end();
       it++) {
    fprintf(stdout, "LEAK CHECK: %s:%d: allocated object %p with size %lu\n",
            it->second.debug_file, it->second.debug_line, (void *)it->first,
            it->second.end_addr - it->first + 1);
  }
}

wild_free_report m61_meta::investigate_wild_free(uintptr_t addr) {
  assert(used_chunks.size() > 0);
  t_used_chunk_iter chunk = used_chunks.upper_bound(addr);
  chunk--;
  uintptr_t region_start = chunk->first;
  int region_alloc_line = chunk->second.debug_line;
  uintptr_t incursion_depth = addr - region_start;
  size_t region_size = chunk->second.end_addr - region_start + 1;
  return {region_start, region_alloc_line, chunk->second.debug_file,
          incursion_depth, region_size};
}

/** M61_META: PRIVATE ALLOCATION UTILS */

t_free_chunk_iter m61_meta::find_free_space(size_t sz) {
  t_free_chunk_iter cursor = free_chunks.begin();
  while (cursor != free_chunks.end()) {
    if (round_up_alignment(cursor->first) + sz - 1 <= cursor->second) {
      break;
    }
    cursor++;
  }
  return cursor;
}

/** M61_META: PRIVATE COALESCING */

void m61_meta::coalesce_free_chunks(t_free_chunk_iter start) {
  coalesce_free_chunks_up(start);
  coalesce_free_chunks_down(start);
  return;
}

void m61_meta::coalesce_free_chunks_up(t_free_chunk_iter start) {
  assert(start != free_chunks.end());
  t_free_chunk_iter next = std::next(start);
  while (next != free_chunks.end() && start->second + 1 == next->first) {
    assert(start->second < next->second);
    start->second = next->second;
    t_free_chunk_iter new_next = std::next(next);
    free_chunks.erase(next);
    next = new_next;
  }
}

void m61_meta::coalesce_free_chunks_down(t_free_chunk_iter cursor) {
  assert(cursor != free_chunks.end());
  t_free_chunk_iter preceding = std::prev(cursor);
  while (cursor != free_chunks.begin() &&
         preceding->second + 1 == cursor->first) {
    assert(preceding->second < cursor->second);
    preceding->second = cursor->second;
    t_free_chunk_iter old_cursor = cursor;
    cursor = preceding;
    preceding = std::prev(preceding);
    free_chunks.erase(old_cursor);
  }
}

/** M61_META: PRIVATE ALIGNMENT */

uintptr_t m61_meta::round_up_alignment(uintptr_t addr) {
  uintptr_t alignment = alignof(std::max_align_t);
  if (addr % alignment == 0) {
    return addr;
  }
  uintptr_t alignment_multiple = static_cast<uintptr_t>(ceill(
      static_cast<long double>(addr) / static_cast<long double>(alignment)));
  uintptr_t aligned_addr = alignment_multiple * alignment;
  assert(addr < aligned_addr);
  return aligned_addr;
}

/** M61_META: PRIVATE TRACKING */

void m61_meta::update_counters_alloc(uintptr_t new_alloc, size_t sz) {
  stats.nactive++;
  stats.ntotal++;
  stats.active_size += sz;
  stats.total_size += sz;
  stats.heap_min = std::min(stats.heap_min, new_alloc);
  stats.heap_max = std::max(stats.heap_max, new_alloc + sz);
}

void m61_meta::update_counters_dealloc(size_t sz) {
  stats.nactive--;
  stats.active_size -= sz;
}

void m61_meta::update_counters_failed_alloc(size_t sz) {
  stats.nfail++;
  stats.fail_size += sz;
}

bool intersects(uintptr_t st1, uintptr_t end1, uintptr_t st2, uintptr_t end2) {
  return (st1 <= st2 && st2 <= end1) || (st2 <= st1 && st1 <= end2);
}

/** M61_META: PRIVATE DEBUGGING */

bool m61_meta::found_wild_write(uintptr_t chunk_ends) {
  uintptr_t next_aligned_begins = round_up_alignment(chunk_ends);
  assert(chunk_ends <= next_aligned_begins);
  uint8_t *after_alloc = reinterpret_cast<uint8_t *>(chunk_ends + 1);
  uint8_t *stop_at = reinterpret_cast<uint8_t *>(next_aligned_begins);
  for (; after_alloc < stop_at; after_alloc++) {
    if (*after_alloc != PADDING_MEM) {
      return true;
    }
  }
  return false;
}

m61_err m61_meta::analyze_free_unalloc_addr(void *ptr) {
  uintptr_t addr = (uintptr_t)ptr;
  uint8_t *mem_start = (uint8_t *)ptr;
  if (*mem_start == FREED_MEM) {
    return m61_err::double_free;
  }
  t_free_chunk_iter free_after_addr = free_chunks.upper_bound(addr);
  if (free_after_addr == free_chunks.begin()) {
    return m61_err::wild_free;
  }
  t_free_chunk_iter free_before_addr = std::prev(free_after_addr);
  if (free_before_addr->second < addr && addr < free_after_addr->first) {
    // t_used_chunk_iter intersecting_alloc = used_chunks.lower_bound(addr);
    return m61_err::wild_free;
  }
  return m61_err::not_alloc;
}
