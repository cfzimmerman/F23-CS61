#include <cctype>
#include <cstdio>
#include <iostream>
#include <string>

int main() {
  char ch;
  int lines = 0;
  int words = 0;
  int bytes = 0;
  bool word_begun = false;
  while ((ch = std::fgetc(stdin)) != EOF) {
    bytes++;
    if (ch == '\n') {
      lines++;
      word_begun = false;
    }
    if (isspace(ch)) {
      word_begun = false;
      continue;
    }
    if (!word_begun) {
      words++;
      word_begun = true;
    }
  }
  printf("%d  %d  %d\n", lines, words, bytes);
}

/*
int main() {
  std::string line;
  int num_lines = 0;
  int num_words = 0;
  int num_bytes = 0;
  while (getline(std::cin, line)) {
    num_lines++;
    num_words++;
    num_bytes += line.length() + 1;
    for (char c : line) {
      if (std::isspace(c)) {
        num_words++;
      }
    };
  }
  printf("lines: %d, words: %d, bytes: %d\n", num_lines, num_words, num_bytes);
  return 0;
}
*/
