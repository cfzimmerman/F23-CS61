#include <condition_variable>
#include <mutex>
#include <sys/fcntl.h>
#include <thread>

/// Reader-Writer Recursive Mutex
///
/// A recursive, reader-writer mutex that's compatible with
/// RAII lock wrappers from stdlib.
///
/// One thread can acquire lock_shared multiple times.
/// One thread can acquire lock multiple times.
/// One thread cannot acquire both lock and lock_shared simultanously.
/// Many threads can acquire lock_shared concurrently.
/// Many threads cannot acquire lock concurrently.
class rw_rec {
  public:
    /// Acquires a writer lock on this mutex. Blocks until succeeding.
    void lock();

    /// Acquires a reader lock on this mutex. Blocks until succeeding.
    void lock_shared();

    /// Releases a lock from the mutex. Other locks may still be live if
    /// the lock is a reader or if one thread has multiple locks.
    void unlock();

    /// The lock type is internally tracked, so this is a wrapper
    /// for unlock that panics if the lock is not in read mode.
    void unlock_shared();

    /// Makes a single attempt at acquiring the mutex as a writer.
    /// Returns true on success, false if the lock was not acquired.
    bool try_lock();

    /// Makes a single attempt at acquiring the mutex as a reader.
    /// Returns true on success, false if the lock was not acquired.
    bool try_lock_shared();

    /// Returns the current variant of the lock.
    int get_locktype();

    void debug();
    std::recursive_mutex internal_access = std::recursive_mutex();


  private:
    std::atomic<int> locktype = LOCK_UN;
    // owner_tid is only well-defined when the locktype is *not* LOCK_UN
    std::thread::id owner_tid;
    std::atomic<size_t> ref_ct = 0;
    std::condition_variable_any cv;


    /// Considers cases for lock acquisition.
    /// Returns true if the lock was allocated, false if not.
    /// REQUIRES INTERNAL MUTEX IS HELD.
    bool acquired_lock(std::thread::id thread_id, int lock_tp);

    /// Makes a single, fallible attempt to acquire a lock of
    /// the given type.
    bool try_lock_type(int lock_tp);
};
