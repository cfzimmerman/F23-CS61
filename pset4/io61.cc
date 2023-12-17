#include "io61.hh"
#include <algorithm>
#include <cassert>
#include <cerrno>
#include <climits>
#include <csignal>
#include <cstring>
#include <fstream>
#include <ostream>
#include <sys/fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

struct io61_file {
  int fd = -1; // file descriptor
  int mode;    // open mode (O_RDONLY or O_WRONLY)
  file_variant file_v;
  rwm_cache cache;
};

/// IO 61 METHODS

// io61_fdopen(fd, mode)
//    Returns a new io61_file for file descriptor `fd`. `mode` is either
//    O_RDONLY for a read-only file or O_WRONLY for a write-only file.
//    You need not support read/write files.
io61_file *io61_fdopen(int fd, int mode) {
  assert(fd >= 0);
  io61_file *f = new io61_file();
  f->fd = fd;
  f->mode = mode;

  assert(mode == O_RDONLY || mode == O_WRONLY);

  off_t pos = lseek(fd, 0, SEEK_CUR);
  if (0 <= pos) {
    f->file_v = file_variant::seekable;
  } else {
    f->file_v = file_variant::unseekable;
  }
  ssize_t mmap_res = f->cache.init_mmap_cache(f);
  if (0 <= mmap_res) {
    return f;
  }
  if (mode == O_RDONLY) {
    f->cache.init_read_cache(f);
  } else {
    assert(mode == O_WRONLY);
    f->cache.init_write_cache(f);
  }
  return f;
}

// io61_close(f)
//    Closes the io61_file `f` and releases all its resources.
int io61_close(io61_file *file) {
  if (file->cache.mmap_base != nullptr) {
    munmap(file->cache.mmap_base,
           file->cache.mmap_end_excl - file->cache.mmap_base);
    int r = close(file->fd);
    delete file;
    return r;
  }
  ssize_t bytes_to_flush = file->cache.cache_cursor - file->cache.cache_base;
  while (file->mode == O_WRONLY && 0 < bytes_to_flush) {
    ssize_t flushed = file->cache.flush_write_cache(file);
    if (flushed < 0) {
      continue;
    }
    if (flushed != bytes_to_flush) {
      file->cache.cleanup_partial_flush(flushed);
    }
    bytes_to_flush -= flushed;
  }
  int r = close(file->fd);
  delete file;
  return r;
}

// io61_seek(f, off)
//    Changes the file pointer for file `f` to `off` bytes into the file.
//    Returns 0 on success and -1 on failure.
int io61_seek(io61_file *file, off_t off) {
  if (file->file_v != file_variant::seekable) {
    return -1;
  }
  if (file->cache.mmap_base != nullptr) {
    return file->cache.seek_mmap_cache(off);
  }
  ssize_t r = 0;
  if (file->mode == O_WRONLY) {
    r = file->cache.seek_write_cache(file, off);
  } else {
    assert(file->mode == O_RDONLY);
    // place the sought location in the middle of the cache, which
    // accomodates both reads and writes
    // (but only when seeking behavior mirrors reverse reads)
    if (file->cache.cache_cursor - file->cache.cache_base < 8) {
      off_t front_extended = std::max(off - (CACHE_SIZE_BYTES / 2), (off_t)0);
      file->cache.seek_read_cache(file, front_extended);
    }
    r = file->cache.seek_read_cache(file, off);
  }
  if (r < 0) {
    return -1;
  }
  return 0;
}

// io61_readc(f)
//    Reads a single (unsigned) byte from `f` and returns it. Returns EOF,
//    which equals -1, on end of file or error.
int io61_readc(io61_file *file) {
  uint8_t ch;
  if (file->cache.mmap_base != nullptr) {
    return file->cache.read_mmap_cache(file, &ch, 1);
  }
  if (file->cache.cache_cursor < file->cache.cache_end_excl) {
    int res =
        file->cache.bytes[file->cache.cache_cursor - file->cache.cache_base];
    file->cache.cache_cursor++;
    return res;
  }
  ssize_t nr = io61_read(file, &ch, 1);
  if (nr == 1) {
    return ch;
  }
  if (nr == 0) {
    errno = 0; // clear `errno` to indicate EOF
  }
  return -1;
}

