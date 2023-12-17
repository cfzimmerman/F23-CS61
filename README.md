# CS 61: Systems Programming and Machine Organization

This is my repo for CS 61: Systems Programming and Machine Organization. It was an incredible class on every level, and I’m quite proud of my work in it.

CS 61 was taught by James Mickens in 2023, but I believe it's usually run by Eddie Kohler. In an effort to preserve the problem set directories as he intended (there’s a lot of high-quality handout code), I’ve included a description of each pset below with links to my work. They’re ordered by how cool my solution is. The numbers correspond to the order they came up in the course. Note that the header files often include some course-provided definitions as well. Usually my additions are the one or two key data structures featured in the implementation file.

### 4: Stdio cache

The challenge was to write a cache with the same read / write semantics as the C++ stdio cache but with better performance on at least some access patterns. Mine is an unaligned single slot cache with memory mapping where possible. It outperforms stdio by 61x on reverse piped IO, 25x on normal file 2-byte forward strides, 16x on large file reverse IO, and overall averages 6.1 times faster than stdio on the 40 representative test cases provided by the course.
Header: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset4/io61.hh](https://github.com/cfzimmerman/F23-CS61/blob/main/pset4/io61.hh)
Implementation: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset4/io61.cc](https://github.com/cfzimmerman/F23-CS61/blob/main/pset4/io61.cc)

### 5: Shell

I wrote a shell with Bash-like syntax and support for `&&`, `||`, `;`, arbitrarily-long pipelines, file redirection, and background processes. It also reaps zombie processes and is overall a fairly capable if limited tool.
Header: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset5/sh61.hh](https://github.com/cfzimmerman/F23-CS61/blob/main/pset5/sh61.hh)
Implementation: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset5/sh61.cc](https://github.com/cfzimmerman/F23-CS61/blob/main/pset5/sh61.cc)

### 6: Flockchain

In this Pset, I implemented file-range locking for multithreaded file IO. In doing so, I also wrote a threadsafe recursive shared mutex, generic queue, and lock manager. Note that the io61.cc file uses a course’s handout solution to Pset 4.
Solution implementation: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/io61.cc](https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/io61.cc)
Recursive Reader-Writer lock header: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/rw_rec.hh](https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/rw_rec.hh)
Recursive Reader-Writer lock implementation: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/rw_rec.cc](https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/rw_rec.cc)
Lock manager header: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/range_locks.hh](https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/range_locks.hh)
Lock manager implementation: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/range_locks.cc](https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/range_locks.cc)
Queue: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/mpsc.hh](https://github.com/cfzimmerman/F23-CS61/blob/main/pset6/mpsc.hh)

### 1: Memory allocator

I wrote a performant heap memory allocator with support for malloc, free, calloc, and sanitization.
Header file: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset1/m61.hh](https://github.com/cfzimmerman/F23-CS61/blob/main/pset1/m61.hh)
Implementation file: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset1/m61.cc](https://github.com/cfzimmerman/F23-CS61/blob/main/pset1/m61.cc)

### 3. WeensyOS

Eddie wrote an operating system for this class that I got to work with. Given the handout OS, the challenge was to add virtual memory to it (the handout code uses physical addresses). I did so, enforcing process isolation and adding a fork syscall along the way. Note that I worked within the kernel file below, but that work is not all mine:
Implementation: [https://github.com/cfzimmerman/F23-CS61/blob/main/pset3/kernel.cc](https://github.com/cfzimmerman/F23-CS61/blob/main/pset3/kernel.cc)

### 2. Binary bomb

No code here. The challenge was to decode six passwords from an executable binary using objdump and GDB. I acquired a decent proficiency at x86 AT&T-syntax assembly in the process.
