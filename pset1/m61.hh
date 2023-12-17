#include <cstddef>
#include <cstdint>
#include <map>
#include <set>
#include <utility>
#ifndef M61_HH
#define M61_HH 1
#include <cassert>
#include <cinttypes>
#include <cstdio>
#include <cstdlib>
#include <new>
#include <random>

/// m61_malloc(sz, file, line)
///    Return a pointer to `sz` bytes of newly-allocated dynamic memory.
void *m61_malloc(size_t sz, const char *file = __builtin_FILE(),
                 int line = __builtin_LINE());

/// m61_free(ptr, file, line)
///    Free the memory space pointed to by `ptr`.
void m61_free(void *ptr, const char *file = __builtin_FILE(),
              int line = __builtin_LINE());

/// m61_calloc(count, sz, file, line)
///    Return a pointer to newly-allocated dynamic memory big enough to
///    hold an array of `count` elements of `sz` bytes each. The memory
///    is initialized to zero.
void *m61_calloc(size_t count, size_t sz, const char *file = __builtin_FILE(),
                 int line = __builtin_LINE());

/// m61_statistics
///    Structure tracking memory statistics.
struct m61_statistics {
  unsigned long long nactive;     // # active allocations
  unsigned long long active_size; // # bytes in active allocations
  unsigned long long ntotal;      // # total allocations
  unsigned long long total_size;  // # bytes in total allocations
  unsigned long long nfail;       // # failed allocation attempts
  unsigned long long fail_size;   // # bytes in failed alloc attempts
  uintptr_t heap_min;             // smallest allocated addr
  uintptr_t heap_max;             // largest allocated addr
  m61_statistics()
      : nactive(0), active_size(0), ntotal(0), total_size(0), nfail(0),
        fail_size(0), heap_min(UINTPTR_MAX), heap_max(0) {}
};

/// All possible memory errors that may be reported
enum class m61_err {
  none,
  out_of_bounds,
  double_free,
  not_alloc,
  wild_write,
  wild_free
};

/// Contains additional information about a wild free event
struct wild_free_report {
  uintptr_t region_start;
  int region_alloc_line;
  const char *region_alloc_file;
  uintptr_t incursion_depth;
  size_t region_size;
};

/// Contains the data associated with each memory allocation
struct allocated_chunk {
  uintptr_t end_addr;
  int debug_line;
  const char *debug_file;
};

using t_free_chunks = std::map<uintptr_t, uintptr_t>;
using t_free_chunk_iter = t_free_chunks::iterator;
using t_used_chunks = std::map<uintptr_t, allocated_chunk>;
using t_used_chunk_iter = t_used_chunks::iterator;
using t_free_insert_pair = std::pair<t_free_chunk_iter, bool>;

/// Manages metadata about the memory allocator
struct m61_meta {
public:
  static const uint8_t CLEAN_MEM = 0;
  m61_statistics stats;

  /// Constructs a struct to manage memory allocations
  /// mem_start and mem_end are inclusive. Expect that all
  /// explicitly-defined ranges used by m61_meta are inclusive.
  m61_meta(uintptr_t m_start, uintptr_t m_end)
      : MEM_START(m_start), MEM_END(m_end) {
    free_chunks.insert({m_start, m_end});
  }

  /** MEMORY ALLOCATION */
  /// Performs a memory allocation of the given size. May return nullptr
  /// if no space is available.
  void *alloc_mem(size_t sz, const char *debug_file, int debug_line);
  /// Performs deallocation of the given pointer. Expects a valid free
  /// request. m61_meta::validate_free should likely be called before this.
  void dealloc_mem(void *ptr);

  /** UTILITIES */
  /// Determines whether or not a free request is valid. Expects ptr to
  /// not be nullptr.
  m61_err validate_free(void *ptr);
  /// Searches for internal memory leaks and reports them.
  void report_leaks();
  /// If a wild free has been caught, returns more information about the
  /// situation.
  wild_free_report investigate_wild_free(uintptr_t addr);

private:
  /// Marks memory as recently freed
  const uint8_t FREED_MEM = 1;
  /// Marks memory as padding
  const uint8_t PADDING_MEM = 2;
  /// The first address available to allocate
  const uintptr_t MEM_START;
  /// The last address available to allocate
  const uintptr_t MEM_END;

  /** ADDRESS STORAGE */
  /// A tree of address ranges tracking what memory is currently available.
  /// Internal invariant: [addr_start, addr_end] entries should *never*
  /// intersect.
  t_free_chunks free_chunks;
  /// Tracks the [addr_start, addr_end] range of all allocated memory.
  /// free_chunks rounds allocation sizes up to the nearest (alignment - 1)
  /// location to strengthen coalescing, so the total of all allocated ranges
  /// is often smaller than the total of "not free" chunks
  t_used_chunks used_chunks;

  /** ALLOCATION UTILS */
  /// Searches for an available place in memory. Returns
  /// nullptr if no aligned space could be found.
  t_free_chunk_iter find_free_space(size_t sz);

  /** COALESCING */
  void coalesce_free_chunks(t_free_chunk_iter start);
  void coalesce_free_chunks_up(t_free_chunk_iter start);
  void coalesce_free_chunks_down(t_free_chunk_iter start);

  /** ALIGNMENT */
  /// Rounds an address up to the nearest malloc alignment. Already-aligned
  /// addresses are unmodified.
  uintptr_t round_up_alignment(uintptr_t addr);

  /** TRACKING */
  /// Updates tracked values after a successful allocation
  void update_counters_alloc(uintptr_t new_alloc, size_t sz);
  /// Updates tracked values after a successful deallocation
  void update_counters_dealloc(size_t sz);
  /// Updates tracked values after a failed allocation
  void update_counters_failed_alloc(size_t sz);

  /** DEBUGGING */
  bool found_wild_write(uintptr_t chunk_ends);
  m61_err analyze_free_unalloc_addr(void *ptr);
};

/// m61_get_statistics()
///    Return the current memory statistics.
m61_statistics m61_get_statistics();

/// m61_print_statistics()
///    Print the current memory statistics.
void m61_print_statistics();

/// m61_print_leak_report()
///    Print a report of all currently-active allocated blocks of dynamic
///    memory.
void m61_print_leak_report();

/// This magic class lets standard C++ containers use your allocator
/// instead of the system allocator.
template <typename T> class m61_allocator {
public:
  using value_type = T;
  m61_allocator() noexcept = default;
  m61_allocator(const m61_allocator<T> &) noexcept = default;
  template <typename U> m61_allocator(m61_allocator<U> &) noexcept {}

  T *allocate(size_t n) {
    return reinterpret_cast<T *>(m61_malloc(n * sizeof(T), "?", 0));
  }
  void deallocate(T *ptr, size_t) { m61_free(ptr, "?", 0); }
};
template <typename T, typename U>
inline constexpr bool operator==(const m61_allocator<T> &,
                                 const m61_allocator<U> &) {
  return true;
}

/// Returns a random integer between `min` and `max`, using randomness from
/// `randomness`.
template <typename Engine, typename T>
inline T uniform_int(T min, T max, Engine &randomness) {
  return std::uniform_int_distribution<T>{min, max}(randomness);
}

#endif