// io61_read(f, buf, sz)
//    Reads up to `sz` bytes from `f` into `buf`. Returns the number of
//    bytes read on success. Returns 0 if end-of-file is encountered before
//    any bytes are read, and -1 if an error is encountered before any
//    bytes are read.
//
//    Note that the return value might be positive, but less than `sz`,
//    if end-of-file or error is encountered before all `sz` bytes are read.
//    This is called a “short read.”
ssize_t io61_read(io61_file *file, unsigned char *buf, size_t sz) {
  if (file->cache.mmap_base != nullptr) {
    return file->cache.read_mmap_cache(file, buf, sz);
  }
  return file->cache.read_cache_block(file, buf, sz);
}

// io61_writec(f)
//    Write a single character `c` to `f` (converted to unsigned char).
//    Returns 0 on success and -1 on error.
int io61_writec(io61_file *file, int c) {
  uint8_t ch = c;
  ssize_t written = io61_write(file, &ch, 1);
  return std::min((int)written, 0);
}

// io61_write(f, buf, sz)
//    Writes `sz` characters from `buf` to `f`. Returns `sz` on success.
//    Can write fewer than `sz` characters when there is an error, such as
//    a drive running out of space. In this case io61_write returns the
//    number of characters written, or -1 if no characters were written
//    before the error occurred.
ssize_t io61_write(io61_file *file, const unsigned char *buf, size_t sz) {
  // size_t nwritten = write(file->fd, buf, sz);
  if (sz == 0) {
    return 0;
  }
  return file->cache.write_cache_block(file, buf, sz);
}

// io61_flush(f)
//    If `f` was opened write-only, `io61_flush(f)` forces a write of any
//    cached data written to `f`. Returns 0 on success; returns -1 if an error
//    is encountered before all cached data was written.
//
//    If `f` was opened read-only, `io61_flush(f)` returns 0. It may also
//    drop any data cached for reading.
int io61_flush(io61_file *file) {
  if (file->mode == O_RDONLY || file->cache.mmap_base != nullptr) {
    return 0;
  }
  assert(file->mode == O_WRONLY);
  ssize_t written = file->cache.flush_write_cache(file);
  return std::min((int)written, 0);
}

// io61_open_check(filename, mode)
//    Opens the file corresponding to `filename` and returns its io61_file.
//    If `!filename`, returns either the standard input or the
//    standard output, depending on `mode`. Exits with an error message if
//    `filename != nullptr` and the named file cannot be opened.
io61_file *io61_open_check(const char *filename, int mode) {
  int fd;
  if (filename) {
    fd = open(filename, mode, 0666);
  } else if ((mode & O_ACCMODE) == O_RDONLY) {
    fd = STDIN_FILENO;
  } else {
    fd = STDOUT_FILENO;
  }
  if (fd < 0) {
    fprintf(stderr, "%s: %s\n", filename, strerror(errno));
    exit(1);
  }
  return io61_fdopen(fd, mode & O_ACCMODE);
}

// io61_fileno(f)
//    Returns the file descriptor associated with `f`.
int io61_fileno(io61_file *file) { return file->fd; }

// io61_filesize(f)
//    Returns the size of `f` in bytes. Returns -1 if `f` does not have a
//    well-defined size (for instance, if it is a pipe).
off_t io61_filesize(io61_file *file) {
  struct stat s;
  int r = fstat(file->fd, &s);
  if (r >= 0 && S_ISREG(s.st_mode)) {
    return s.st_size;
  } else {
    return -1;
  }
}

