#include "u-lib.hh"

// sys_getpid
//    Return current process ID.
__noinline pid_t sys_getpid() {
    return make_syscall(SYSCALL_GETPID);
}

// sys_yield
//    Yield control of the CPU to the kernel. The kernel will pick another
//    process to run, if possible.
__noinline int sys_yield() {
    return make_syscall(SYSCALL_YIELD);
}

// sys_page_alloc(addr)
//    Allocate a page of memory at address `addr`. The newly-allocated
//    memory is initialized to 0. Any memory previously located at `addr`
//    should be freed. Returns 0 on success and -1 on failure (out of
//    memory or invalid argument).
//
//    `Addr` should be page-aligned (i.e., a multiple of PAGESIZE == 4096),
//    >= PROC_START_ADDR, and < MEMSIZE_VIRTUAL.
__noinline int sys_page_alloc(void* addr) {
    return make_syscall(SYSCALL_PAGE_ALLOC, (uintptr_t) addr);
}

// sys_getsysname()
//    Write the name of the current OS into `buf`.
__noinline int sys_getsysname(char* buf) {
    return make_syscall(SYSCALL_GETSYSNAME, (uintptr_t) buf);
}

// sys_spawn(commandname)
//    Start a new process running `command` and return its PID.
__noinline pid_t sys_spawn(const char* command) {
    return make_syscall(SYSCALL_SPAWN, (uintptr_t) command);
}

// sys_pipewrite(buf, sz)
//    Write data to pipe from `buf`. Writes at most `sz` bytes.
//    Returns number of bytes written or -1 on error.
__noinline ssize_t sys_pipewrite(const void* buf, size_t sz) {
    return make_syscall(SYSCALL_PIPEWRITE, (uintptr_t) buf, sz);
}

// sys_piperead(buf, sz)
//    Read data from pipe into `buf`. Reads at most `sz` bytes.
//    Returns number of bytes read or -1 on error.
__noinline ssize_t sys_piperead(void* buf, size_t sz) {
    return make_syscall(SYSCALL_PIPEREAD, (uintptr_t) buf, sz);
}


// sys_panic(msg)
//    Panic.
[[noreturn]] __noinline void sys_panic(const char* msg) {
    make_syscall(SYSCALL_PANIC, (uintptr_t) msg);

    // should never get here
    while (true) {
    }
}


// panic, assert_fail
//     Call the SYSCALL_PANIC system call so the kernel loops until Control-C.

void panic(const char* format, ...) {
    va_list val;
    va_start(val, format);
    char buf[240];
    int len = vsnprintf(buf, sizeof(buf) - 1, format, val);
    va_end(val);
    if (len > 0 && buf[len - 1] != '\n') {
        strcpy(buf + len - (len == (int) sizeof(buf) - 1), "\n");
    }
    sys_panic(buf);
}

int error_vprintf(int cpos, int color, const char* format, va_list val) {
    return console_vprintf(cpos, color, format, val);
}

void assert_fail(const char* file, int line, const char* msg,
                 const char* description) {
    cursorpos = CPOS(23, 0);
    char buf[240];
    if (description) {
        snprintf(buf, sizeof(buf),
                 "%s:%d: %s\n%s:%d: user assertion '%s' failed\n",
                 file, line, description, file, line, msg);
    } else {
        snprintf(buf, sizeof(buf),
                 "%s:%d: user assertion '%s' failed\n",
                 file, line, msg);
    }
    sys_panic(buf);
}
