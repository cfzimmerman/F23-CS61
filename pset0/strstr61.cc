#include <cassert>
#include <cstddef>
#include <cstdio>
#include <cstring>
#include <iostream>
#include <string.h>

/** Returns whether s2 is equal to s1 for the length of s2.
 *  Ex: "runner" s1 and "run" s2 returns true. "ru" and "run" is false. */
bool arr_are_sub_eq(const char *s1, const char *s2) {
  std::size_t s1_len = strlen(s1);
  std::size_t s2_len = strlen(s2);
  if (s1_len < s2_len) {
    return false;
  };
  for (unsigned long ind = 0; ind < s2_len; ind++) {
    if (s1[ind] != s2[ind]) {
      return false;
    }
  }
  return true;
}

const char *arr_mystrstr(const char *s1, const char *s2) {
  std::size_t s1_len = strlen(s1);
  std::size_t s2_len = strlen(s2);
  if (s2_len == 0) {
    return s1;
  }
  if (s2_len > s1_len) {
    return nullptr;
  }
  for (unsigned long ind = 0; ind <= s1_len - s2_len; ind++) {
    if (s1[ind] == s2[0] && arr_are_sub_eq(&s1[ind], &s2[0])) {
      return &s1[ind];
    }
  };
  return nullptr;
}

bool ptr_are_sub_eq(const char *s1, const char *s2) {
  std::size_t s1_len = strlen(s1);
  std::size_t s2_len = strlen(s2);
  if (s1_len < s2_len) {
    return false;
  };
  for (unsigned long ind = 0; ind < s2_len; ind++) {
    if (*s1 != *s2) {
      return false;
    }
    s1++;
    s2++;
  }
  return true;
}

const char *ptr_mystrstr(const char *s1, const char *s2) {
  std::size_t s1_len = strlen(s1);
  std::size_t s2_len = strlen(s2);
  if (s2_len == 0) {
    return s1;
  }
  if (s2_len > s1_len) {
    return nullptr;
  }
  for (unsigned long ind = 0; ind <= s1_len - s2_len; ind++) {
    if (*s1 == *s2 && arr_are_sub_eq(s1, s2)) {
      return s1;
    }
    s1++;
  };
  return nullptr;
}

int main(int argc, char *argv[]) {
  assert(argc == 3);
  printf("strstr(\"%s\", \"%s\") = %p\n", argv[1], argv[2],
         strstr(argv[1], argv[2]));
  printf("arr_mystrstr(\"%s\", \"%s\") = %p\n", argv[1], argv[2],
         arr_mystrstr(argv[1], argv[2]));
  printf("ptr_mystrstr(\"%s\", \"%s\") = %p\n", argv[1], argv[2],
         ptr_mystrstr(argv[1], argv[2]));
  assert(strstr(argv[1], argv[2]) == arr_mystrstr(argv[1], argv[2]) &&
         strstr(argv[1], argv[2]) == ptr_mystrstr(argv[1], argv[2]));
  return 0;
}