/// RMW READ

/// Initializes a new read cache on a read only file.
void rwm_cache::init_read_cache(io61_file *file) {
  assert(file->mode == O_RDONLY);
  incr_read_cache(file);
  size_t cache_size = cache_end_excl - cache_base;
  cache_base = 0;
  cache_cursor = 0;
  cache_end_excl = cache_base + cache_size;
};

/// Moves a read cache to an arbitrary file location.
/// Requires that the cache is not nmap, the file is seekable, and the
/// file is in read mode.
/// Returns the number of new bytes read into the seeked cache or a
/// negative error code.
ssize_t rwm_cache::seek_read_cache(io61_file *file, off_t file_offset) {
  assert(mmap_base == nullptr);
  assert(file->file_v == file_variant::seekable);
  assert(file->mode == O_RDONLY);
  if (cache_base <= file_offset && file_offset < cache_end_excl) {
    // if the region is already in the cache, just move the cursor
    cache_cursor = file_offset;
    return cache_end_excl - file_offset;
  };
  off_t pos = lseek(file->fd, file_offset, SEEK_SET);
  if (pos < 0) {
    // an error was encountered when trying to seek
    return 0;
  }
  ssize_t bytes_read = read(file->fd, bytes, CACHE_SIZE_BYTES);
  cache_base = file_offset;
  cache_cursor = cache_base;
  cache_end_excl = cache_base + bytes_read;
  return bytes_read;
};

/// Moves a cache that is not memory mapped to the next chunk of
/// data.
/// The kernel's file pointer is positioned such that the next file
/// read will begin with the data following what this addds to the
/// cache.
ssize_t rwm_cache::incr_read_cache(io61_file *file) {
  assert(mmap_base == nullptr);
  assert(file->mode == O_RDONLY);
  ssize_t bytes_read = read(file->fd, bytes, CACHE_SIZE_BYTES);
  cache_base += CACHE_SIZE_BYTES;
  cache_cursor = cache_base;
  cache_end_excl = cache_base + bytes_read;
  return bytes_read;
};

/// Reads some number of bytes from a read mode cache that is not
/// memory mapped.
/// Returns the number of bytes read or a negative error code.
ssize_t rwm_cache::read_cache_block(io61_file *file, uint8_t *buf,
                                    size_t req_size) {
  assert(mmap_base == nullptr);
  assert(file->mode == O_RDONLY);
  if (CACHE_SIZE_BYTES < req_size) {
    // the request is too large to be served by any cache. Read the
    // entire request directly.
    off_t start_pos = lseek(file->fd, 0, SEEK_CUR);
    ssize_t bytes_read = read(file->fd, bytes, req_size);
    if (start_pos >= 0) {
      lseek(file->fd, 0, SEEK_SET);
    }
    return bytes_read;
  }

  size_t bytes_left_in_init_cache = cache_end_excl - cache_cursor;
  size_t served_from_initial_cache =
      std::min(bytes_left_in_init_cache, req_size);

  if (served_from_initial_cache > 0) {
    memcpy(buf, &bytes[cache_cursor - cache_base], served_from_initial_cache);
  }
  if (served_from_initial_cache == req_size) {
    // can serve the entire request from the cache
    cache_cursor += req_size;
    return req_size;
  }

  // need more data from the next cache block to serve the request
  ssize_t bytes_added_to_cache = incr_read_cache(file);
  ssize_t bytes_still_needed = req_size - served_from_initial_cache;
  ssize_t served_from_reloaded_cache =
      std::min(bytes_added_to_cache, bytes_still_needed);

  uint8_t *buf_offset = buf + served_from_initial_cache;
  memcpy(buf_offset, bytes, served_from_reloaded_cache);

  cache_cursor += served_from_reloaded_cache;
  return served_from_initial_cache + served_from_reloaded_cache;
};

/// RMW WRITE

