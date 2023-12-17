# CS 61 Problem Set 6

**Fill out both this file and `AUTHORS.md` before submitting.** We grade
anonymously, so put all personally identifying information, including
collaborators, in `AUTHORS.md`.

## Grading notes (if any)

In hindsight, I think this problem set was supposed to be pretty easy. I just got really
in my own head and took a very circuitous path to this largely unimpressive submission.

After finishing the first part, I thought it would be fun to do the rest using
channels, which are one of my favorite features of Rust and Go. However, writing
my own channel turned out to be unexpectedly "character building". I started with a lockless
approach using atomics. Then I realized that was pretty hard, so I switched to
using a ring buffer. That worked alright except I kept failing SAN=1 tests. I spent a long
time debugging that and eventually gave up. As a sanity check on my own tests, I implemented
the simple locked queue channel that's in `mpsc.hh` now. Then, I moved on.

The exposed API in the pset makes a clear distinction between reader and writer
requests. In my opinion, this is best solved by a recursive reader-writer mutex. Stdlib
doesn't have one, so I decided to write my own. The recursive rw mutex in `rw_rec.hh` is
such a lock. It passes the test I wrote and actually passes all the pset _correctness_ tests too.
However, TSan is absolutely hellbent on warning that `rw_rec` has a race condition. I could
very well be wrong, but I'm almost positive TSan is misidentifiying my mutex's lock requests
as race conditions. I verified this by messing with the exposed TSan C functions that are
commented out at the top of `rw_rec.cc`. However, I don't see a clear way to communicate
to TSan that a mutex is both recursive _and_ shared, so the annotations just get TSan
confused with other behavior. I'm even more confident about this because I get the
same issue on the simple queue in `mpsc.hh`, and either I'm fundamentally misunderstanding
something or both of these are fine. However, because I don't want to fail the sanitizer
tests on the pset (imo unjustly because of TSan's race condition checker), I just stuck
with recursive mutexes.

(Btw, I'm still pretty salty about about the TSan race condition warnings. If you have time
to skim rw_rec for any obvious race conditions, I'd love it if you could find the issue.
I spent an hour with James at OH doing the same.)

Finally, I implemented the simple, hard-working range lock store in `range_locks.hh`. My
final pset submission doesn't distinguish between read and write requests, but I could
switch to `rw_rec` if needed at the cost of some TSan complaints.

## Extra credit attempted (if any)

Lol because of the saga above, I ran out of time for extra credit.
