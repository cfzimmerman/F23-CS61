#include <charconv>
#include <cstdio>
#include <iostream>
#include <string>

int main() {
  int sum = 0;
  while (std::fgetc(stdin) != EOF) {
    sum++;
  }
  std::fprintf(stdout, "%d\n", sum);
  return 0;
}