/// Initializes a new write cache on a write only file.
void rwm_cache::init_write_cache(io61_file *file) {
  assert(file->mode == O_WRONLY);
  // lseek(file->fd, 0, SEEK_SET);
  cache_base = 0;
  cache_cursor = 0;
  cache_end_excl = cache_base + CACHE_SIZE_BYTES;
}

/// Moves a write cache to an arbitrary file location
/// requires that the cache is not nmap and the
/// file is in write mode.
/// Can be used to increment a non-seekable cache to the next
/// chunk of bytes.
/// Returns the number of bytes flushed from the cache or a
/// negative error code.
ssize_t rwm_cache::seek_write_cache(io61_file *file, off_t file_offset) {
  assert(mmap_base == nullptr);
  assert(cache_base <= cache_cursor);
  assert(file->mode == O_WRONLY);
  if (file_offset == cache_cursor && file_offset < cache_end_excl) {
    // cache is exactly where it needs to be, no need to flush
    return cache_end_excl - cache_cursor;
  }
  ssize_t expected_flush = cache_cursor - cache_base;
  ssize_t flushed = flush_write_cache(file);
  if (flushed < 0) {
    return flushed;
  }
  if (flushed != expected_flush) {
    return cleanup_partial_flush(flushed);
  }
  cache_cursor = cache_base;
  if (file->file_v == file_variant::seekable) {
    off_t pos = lseek(file->fd, file_offset, SEEK_SET);
    if (pos < 0) {
      return pos;
    }
  } else {
    // seek on an infinite file can only be used to move the cache
    // forward by one chunk
    assert(file->file_v == file_variant::unseekable);
    assert(cache_end_excl == file_offset);
  }
  cache_base = file_offset;
  cache_cursor = cache_base;
  cache_end_excl = cache_base + CACHE_SIZE_BYTES;
  return cache_end_excl - cache_base;
}

/// Writes an arbitrary amount of data to a write-mode cache
/// that is not memory mapped.
/// Returns the number of bytes written or a negative error code.
ssize_t rwm_cache::write_cache_block(io61_file *file, const uint8_t *buf,
                                     size_t req_size) {
  assert(mmap_base == nullptr);
  assert(file->mode == O_WRONLY);
  if (CACHE_SIZE_BYTES < req_size) {
    // request is too large to serve with the cache, write it directly
    off_t start_pos = lseek(file->fd, 0, SEEK_CUR);
    size_t bytes_written = write(file->fd, buf, req_size);
    if (start_pos >= 0) {
      lseek(file->fd, 0, SEEK_SET);
    }
    return bytes_written;
  }

  size_t bytes_left_in_init_cache = cache_end_excl - cache_cursor;

  size_t writeable_into_initial_cache =
      std::min(bytes_left_in_init_cache, req_size);

  if (writeable_into_initial_cache > 0) {
    assert(cache_cursor - cache_base < CACHE_SIZE_BYTES);
    memcpy(&bytes[cache_cursor - cache_base], buf,
           writeable_into_initial_cache);
    cache_cursor += writeable_into_initial_cache;
  }

  if (writeable_into_initial_cache == req_size) {
    // can serve the entire request from the cache
    return req_size;
  }

  // begin filling the next cache block
  assert(cache_cursor == cache_end_excl);
  ssize_t byte_capacity = seek_write_cache(file, cache_cursor);
  if (byte_capacity < 0) {
    // flush failed, undo and return error
    cache_cursor -= writeable_into_initial_cache;
    return byte_capacity;
  }
  ssize_t bytes_still_unwritten = req_size - writeable_into_initial_cache;
  ssize_t writeable_into_reloaded_cache =
      std::min(byte_capacity, bytes_still_unwritten);
  memcpy(bytes, &buf[writeable_into_initial_cache],
         writeable_into_reloaded_cache);
  cache_cursor += writeable_into_reloaded_cache;
  return writeable_into_initial_cache + writeable_into_reloaded_cache;
};

