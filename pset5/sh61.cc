#include "sh61.hh"
#include <cassert>
#include <cerrno>
#include <cstddef>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <limits.h>
#include <string>
#include <sys/fcntl.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <vector>

#undef exit
#define exit __DO_NOT_CALL_EXIT__READ_PROBLEM_SET_DESCRIPTION__

/// Parses user input into a command tree that can be run.
command *parse_line(const char *s) {
  shell_parser parser(s);

  command *head_init_seq = nullptr;
  command *head_curr_seq = nullptr;
  command *curr_cmd = nullptr;

  for (shell_token_iterator it = parser.begin(); it != parser.end(); ++it) {
    if (!curr_cmd) {
      curr_cmd = new command(command::cmd_type::sequential,
                             command::seq_type::run_sync);
    }
    if (!head_init_seq) {
      assert(curr_cmd);
      head_init_seq = curr_cmd;
      head_curr_seq = curr_cmd;
    }
    std::string token = it.str();
    if (token == "") {
      continue;
    }
    assert(curr_cmd != nullptr);
    if (it.type() == TYPE_NORMAL) {
      curr_cmd->args.push_back(it.str());
      continue;
    }
    assert(curr_cmd->args.size() > 0);
    // redirections
    // for redirections, the last entry appended to the args will be
    // the filename
    if (token == "<") {
      ++it;
      assert(it != parser.end() && it.type() == TYPE_NORMAL);
      curr_cmd->attach_redir(command::redir_type::r_stdin, it.str());
      continue;
    }
    if (token == ">") {
      ++it;
      assert(it != parser.end() && it.type() == TYPE_NORMAL);
      curr_cmd->attach_redir(command::redir_type::r_stdout, it.str());
      continue;
    }
    if (token == "2>") {
      ++it;
      assert(it != parser.end());
      curr_cmd->attach_redir(command::redir_type::r_stderr, it.str());
      continue;
    }
    // operations
    if (token == "&&") {
      command *next_cmd = new command(command::cmd_type::if_ok);
      curr_cmd->next = next_cmd;
      curr_cmd = next_cmd;
      continue;
    }
    if (token == "||") {
      command *next_cmd = new command(command::cmd_type::if_err);
      curr_cmd->next = next_cmd;
      curr_cmd = next_cmd;
      continue;
    }
    if (token == "|") {
      int pipe_fds[2];
      int pipe_res = pipe(pipe_fds);
      if (pipe_res != 0) {
        fprintf(stderr, "failed to create a new pipe: %d\n", pipe_res);
        _exit(1);
      }
      int write_side = pipe_fds[1];
      int read_side = pipe_fds[0];

      curr_cmd->pipe_out_of_proc = write_side;
      command *next_cmd = new command(command::cmd_type::sequential);
      next_cmd->pipe_into_proc = read_side;
      curr_cmd->next = next_cmd;
      curr_cmd = next_cmd;
      continue;
    }
    if (token == ";") {
      // semicolons start a new command sequence
      curr_cmd->next = nullptr;
      command *next_cmd = new command(command::cmd_type::sequential,
                                      command::seq_type::run_sync);
      assert(head_curr_seq && !head_curr_seq->child);
      head_curr_seq->child = next_cmd;
      head_curr_seq = next_cmd;
      curr_cmd = next_cmd;
      continue;
    }
    if (token == "&") {
      // ampersands start a new command thread, marking the
      // previous thread as an async process
      curr_cmd->next = nullptr;
      command *next_cmd = new command(command::cmd_type::sequential,
                                      command::seq_type::run_sync);
      assert(head_curr_seq && !head_curr_seq->child);
      head_curr_seq->seq_tp = command::seq_type::run_async;
      head_curr_seq->child = next_cmd;
      head_curr_seq = next_cmd;
      curr_cmd = next_cmd;
      continue;
    }
  }
  return head_init_seq;
}

