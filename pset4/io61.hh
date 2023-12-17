#ifndef IO61_HH
#define IO61_HH
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <random>
#include <sched.h>
#include <unistd.h>
#include <vector>

struct io61_file;

io61_file *io61_fdopen(int fd, int mode);
io61_file *io61_open_check(const char *filename, int mode);
int io61_fileno(io61_file *f);
int io61_close(io61_file *f);

off_t io61_filesize(io61_file *f);

int io61_seek(io61_file *f, off_t off);

int io61_readc(io61_file *f);
int io61_writec(io61_file *f, int c);

ssize_t io61_read(io61_file *f, unsigned char *buf, size_t sz);
ssize_t io61_write(io61_file *f, const unsigned char *buf, size_t sz);

int io61_flush(io61_file *f);

int fd_open_check(const char *filename, int mode);
FILE *stdio_open_check(const char *filename, int mode);

enum file_variant { seekable, unseekable };

const ssize_t CACHE_SIZE_BYTES = 4096 * 2;

/// A cache supporting Read only, Write only, and Memory Map
/// optimizations for engaging with io61_file files.
/// Method documentation is in the implementation file.
struct rwm_cache {
  // READ / WRITE
  uint8_t bytes[CACHE_SIZE_BYTES];
  off_t cache_base = 0;     // inclusive start position of the cache
  off_t cache_cursor = 0;   // points to next read / write byte
  off_t cache_end_excl = 0; // non-inclusive range

  // MMAP
  uint8_t *mmap_base = nullptr; // definitions parallel cache_* fields
  uint8_t *mmap_cursor = nullptr;
  uint8_t *mmap_end_excl = nullptr;

  // READ
  void init_read_cache(io61_file *file);
  ssize_t seek_read_cache(io61_file *file, off_t file_offset);
  ssize_t read_cache_block(io61_file *file, uint8_t *buf, size_t size);
  ssize_t incr_read_cache(io61_file *file);

  // WRITE
  void init_write_cache(io61_file *file);
  ssize_t seek_write_cache(io61_file *file, off_t file_offset);
  ssize_t write_cache_block(io61_file *file, const uint8_t *buf, size_t size);
  ssize_t flush_write_cache(io61_file *file);
  ssize_t cleanup_partial_flush(ssize_t flushed);

  // MMAP
  ssize_t init_mmap_cache(io61_file *file);
  ssize_t seek_mmap_cache(off_t file_offset);
  ssize_t read_mmap_cache(io61_file *file, uint8_t *buf, size_t size);
};

struct io61_args {
  size_t file_size = SIZE_MAX;            // `-s`: file size
  size_t block_size = 0;                  // `-b`: block size
  size_t initial_offset = 0;              // `-p`: initial offset
  size_t stride = 1024;                   // `-t`: stride
  bool lines = false;                     // `-l`: read by lines
  bool flush = false;                     // `-F`: flush output
  bool quiet = false;                     // `-q`: ignore errors
  unsigned yield = 0;                     // `-y`: yield after output
  const char *output_file = nullptr;      // `-o`: output file
  const char *input_file = nullptr;       // input file
  std::vector<const char *> input_files;  // all input files
  std::vector<const char *> output_files; // all output files
  const char *program_name;               // name of program
  const char *opts;                       // options string
  std::mt19937 engine;                    // source of randomness
  unsigned seed;                          // `-r`: random seed
  double delay = 0.0;                     // `-D`: delay
  size_t pipebuf_size = 0;                // `-B`: pipe buffer size
  bool nonblocking = false;               // `-n`: nonblocking

  explicit io61_args(const char *opts, size_t block_size = 0);

  io61_args &set_block_size(size_t bs);
  io61_args &set_seed(unsigned seed);
  io61_args &parse(int argc, char **argv);

  void usage();

  // Call this after opening files (`-B`/`-D`).
  void after_open();
  void after_open(int fd, int mode);
  void after_open(io61_file *f, int mode);
  void after_open(FILE *f, int mode);
  // Call this after writing one block of data.
  void after_write(int fd);
  void after_write(io61_file *f);
  void after_write(FILE *f);
};

#endif
