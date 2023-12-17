# CS 61 Problem Set 1

**Fill out both this file and `AUTHORS.md` before submitting.** We grade
anonymously, so put all personally identifying information, including
collaborators and citations, in `AUTHORS.md`.

## Grading notes (if any)

Unsure if the person who reads this grades the rest of the PSET. I'm assuming so:

- I opted to build the allocator around a class definition. It felt a bit awkward connecting those with the
  template code, but it made passing values a lot cleaner. Is my approach stylistically-valid C++?

- I poked around online and couldn't determine conclusively if doc comments should go in the header
  or implementation file. I went with the header file. Seems like it might be a bit of a preference
  thing? Feel free to leave comments on which you think is better.

- Stylistically, my preference is to try to make my code readable and let doc comments do the rest (unless
  something really needs explanation). That means more variable declarations (which I assume the compiler
  optimizes out) and fewer `// this line does this` comments. Unsure where you land on this, but the lack of
  frequent inline comments is intentional.

- I really tried to get perf to work on M1 Docker Ubuntu but couldn't make it happen. My code feels pretty
  slow, and I'm super curious where the bottlenecks are. Of course accessing a map/tree frequently has a
  heavy price. But if you see areas where I'm carelessly wasting (compiler optimized) performance, please feel
  free to point it out.

## Extra credit attempted (if any)
