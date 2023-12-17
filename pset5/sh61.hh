#ifndef SH61_HH
#define SH61_HH
#include <cassert>
#include <csignal>
#include <cstdio>
#include <cstdlib>
#include <fcntl.h>
#include <string>
#include <unistd.h>
#include <vector>

#define TYPE_NORMAL 0      // normal command word
#define TYPE_REDIRECT_OP 1 // redirection operator (>, <, 2>)

// All other tokens are control operators that terminate the current command.
#define TYPE_SEQUENCE 2   // `;` sequence operator
#define TYPE_BACKGROUND 3 // `&` background operator
#define TYPE_PIPE 4       // `|` pipe operator
#define TYPE_AND 5        // `&&` operator
#define TYPE_OR 6         // `||` operator

// If you want to handle an extended shell syntax for extra credit, here are
// some other token types to get you started.
#define TYPE_LPAREN 7 // `(` operator
#define TYPE_RPAREN 8 // `)` operator
#define TYPE_OTHER -1

struct shell_token_iterator;

/// Command: The semantic unit user input is parsed into.
///
/// Commands act like nodes in a tree. The tree is
/// shaped like a comb, where each tooth of the comb
/// is a synchronous **sequence** of **commands**.
///
/// The first node in a sequence determines the blocking behavior
/// of the sequence. If a sequence is marked as async, it's delegated
/// to a separate process, and the shell's main process
/// proceeds to the child. If a sequence is sychronous, the shell
/// will run the entire sequence before moving on.
struct command {

  /// sequential: run this command like normal
  /// if_ok: run this command in compliance with && behavior
  /// if_err: run this command in compliance with || behavior
  enum cmd_type { sequential, if_ok, if_err };

  /// run_sync: run this sequence from the main shell process (;)
  /// run_async: run this sequence from a detached subprocess (&)
  /// defer: defer this sequence type to the head command of the sequence
  enum seq_type { run_sync, run_async, defer };

  /// Specifies file redirection behavior for a process.
  /// Assigned integers correspond to indices in the
  /// redir_cfg array.
  enum redir_type { r_stdin = 0, r_stdout = 1, r_stderr = 2, r_none = 3 };

  /// Specifies a redirection target for a command.
  struct redir_config {
    redir_type redir_t;
    std::string filename;
  };

  /// The cli arguments associated with this command.
  std::vector<std::string> args;

  /// The ID of the process running this command. -1 if inactive.
  pid_t pid = -1;

  /// The next command in the same sequence.
  command *next = nullptr;

  /// The first command in the next sequence.
  command *child = nullptr;

  /// The file descriptor piped into this process. -1 assumes stdin.
  int pipe_into_proc = -1;

  /// The file descriptor piped out of this process. -1 assumes stdout.
  int pipe_out_of_proc = -1;

  /// An array of structs configuring redirection for stdin,
  /// stdout, and stderr
  redir_config redir_cfg[3];

  /// The type of execution behavior this command should have.
  cmd_type cmd_tp;

  /// The type of execution behavior this sequence should have.
  seq_type seq_tp;

  command(cmd_type cmd_config, seq_type seq_config)
      : redir_cfg{{redir_type::r_none, ""},
                  {redir_type::r_none, ""},
                  {redir_type::r_none, ""}},
        cmd_tp(cmd_config), seq_tp(seq_config){};

  command(cmd_type cmd_config) : command(cmd_config, seq_type::defer){};

  /// Destroys all vertical and horizontal neighbors.
  ~command();

  /// PUBLIC METHODS

  /// Runs all command sequences beginning from this command.
  void run_list();

  /// Attaches a redirection configuration to the
  /// command struct. Duplicate redirections on a single
  /// command will cause a failure.
  int attach_redir(redir_type new_redir, std::string filename);

private:
  // SEQUENCE MANAGEMENT

  /// Runs an entire sequence in its own process.
  /// Returns the PID of the spawned process.
  int delegate_seq_to_subprocess();

  /// Executes the commands in a horizontal synchronous sequence.
  int run_seq();

  /// Closes all pipes in a sequence.
  /// Doesn't interfere with children.
  /// Doesn't free any memory, just closes pipes and
  /// updates command pipe file descriptors accordingly.
  void close_seq_pipes();

