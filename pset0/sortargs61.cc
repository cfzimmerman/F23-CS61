#include <algorithm>
#include <cstddef>
#include <cstdio>
#include <cstring>
#include <future>
#include <iostream>
#include <iterator>
#include <string>
#include <type_traits>
#include <unordered_map>
#include <vector>

using namespace std;

bool str_leq(string &s1, string &s2) {
  int cmp = strcmp(s1.c_str(), s2.c_str());
  return cmp < 1;
}

size_t partition(vector<string> &strs, int left, int right) {
  int pivot_ind = right;
  string pivot = strs[pivot_ind];
  right--;
  while (left <= right) {
    while (left <= right && str_leq(strs[left], pivot)) {
      left++;
    }
    while (left <= right && str_leq(pivot, strs[right])) {
      right--;
    }
    if (left <= right) {
      swap(strs[left], strs[right]);
      left++;
      right--;
    }
  }
  swap(strs[left], strs[pivot_ind]);
  size_t pivot_final = left;
  return pivot_final;
}

void quick_sort(vector<string> &strs, size_t left, size_t right) {
  size_t pivot = partition(strs, left, right);
  if (pivot > left) {
    quick_sort(strs, left, pivot - 1);
  }
  if (pivot < right) {
    quick_sort(strs, pivot + 1, right);
  }
}

int main(int argc, char *argv[]) {
  if (argc < 3) {
    return 0;
  }
  vector<string> strs(argc - 1);
  for (int ind = 1; ind < argc; ind++) {
    strs[ind - 1] = argv[ind];
  }
  quick_sort(strs, 0, strs.size() - 1);
  for (size_t ind = 0; ind < strs.size(); ind++) {
    cout << strs[ind] << endl;
  }
  return 0;
}
