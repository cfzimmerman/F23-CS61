#include <memory>
#include <cassert>
#include <mutex>
#include <vector>


static off_t MAX_CHUNKS = 256;

class range_locks {
  public:
    /// The range_locks class divides a range from `[0, filesize]` into
    /// chunks and manages concurrent access to each chunk.
    /// Each chunk has its own mutex, and there's an option to
    /// provide a maximum chunk count. Otherwise, the limit defaults
    /// to 256. The byte size of each chunk is determined by the
    /// filesize and number of locks.
    /// Note that raising the maximum lock count doesn't necessarily
    /// increase performance under pressure. From observation, runtime
    /// seems to be on a parabola.
    range_locks(off_t filesize, off_t max_chunks = MAX_CHUNKS) {
        assert(filesize >= 0);
        num_chunks = std::min(filesize, max_chunks);
        chunk_size = (filesize / num_chunks) + 1;
        chunks = std::vector<std::unique_ptr<std::recursive_mutex>>(num_chunks);
        for (std::unique_ptr<std::recursive_mutex>& rw_lock_ptr : chunks) {
            rw_lock_ptr = std::make_unique<std::recursive_mutex>();
        }
    }

    /// Makes a fallible request to acquire a range of locks.
    /// 0 is success, anything else is a failure.
    /// If a request fails, any intermediately acquired locks
    /// in the range are released.
    int try_lock_range(off_t start, off_t len, int locktype);

    /// Makes a blocking request to acquire a range of locks.
    /// Always succeeds if it returns.
    void lock_range(off_t start, off_t len, int locktype);

    /// Unlocks a range of locks.
    void unlock_range(off_t start, off_t len);

  private:
    /// equal to chunks.size()
    off_t num_chunks = 0;
    /// the number of bytes in a chunk
    off_t chunk_size = 0;
    /// chunk storage
    std::vector<std::unique_ptr<std::recursive_mutex>> chunks;

    /// Corresponds to locking and fallible mutex acquisition.
    enum lock_attempt {
        block_until,
        try_once
    };

    /// Returns the chunk indices associated with a byte range from
    /// the file.
    std::tuple<off_t, off_t> get_range_inds(off_t start, off_t len);

    /// Returns the chunk index associated with a position in the file.
    off_t get_lock_ind(off_t pos);

    /// Locks a single chunk identified by index.
    bool lock_chunk(off_t index, int lock_tp, lock_attempt strat);
};