int main(int argc, char *argv[]) {
  FILE *command_file = stdin;
  bool quiet = false;

  // Check for `-q` option: be quiet (print no prompts)
  if (argc > 1 && strcmp(argv[1], "-q") == 0) {
    quiet = true;
    --argc, ++argv;
  }

  // Check for filename option: read commands from file
  if (argc > 1) {
    command_file = fopen(argv[1], "rb");
    if (!command_file) {
      perror(argv[1]);
      return 1;
    }
  }

  // - Put the shell into the foreground
  // - Ignore the SIGTTOU signal, which is sent when the shell is put back
  //   into the foreground
  claim_foreground(0);
  set_signal_handler(SIGTTOU, SIG_IGN);

  char buf[BUFSIZ];
  int bufpos = 0;
  bool needprompt = true;

  while (!feof(command_file)) {
    // Print the prompt at the beginning of the line
    if (needprompt && !quiet) {
      printf("sh61[%d]$ ", getpid());
      fflush(stdout);
      needprompt = false;
    }

    // Read a string, checking for error or EOF
    if (fgets(&buf[bufpos], BUFSIZ - bufpos, command_file) == nullptr) {
      if (ferror(command_file) && errno == EINTR) {
        // ignore EINTR errors
        clearerr(command_file);
        buf[bufpos] = 0;
      } else {
        if (ferror(command_file)) {
          perror("sh61");
        }
        break;
      }
    }

    // If a complete command line has been provided, run it
    bufpos = strlen(buf);
    if (bufpos == BUFSIZ - 1 || (bufpos > 0 && buf[bufpos - 1] == '\n')) {
      if (command *c = parse_line(buf)) {
        c->run_list();
        delete c;
      }
      bufpos = 0;
      needprompt = 1;
    }

    // Handle zombie processes and/or interrupt requests
    // Your code here!
    int status;
    while (waitpid(-1, &status, WNOHANG) > 0) {
    };
  }

  return 0;
}

// COMMAND STRUCT IMPLEMENTATION

/// Destructor also frees all vertical and
/// horizontal neighbors.
command::~command() {
  if (0 <= pipe_into_proc) {
    close(pipe_into_proc);
  }
  if (0 <= pipe_out_of_proc) {
    close(pipe_out_of_proc);
  }
  if (next) {
    delete next;
  }
  if (child) {
    delete child;
  }
}

// PUBLIC METHODS

/// Runs all command sequences beginning from this command.
void command::run_list() {
  if (seq_tp == seq_type::run_async) {
    int subproc_pid = delegate_seq_to_subprocess();
    assert(0 < subproc_pid);
    close_seq_pipes();
    if (child) {
      return child->run_list();
    }
  }
  // sequence heads cannot defer their sequence type
  assert(seq_tp == seq_type::run_sync);
  run_seq();
  // close pipes for every sequence we run
  close_seq_pipes();
  if (child) {
    return child->run_list();
  }
}

/// Attaches a redirection configuration to the
/// command struct. Duplicate redirections on a single
/// command will cause a failure.
int command::attach_redir(redir_type new_redir, std::string filename) {
  if (new_redir == redir_type::r_none) {
    return -1;
  }
  redir_config *curr = &redir_cfg[new_redir];
  assert(curr->redir_t == redir_type::r_none);
  curr->redir_t = new_redir;
  curr->filename = filename;
  return 0;
}

// SEQUENCE MANAGEMENT

/// Runs an entire sequence in its own process.
/// Returns the PID of the spawned process.
int command::delegate_seq_to_subprocess() {
  int spawned_pid = fork();
  if (spawned_pid < 0) {
    fprintf(stderr, "failed to fork child process\n");
    _exit(1);
  }
  if (spawned_pid == 0) {
    // child

    // only run a single sequence in the subprocess, release
    // any other sequences that may follow
    command *prev_child = child;
    child = nullptr;
    delete prev_child;

    int exit_code = run_seq();
    _exit(exit_code);
  }
  // parent
  // zombies here
  return spawned_pid;
}

