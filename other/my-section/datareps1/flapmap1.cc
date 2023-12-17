#include "flapmap.hh"
#include <cassert>
#include <cstdio>
#include <iterator>
#include <utility>

/** Records a sample from the sensor */
void add_sample(uintptr_t start, size_t duration, size_t flapcount) {
  flapmap.insert({start, {start, duration, flapcount}});
}

/** returns true if a sample has been recorded that covers time t */
bool has_sample(uintptr_t t) {
  flapmap_iter first_after_sample = flapmap.upper_bound(t);
  if (first_after_sample == flapmap.begin()) {
    return false;
  }
  flapmap_iter target_range = std::prev(first_after_sample);
  uintptr_t range_start = target_range->second.start;
  size_t range_end = range_start + target_range->second.duration;
  return range_start <= t && t <= range_end;
}

/** Tests whether a sample with start time `start` and duration `duration`
 *  would overlap any sample in flapmap. */
bool sample_overlaps(uintptr_t sample_start, size_t duration) {
  size_t sample_end = sample_start + duration;
  flapmap_iter cursor = flapmap.lower_bound(sample_start);
  if (cursor != flapmap.begin()) {
    cursor--;
  }
  size_t cursor_start = cursor->second.start;
  size_t cursor_end = cursor_start + cursor->second.duration;
  // !(sample_end < cursor_start)
  while (cursor != flapmap.end() && cursor_start <= sample_end) {
    cursor_start = cursor->second.start;
    cursor_end = cursor_start + cursor->second.duration;
    if (cursor_start <= sample_start && sample_start <= cursor_end) {
      return true;
    }
    if (sample_start <= cursor_start && cursor_start <= sample_end) {
      return true;
    }
    cursor++;
  }
  return false;
}

/** returns whether the sample at position can be combined with the next in
 * sample */
bool can_coalesce_up(flapmap_iter init_sample) {
  if (init_sample == flapmap.end()) {
    return false;
  }
  size_t init_sample_ends =
      init_sample->second.start + init_sample->second.duration;
  flapmap_iter next_sample = std::next(init_sample);
  if (next_sample == flapmap.end()) {
    return false;
  }
  return next_sample->second.start <= init_sample_ends;
}

void coalesce_up(flapmap_iter sample) {
  flapmap_iter next = std::next(sample);
  assert(next != flapmap.end());
  sample->second.duration += next->second.duration;
  sample->second.flapcount += next->second.flapcount;
  flapmap.erase(next);
}

bool can_coalesce_down(flapmap_iter sample) {
  if (sample == flapmap.begin() || sample == flapmap.end()) {
    return false;
  }
  flapmap_iter prev = std::prev(sample);
  size_t prev_ends = prev->second.start + prev->second.duration;
  return sample->second.start <= prev_ends;
}

/** Coalesces down. Destoys sample. Returned pointer is the interval
 * that absorbed it. */
flapmap_iter coalesce_down(flapmap_iter sample) {
  flapmap_iter prev = std::prev(sample);
  prev->second.duration += sample->second.duration;
  prev->second.flapcount += sample->second.flapcount;
  flapmap.erase(sample);
  return prev;
}

void print_flapmap() {
  for (auto it = flapmap.begin(); it != flapmap.end(); ++it) {
    fprintf(stderr, "[%zu, %zu): %zu\n", it->first,
            it->first + it->second.duration, it->second.flapcount);
  }
}

void add_sample_coalesce(uintptr_t start, size_t duration, size_t flapcount) {
  std::pair<flapmap_iter, bool> inserted =
      flapmap.insert({start, {start, duration, flapcount}});
  flapmap_iter cursor = inserted.first;
  while (can_coalesce_down(cursor)) {
    cursor = coalesce_down(cursor);
  }
  while (can_coalesce_up(cursor)) {
    coalesce_up(cursor);
  }
}

int main() {
  // Tests for add_sample

  // Should print nothing
  print_flapmap();
  fprintf(stderr, "\n");

  // Testing add_sample
  add_sample(1, 3, 1);
  add_sample(4, 3, 2);
  add_sample(8, 2, 1);
  assert(flapmap.size() == 3);
  assert(flapmap.find(1)->second.start == 1);
  assert(flapmap.find(8)->second.start == 8);

  assert(!has_sample(0));
  assert(has_sample(1));
  assert(has_sample(2));
  assert(has_sample(3));
  assert(has_sample(10));
  assert(!has_sample(11));

  assert(!sample_overlaps(0, 0));
  assert(!sample_overlaps(14, 2));
  assert(sample_overlaps(1, 3));
  assert(sample_overlaps(2, 3));
  assert(sample_overlaps(2, 4));
  assert(sample_overlaps(7, 8));
  assert(sample_overlaps(7, 14));

  assert(!can_coalesce_up(flapmap.find(4)));
  assert(can_coalesce_up(flapmap.find(1)));

  assert(flapmap.size() == 3);
  coalesce_up(flapmap.find(1));
  assert(flapmap.size() == 2);

  add_sample(20, 4, 3);
  add_sample(24, 6, 2);
  add_sample(30, 5, 12);
  assert(!can_coalesce_down(flapmap.find(20)));
  assert(can_coalesce_down(flapmap.find(24)));
  assert(can_coalesce_down(flapmap.find(30)));
  assert(flapmap.size() == 5);
  add_sample_coalesce(35, 3, 6);
  assert(flapmap.size() == 3);
  print_flapmap();

  fprintf(stderr, "✅ All tests passed\n");
}
