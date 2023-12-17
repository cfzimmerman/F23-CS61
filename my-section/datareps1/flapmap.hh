#include <cassert>
#include <cstdint>
#include <cstdio>
#include <map>

struct sample {
  uintptr_t start;
  size_t duration;
  size_t flapcount;
};

std::map<uintptr_t, sample> flapmap;
using flapmap_iter = std::map<uintptr_t, sample>::iterator;