  // COMMAND MANAGEMENT

  /// Runs an executable command in a separate process.
  /// Returns an error code that's only relevant if the
  /// command executed was `cd`. Otherwise, waitpid on the
  /// process ID will yield the exit status.
  int run();

  /// Sets up IO pipes for a process about to exec.
  void setup_pipes();

  /// Sets up file redirection for a process about to exec.
  /// If redirections are present, opens files and sets up
  /// the data flow. Inspects stdin, stdout, and stderr config.
  /// Because redirections have greater precedence than pipes,
  /// conflicting pipes will be ignored.
  void setup_redirections();

  // HELPER METHODS

  /// Walks a list of commands, skipping every command for which
  /// `should skip` returns true.
  static command *skip_conds(command *curr, bool (*should_skip)(command *cmd));

  /// Returns true until reaching the end or a
  /// command that can follow an error return code.
  static bool seek_after_err(command *cmd);

  /// Returns true until reaching th end or a command
  /// that can follow an ok return code.
  static bool seek_after_ok(command *cmd);

  // DEBUG METHODS

  /// Pretty prints info about the command.
  void print_cmd();

  /// Stringifies the arguments held by a command.
  std::string list_args();

  /// Serializes a cmd_type enum.
  std::string serialize_cmd_type(cmd_type cmd_tp);

  /// Serializes a seq_type enum.
  std::string serialize_seq_type(seq_type seq_tp);
};

// shell_parser
//    `shell_parser` objects represent a command line.
//    See `shell_token_iterator` for more.

struct shell_parser {
  shell_parser(const char *str);

  inline shell_token_iterator begin() const;
  inline shell_token_iterator end() const;

private:
  const char *_str;
  const char *_estr;
};

// shell_token_iterator
//    `shell_token_iterator` represents a token in a command line via a
//    C++ iterator-like interface. Use it as follows:
//
//    ```
//    shell_parser parser("... command line string ...");
//    for (auto it = parser.begin(); it != parser.end(); ++it) {
//        // `it` is a shell_token_iterator; it iterates over the words
//        // and operators in the command line.
//        // `it.type()` returns the current token’s type, which is one of
//        // the `TYPE_` constants.
//        // `it.str()` returns a C++ string holding the current token’s
//        // character contents.
//    }
//    ```

struct shell_token_iterator {
  std::string str() const; // current token’s character contents
  inline int type() const; // current token’s type

  // compare iterators
  inline bool operator==(const shell_token_iterator &x) const;
  inline bool operator!=(const shell_token_iterator &x) const;

  inline void operator++(); // advance `this` to next token

private:
  const char *_s;
  unsigned short _type;
  bool _quoted;
  unsigned _len;

  inline shell_token_iterator(const char *s);
  void update();
  friend struct shell_parser;
};

// claim_foreground(pgid)
//    Mark `pgid` as the current foreground process group.
int claim_foreground(pid_t pgid);

// set_signal_handler(signo, handler)
//    Install handler `handler` for signal `signo`. `handler` can be SIG_DFL
//    to install the default handler, or SIG_IGN to ignore the signal. Return
//    0 on success, -1 on failure. See `man 2 sigaction` or `man 3 signal`.
inline int set_signal_handler(int signo, void (*handler)(int)) {
  struct sigaction sa;
  sa.sa_handler = handler;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags = 0;
  return sigaction(signo, &sa, NULL);
}

inline shell_token_iterator shell_parser::begin() const {
  return shell_token_iterator(_str);
}

inline shell_token_iterator shell_parser::end() const {
  return shell_token_iterator(_estr);
}

inline shell_token_iterator::shell_token_iterator(const char *s) : _s(s) {
  update();
}

inline int shell_token_iterator::type() const { return _type; }

inline bool
shell_token_iterator::operator==(const shell_token_iterator &x) const {
  return _s == x._s;
}

inline bool
shell_token_iterator::operator!=(const shell_token_iterator &x) const {
  return _s != x._s;
}

inline void shell_token_iterator::operator++() {
  _s += _len;
  update();
}

#endif