/// Executes the commands in a horizontal synchronous sequence.
int command::run_seq() {
  if (args.size() == 0) {
    return 0;
  }

  int status = run();

  if (0 <= pipe_out_of_proc) {
    // run the next command in the pipeline right away
    assert(next);
    return next->run_seq();
  }

  if (args.at(0) != "cd") {
    pid_t exited_pid = waitpid(pid, &status, 0);
    assert(exited_pid == pid);
  }

  if (!next) {
    return 0;
  }

  if (next->cmd_tp == cmd_type::sequential) {
    return next->run_seq();
  }

  if (next->cmd_tp == cmd_type::if_ok) {
    if (status == 0 || (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
      return next->run_seq();
    }
    command *next_not_ok = skip_conds(next, seek_after_err);
    if (next_not_ok) {
      return next_not_ok->run_seq();
    }
    return 0;
  }

  if (next->cmd_tp == cmd_type::if_err) {
    if (status == -1 || !WIFEXITED(status) || WEXITSTATUS(status) != 0) {
      return next->run_seq();
    }
    command *next_not_err = skip_conds(next, seek_after_ok);
    if (next_not_err) {
      return next_not_err->run_seq();
    }
    return 0;
  }

  // the cases above should have been exhaustive; they're in `if` blocks
  // for explicitness of intention.
  assert(false);
}

/// Closes all pipes in a sequence.
/// Doesn't interfere with children.
/// Doesn't free any memory, just closes pipes and
/// updates command pipe file descriptors accordingly.
void command::close_seq_pipes() {
  if (0 <= pipe_into_proc) {
    close(pipe_into_proc);
    pipe_into_proc = -1;
  }
  if (0 <= pipe_out_of_proc) {
    close(pipe_out_of_proc);
    pipe_out_of_proc = -1;
  }
  if (next) {
    return next->close_seq_pipes();
  }
}

// COMMAND MANAGEMENT

/// Runs an executable command in a separate process.
/// Returns an error code that's only relevant if the
/// command executed was `cd`. Otherwise, waitpid on the
/// process ID will yield the exit status.
int command::run() {
  assert(pid == -1);
  assert(args.size() > 0);

  if (args[0] == "cd") {
    return chdir(args.at(1).c_str());
  }

  int child_pid = fork();
  if (child_pid == -1) {
    // fork failed
    fprintf(stderr, "failed to spawn a child process\n");
    _exit(1);
  }

  if (child_pid != 0) {
    // parent
    pid = child_pid;
    // close file descriptors that are no longer needed by the parent
    if (0 <= pipe_into_proc) {
      close(pipe_into_proc);
    }
    if (0 <= pipe_out_of_proc) {
      close(pipe_out_of_proc);
    }
    return 0;
  }

  // child

  setup_pipes();
  setup_redirections();

  // set up child process arguments
  int arg_sz = args.size();
  const char *child_args[arg_sz + 1];
  for (int ind = 0; ind < arg_sz; ind++) {
    child_args[ind] = args.at(ind).c_str();
  }
  child_args[arg_sz] = nullptr;
  const char *path = args.at(0).c_str();
  execvp(path, (char **)child_args);
  fprintf(stderr, "unable to locate executable: %s\n", path);
  _exit(1);
}

/// Sets up IO pipes for a process about to exec.
void command::setup_pipes() {
  if (0 <= pipe_into_proc) {
    int dup_res = dup2(pipe_into_proc, STDIN_FILENO);
    if (dup_res < 0) {
      fprintf(stderr, "unable to redirect proc inward pipe\n");
      _exit(1);
    }
  }
  if (0 <= pipe_out_of_proc) {
    int dup_res = dup2(pipe_out_of_proc, STDOUT_FILENO);
    if (dup_res < 0) {
      fprintf(stderr, "unable to redirect proc outward pipe\n");
      _exit(1);
    }
  }
}

/// Sets up file redirection for a process about to exec.
/// If redirections are present, opens files and sets up
/// the data flow. Inspects stdin, stdout, and stderr config.
/// Because redirections have greater precedence than pipes,
/// conflicting pipes will be ignored.
void command::setup_redirections() {
  // Style note, this is repetitive and should be refactored. However,
  // there isn't a clear path in my opinion, and I'd rather do extra credit.
  if (args.size() == 0) {
    fprintf(stderr, "redirection failed, must provide a filepath\n");
    _exit(1);
  }

  redir_config *redir_stdin = &redir_cfg[redir_type::r_stdin];
  redir_config *redir_stdout = &redir_cfg[redir_type::r_stdout];
  redir_config *redir_stderr = &redir_cfg[redir_type::r_stderr];

  if (redir_stdin->redir_t == redir_type::r_stdin) {
    int redir_stdin_fd = open(redir_stdin->filename.c_str(), O_RDONLY);
    if (redir_stdin_fd < 0) {
      fprintf(stderr, "No such file or directory\n");
      _exit(1);
    }

    int dup_res = dup2(redir_stdin_fd, STDIN_FILENO);
    assert(dup_res >= 0);

    if (0 <= pipe_into_proc) {
      close(pipe_into_proc);
      pipe_into_proc = -1;
    }
  }

  if (redir_stdout->redir_t == redir_type::r_stdout) {
    int redir_stdout_fd = open(redir_stdout->filename.c_str(),
                               O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR);
    if (redir_stdout_fd < 0) {
      fprintf(stderr, "No such file or directory\n");
      _exit(1);
    }

    int dup_res = dup2(redir_stdout_fd, STDOUT_FILENO);
    assert(dup_res >= 0);

    if (0 <= pipe_out_of_proc) {
      close(pipe_out_of_proc);
      pipe_out_of_proc = -1;
    }
  }

  if (redir_stderr->redir_t == redir_type::r_stderr) {
    int redir_err_fd = open(redir_stderr->filename.c_str(), O_WRONLY | O_CREAT,
                            S_IRUSR | S_IWUSR);
    if (redir_err_fd < 0) {
      fprintf(stderr, "No such file or directory\n");
      _exit(1);
    }

    int dup_res = dup2(redir_err_fd, STDERR_FILENO);
    assert(dup_res >= 0);

    if (0 <= pipe_out_of_proc) {
      close(pipe_out_of_proc);
      pipe_out_of_proc = -1;
    }
  }
};

// HELPER METHODS

/// Walks a list of commands, skipping every command for which
/// `should skip` returns true.
command *command::skip_conds(command *curr, bool (*should_skip)(command *cmd)) {
  while (curr && should_skip(curr)) {
    curr = curr->next;
  }
  return curr;
}

/// Returns true until reaching the end or a
/// command that can follow an error return code.
bool command::seek_after_err(command *cmd) {
  if (cmd == nullptr) {
    return false;
  }
  return cmd->cmd_tp != cmd_type::if_err;
}

/// Returns true until reaching th end or a command
/// that can follow an ok return code.
bool command::seek_after_ok(command *cmd) {
  if (cmd == nullptr) {
    return false;
  }
  return cmd->cmd_tp != cmd_type::if_ok;
}

// DEBUG METHODS

/// Pretty prints info about the command.
void command::print_cmd() {
  printf("\n\
\033[0;35mpid: %d,\n\
self: %p,\n\
next: %p,\n\
child: %p,\n\
cmd_type: %s,\n\
seq_type: %s,\n\
pipe_into_proc: %d,\n\
pipe_out_of_proc: %d,\n\
args: %s\033[0m\n",
         pid, (void *)this, next, child, serialize_cmd_type(cmd_tp).c_str(),
         serialize_seq_type(seq_tp).c_str(), pipe_into_proc, pipe_out_of_proc,
         list_args().c_str());
};

/// Stringifies the arguments held by a command.
std::string command::list_args() {
  std::string str_args = "[";
  for (size_t ind = 0; ind < args.size(); ind++) {
    str_args.append(args[ind]);
    if (ind != args.size() - 1) {
      str_args.append(", ");
    }
  }
  str_args.append("];");
  return str_args;
};

/// Serializes a cmd_type enum.
std::string command::serialize_cmd_type(cmd_type variant) {
  if (variant == cmd_type::sequential) {
    return "cmd_type::sequential";
  }
  if (variant == cmd_type::if_ok) {
    return "cmd_type::if_ok";
  }
  if (variant == cmd_type::if_err) {
    return "cmd_type::if_err";
  }
  // cases should have been exhaustive
  assert(false);
}

/// Serializes a seq_type enum.
std::string command::serialize_seq_type(seq_type variant) {
  if (variant == seq_type::run_async) {
    return "seq_type::run_async";
  }
  if (variant == seq_type::run_sync) {
    return "seq_type::run_sync";
  }
  if (variant == seq_type::defer) {
    return "seq_type::defer";
  }
  // cases should have been exhaustive
  assert(false);
}
