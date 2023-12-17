#include "rw_rec.hh"
#include <cassert>
#include <cstdio>
#include <mutex>
#include <sys/fcntl.h>

/*
extern "C" void __tsan_mutex_pre_lock(void*, int, int);
extern "C" void __tsan_mutex_post_lock(void*, int, int, int);
extern "C" void __tsan_mutex_pre_unlock(void*, int);
extern "C" void __tsan_mutex_post_unlock(void*, int);
extern "C" void __tsan_acquire(void*);
extern "C" void __tsan_release(void*);
*/

/// A debug function for printing thread IDs
size_t parse_thread_id(std::thread::id tid) {
    std::hash<std::thread::id> hasher;
    return hasher(tid);
}

/// Acquires a writer lock on this mutex. Blocks until succeeding.
void rw_rec::lock() {
    std::thread::id thread_id = std::this_thread::get_id();
    while (true) {
        std::unique_lock lk(internal_access);
        if (acquired_lock(thread_id, LOCK_EX)) {
            return;
        }
        cv.wait(lk, [this, thread_id] {
            return ref_ct == 0 || owner_tid == thread_id;
        });
    }
}

/// Acquires a reader lock on this mutex. Blocks until succeeding.
void rw_rec::lock_shared() {
    std::thread::id thread_id = std::this_thread::get_id();
    while (true) {
        std::unique_lock lk(internal_access);
        if (acquired_lock(thread_id, LOCK_SH)) {
            return;
        }
        cv.wait(lk, [this, thread_id] {
            return ref_ct == 0 || owner_tid == thread_id || locktype == LOCK_SH;
        });
    }
}

/// Releases a lock from the mutex. Other locks may still be live if
/// the lock is a reader or if one thread has multiple locks.
void rw_rec::unlock() {
    std::unique_lock lk(internal_access);
    ref_ct--;
    if (ref_ct != 0) {
        return;
    }
    locktype = LOCK_UN;
    cv.notify_all();
}

/// Releases a reader lock from the mutex. Will panic if the mutex is
/// not currently in reader / shared mode.
void rw_rec::unlock_shared() {
    std::unique_lock lk(internal_access);
    assert(locktype == LOCK_SH);
    unlock();
}

/// Makes a single attempt at acquiring the mutex as a writer.
/// Returns true on success, false if the lock was not acquired.
bool rw_rec::try_lock() {
    return try_lock_type(LOCK_EX);
}

/// Makes a single attempt at acquiring the mutex as a reader.
/// Returns true on success, false if the lock was not acquired.
bool rw_rec::try_lock_shared() {
    return try_lock_type(LOCK_SH);
}

/// Returns the current variant of the lock.
int rw_rec::get_locktype() {
    std::unique_lock lk(internal_access);
    return locktype;
}

/// Considers cases for lock acquisition.
/// Returns true if the lock was allocated, false if not.
/// REQUIRES INTERNAL MUTEX IS HELD.
bool rw_rec::acquired_lock(std::thread::id thread_id, int req_lock_tp) {
    assert(req_lock_tp == LOCK_EX || req_lock_tp == LOCK_SH);
    int internal_lock_type = locktype;

    if (internal_lock_type == LOCK_UN) {
        // Claim the open lock.
        locktype = req_lock_tp;
        owner_tid = thread_id;
        assert(ref_ct == 0);
        ref_ct++;
        return true;
    }

    assert(ref_ct > 0);
    if (internal_lock_type == LOCK_EX) {
        if (owner_tid == thread_id && req_lock_tp == LOCK_EX) {
            // The thread controlling an exclusive lock can call lock multiple times.
            ref_ct++;
            return true;
        }
        return false;
    }

    if (internal_lock_type == LOCK_SH) {
        if (req_lock_tp == LOCK_SH) {
            // Add a reader to a shared reader lock.
            ref_ct++;
            return true;
        }
        return false;
    }

    // Cases should be exhaustive
    assert(false);
}

/// Handles an attempt to try a lock of the given type. Supported
/// locktypes include LOCK_SH and LOCK_EX.
bool rw_rec::try_lock_type(int lock_tp) {
    assert(lock_tp == LOCK_SH || lock_tp == LOCK_EX);
    std::unique_lock lk(internal_access, std::defer_lock);
    if (!lk.try_lock()) {
        return false;
    }
    bool res = acquired_lock(std::this_thread::get_id(), lock_tp);
    return res;
}

/// Prints debug info about the mutex
void rw_rec::debug() {
    printf("\n");
    printf("internal_access: %p\n", &internal_access);
    printf("locktype: %p\n", &locktype);
    printf("owner_tid: %p\n", &owner_tid);
    printf("ref_ct: %p\n", &ref_ct);
    printf("cv: %p\n", &cv);
    printf("\n");
}