/// Attempts to write a cache's dirty bytes via a write syscall.
/// Returns the number of bytes written or a negative error code.
ssize_t rwm_cache::flush_write_cache(io61_file *file) {
  assert(cache_base <= cache_cursor);
  assert(file->mode == O_WRONLY);
  ssize_t bytes_to_flush = cache_cursor - cache_base;
  assert(bytes_to_flush >= 0);
  if (bytes_to_flush == 0) {
    return 0;
  }
  ssize_t bytes_written = write(file->fd, bytes, bytes_to_flush);
  if (bytes_written == -1) {
    return -1;
  }
  return bytes_written;
};

/// If a write syscall partially failed/succeeded, shifts the
/// cache past the written bytes but preserving unwritten bytes
/// as still pending a write.
/// Always returns -1. (If a flush failed, the caller should
/// probably try again).
ssize_t rwm_cache::cleanup_partial_flush(ssize_t flushed) {
  assert(flushed >= 0);
  assert(flushed < CACHE_SIZE_BYTES);
  cache_base += flushed;
  // cache_cursor = cache_end_excl;
  cache_end_excl = cache_base + CACHE_SIZE_BYTES;
  memcpy(bytes, &bytes[flushed], flushed);
  errno = EINTR;
  return -1;
}

/// RMW MMAP

/// Attempts to initialize an mmap cache on a given file.
/// Write-only files are automatically rejected, as mmap shared
/// requires read access as well.
/// Returns the size of the memory mapped file or a negative error
/// code.
ssize_t rwm_cache::init_mmap_cache(io61_file *file) {
  if (file->mode == O_WRONLY) {
    return -1;
  }
  off_t file_end = lseek(file->fd, 0, SEEK_END);
  if (file_end < 0) {
    return file_end;
  }
  off_t file_start = lseek(file->fd, 0, SEEK_SET);
  if (file_start < 0) {
    return file_start;
  }
  off_t file_size = file_end - file_start;
  if (file_size < 0) {
    return -1;
  }
  void *mmap_res = mmap(NULL, file_size, PROT_WRITE, MAP_SHARED, file->fd, 0);
  if (mmap_res == (void *)-1) {
    return -1;
  }
  mmap_base = (uint8_t *)mmap_res;
  mmap_cursor = mmap_base;
  mmap_end_excl = mmap_base + file_size;
  return file_size;
}

/// Repositions the pointer in an mmap cache. Does not modify
/// the kernel's underlying file pointer.
ssize_t rwm_cache::seek_mmap_cache(off_t file_offset) {
  assert(mmap_base != nullptr && mmap_cursor != nullptr &&
         mmap_end_excl != nullptr);
  if (mmap_end_excl <= mmap_base + file_offset) {
    return -1;
  }
  mmap_cursor = mmap_base + file_offset;
  return 0;
};

/// Reads an arbitrary number of bytes from an mmap cache.
/// Returns the number of read bytes or a negative error code
/// on failure.
ssize_t rwm_cache::read_mmap_cache(io61_file *file, uint8_t *buf, size_t size) {
  assert(mmap_base != nullptr && mmap_cursor != nullptr &&
         mmap_end_excl != nullptr);
  assert(file->mode == O_RDONLY);
  if (mmap_cursor == mmap_end_excl) {
    return 0;
  }
  assert(mmap_cursor < mmap_end_excl);
  uint8_t *end_addr = std::min(mmap_cursor + size, mmap_end_excl);
  ptrdiff_t served_bytes = end_addr - mmap_cursor;
  assert(served_bytes >= 0);
  memcpy(buf, mmap_cursor, served_bytes);
  mmap_cursor += served_bytes;
  return served_bytes;
};

// Leaving this in. What a great friend it has been:
// std::ofstream log_file("log.txt", std::ios_base::out);
// log_file << "pos: " << pos << std::endl;
