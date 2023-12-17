#include "range_locks.hh"

// PUBLIC IMPL

/// Makes a fallible request to acquire a range of locks.
/// 0 is success, anything else is a failure.
/// If a request fails, any intermediately acquired locks
/// in the range are released.
int range_locks::try_lock_range(off_t start, off_t len, int locktype) {
    const auto [start_ind, end_ind] = get_range_inds(start, len);
    for (off_t cursor = start_ind; cursor <= end_ind; cursor++) {
        if (lock_chunk(cursor, locktype, lock_attempt::try_once)) {
            continue;
        };
        // lock failed, clean up and return failure.
        for (off_t cleanup = start_ind; cleanup < cursor; cleanup++) {
            chunks.at(cleanup)->unlock();
        }
        return -1;
    }
    return 0;
}

/// Makes a blocking request to acquire a range of locks.
/// Always succeeds if it returns.
void range_locks::lock_range(off_t start, off_t len, int locktype) {
    const auto [start_ind, end_ind] = get_range_inds(start, len);
    for (off_t cursor = start_ind; cursor <= end_ind; cursor++) {
        lock_chunk(cursor, locktype, lock_attempt::block_until);
    }
}

/// Unlocks a range of locks.
void range_locks::unlock_range(off_t start, off_t len) {
    const auto [start_ind, end_ind] = get_range_inds(start, len);
    for (off_t cursor = start_ind; cursor <= end_ind; cursor++) {
        // This vector indexing assumes we have the lock. If not, this
        // could lead to a race condition.
        chunks.at(cursor)->unlock();
    }
}

// PRIVATE IMPL

/// Returns the chunk indices associated with a byte range from
/// the file.
std::tuple<off_t, off_t> range_locks::get_range_inds(off_t start, off_t len) {
    off_t start_ind = get_lock_ind(start);
    // end iterators are expected to not be included in the range
    off_t end_ind = get_lock_ind(start + len - 1);
    assert(start_ind <= end_ind);
    assert(end_ind < num_chunks);
    return {start_ind, end_ind};
};

/// Returns the chunk index associated with a position in the file.
off_t range_locks::get_lock_ind(off_t pos) {
    assert(pos >= 0);
    assert(num_chunks > 0);
    off_t lock_ind = std::min(pos / chunk_size, num_chunks - 1);
    return lock_ind;
};

/// Locks a single chunk identified by index.
bool range_locks::lock_chunk(off_t ind, int /* locktype */, lock_attempt strat) {
    // Locktype is an artifact from the API this serves. Range locks are also compatible
    // with the rw_rec custom lock that supports shared recursive locking.
    // When shared recursive locking is enabled, locktype can be used to allow
    // multiple simultaneous readers.
    // TSan takes issue with rw_rec sometimes, so I'm sticking with
    // a normal recursive mutex and unfortunatley ignoring the case in which
    // multiple readers want to access the same file range.
    assert(ind < num_chunks);
    std::unique_ptr<std::recursive_mutex>& lock = chunks.at(ind);

    if (strat == lock_attempt::try_once) {
        return lock->try_lock();
    }

    assert(strat == lock_attempt::block_until);
    lock->lock();
    return true;
}
