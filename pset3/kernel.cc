#include "kernel.hh"
#include "atomic.hh"
#include "k-apic.hh"
#include "k-vmiter.hh"
#include "lib.hh"
#include "obj/k-firstprocess.h"
#include "x86-64.h"

// kernel.cc
//
//    This is the kernel.

// INITIAL PHYSICAL MEMORY LAYOUT
//
//  +-------------- Base Memory --------------+
//  v                                         v
// +-----+--------------------+----------------+--------------------+---------/
// |     | Kernel      Kernel |       :    I/O | App 1        App 1 | App 2
// |     | Code + Data  Stack |  ...  : Memory | Code + Data  Stack | Code ...
// +-----+--------------------+----------------+--------------------+---------/
// 0  0x40000              0x80000 0xA0000 0x100000             0x140000
//                                             ^
//                                             | \___ PROC_SIZE ___/
//                                      PROC_START_ADDR

#define PROC_SIZE 0x40000 // initial state only

proc ptable[PID_MAX]; // array of process descriptors
                      // Note that `ptable[0]` is never used.
proc *current;        // pointer to currently executing proc

#define HZ 100 // timer interrupt frequency (interrupts/sec)
static atomic<unsigned long> ticks; // # timer interrupts so far

// Memory state - see `kernel.hh`
physpageinfo physpages[NPAGES];

[[noreturn]] void schedule();
[[noreturn]] void run(proc *p);
void exception(regstate *regs);
void memshow();
uintptr_t syscall(regstate *regs);
int syscall_page_alloc(uintptr_t addr);
int syscall_fork();
int syscall_exit();

// kernel_start(command)
//    Initialize the hardware and processes and start running. The `command`
//    string is an optional string passed from the boot loader.

static void process_setup(pid_t pid, const char *program_name);

void kernel_start(const char *command) {
  // initialize hardware
  init_hardware();
  log_printf("Starting WeensyOS\n");

  ticks = 1;
  init_timer(HZ);

  // clear screen
  console_clear();

  // (re-)initialize kernel page table
  for (uintptr_t addr = 0; addr < MEMSIZE_PHYSICAL; addr += PAGESIZE) {
    int perm = PTE_P | PTE_W;
    if (addr == CONSOLE_ADDR || addr >= PROC_START_ADDR) {
      perm |= PTE_U;
    }
    if (addr == 0) {
      // nullptr is inaccessible even to the kernel
      perm = 0;
    }
    // install identity mapping
    int r = vmiter(kernel_pagetable, addr).try_map(addr, perm);
    assert(r == 0); // mappings during kernel_start MUST NOT fail
                    // (Note that later mappings might fail!!)
  }

  // set up process descriptors
  for (pid_t i = 0; i < PID_MAX; i++) {
    ptable[i].pid = i;
    ptable[i].state = P_FREE;
  }
  if (!command) {
    command = WEENSYOS_FIRST_PROCESS;
  }
  if (!program_image(command).empty()) {
    process_setup(1, command);
  } else {
    process_setup(1, "allocator");
    process_setup(2, "allocator2");
    process_setup(3, "allocator3");
    process_setup(4, "allocator4");
  }

  // switch to first process using run()
  run(&ptable[1]);
}

/// Given an address to an already-allocated physical page, increments
/// the counter and returns a pointer to the page.
/// Will error if phys_addr doesn't reference an allocated page
void *kborrow(uintptr_t phys_addr) {
  int pageno = phys_addr / PAGESIZE;
  uintptr_t unsigned_pageno = pageno;
  assert(0 <= pageno && unsigned_pageno < NPAGES);
  assert(pageno * PAGESIZE == phys_addr);
  // ^ the page index survives integer division
  assert(physpages[pageno].refcount > 0);
  // ^ cannot borrow an unallocated page
  physpages[pageno].refcount++;
  return (void *)phys_addr;
}

// kalloc(sz)
//    Kernel physical memory allocator. Allocates at least `sz` contiguous bytes
//    and returns a pointer to the allocated memory, or `nullptr` on failure.
//    The returned pointer’s address is a valid physical address, but since the
//    WeensyOS kernel uses an identity mapping for virtual memory, it is also a
//    valid virtual address that the kernel can access or modify.
//
//    The allocator selects from physical pages that can be allocated for
//    process use (so not reserved pages or kernel data), and from physical
//    pages that are currently unused (`physpages[N].refcount == 0`).
//
//    On WeensyOS, `kalloc` is a page-based allocator: if `sz > PAGESIZE`
//    the allocation fails; if `sz < PAGESIZE` it allocates a whole page
//    anyway.
//
//    The returned memory is initially filled with 0xCC, which corresponds to
//    the `int3` instruction. Executing that instruction will cause a `PANIC:
//    Unhandled exception 3!` This may help you debug.

void *kalloc(size_t sz) {
  if (sz > PAGESIZE) {
    return nullptr;
  }

  int pageno = 0;
  // When the loop starts from page 0, `kalloc` returns the first free page.
  // Alternate search strategies can be faster and/or expose bugs elsewhere.
  // This initialization returns a random free page:
  //     int pageno = rand(0, NPAGES - 1);
  // This initialization remembers the most-recently-allocated page and
  // starts the search from there:
  //     static int pageno = 0;

  for (int tries = 0; tries != NPAGES; ++tries) {
    uintptr_t pa = pageno * PAGESIZE;
    if (allocatable_physical_address(pa) && physpages[pageno].refcount == 0) {
      ++physpages[pageno].refcount;
      memset((void *)pa, 0xCC, PAGESIZE);
      return (void *)pa;
    }
    pageno = (pageno + 1) % NPAGES;
  }

  return nullptr;
}

// kfree(kptr)
//    Free `kptr`, which must have been previously returned by `kalloc`.
//    If `kptr == nullptr` does nothing.

void kfree(void *kptr) {
  if (kptr == nullptr) {
    return;
  }
  uintptr_t pa = (uintptr_t)kptr;
  uintptr_t pageno = pa / PAGESIZE;
  assert(pa == pageno * PAGESIZE);
  // ^ no loss from integer division
  physpages[pageno].refcount--;
  assert(physpages[pageno].refcount >= 0);
}

// process_setup(pid, program_name)
//    Load application program `program_name` as process number `pid`.
//    This loads the application's code and data into memory, sets its
//    %rip and %rsp, gives it a stack page, and marks it as runnable.
//
//    internally asserts there's enough space to launch the new program

void process_setup(pid_t pid, const char *program_name) {
  init_process(&ptable[pid], 0);

  // initialize process page table
  x86_64_pagetable *proc_pg_tbl = kalloc_pagetable();
  assert(proc_pg_tbl != nullptr);
  ptable[pid].pagetable = proc_pg_tbl;

  // copy kernel permissions
  for (uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE) {
    uintptr_t kernel_perm = vmiter(kernel_pagetable, addr).perm();
    int r = vmiter(proc_pg_tbl, addr).try_map(addr, kernel_perm);
    assert(r == 0);
  }

  // obtain reference to program image
  // (The program image models the process executable.)
  program_image pgm(program_name);

  // allocate and map process memory as specified in program image
  for (auto seg = pgm.begin(); seg != pgm.end(); ++seg) {
    for (uintptr_t virt_addr = round_down(seg.va(), PAGESIZE);
         virt_addr < seg.va() + seg.size(); virt_addr += PAGESIZE) {
      int perm = PTE_P | PTE_U;
      if (seg.writable()) {
        perm |= PTE_W;
      }
      void *phys_page = kalloc(PAGESIZE);
      assert(phys_page != nullptr);
      int r =
          vmiter(proc_pg_tbl, virt_addr).try_map((uintptr_t)phys_page, perm);
      assert(r == 0);
    }
  }

  // copy instructions and data from program image into process memory
  for (auto seg = pgm.begin(); seg != pgm.end(); ++seg) {
    // memset and memcpy operate from the perspective of the kernel. The
    // kernel's page table is 1:1 with physical addresses, so we use the
    // physical addresses for memset and memcpy.
    uintptr_t seg_phys_addr = vmiter(proc_pg_tbl, seg.va()).pa();
    memset((void *)seg_phys_addr, 0, seg.size());
    memcpy((void *)seg_phys_addr, seg.data(), seg.data_size());
  }

  // allocate and map stack segment
  uintptr_t stack_page_virt_addr = MEMSIZE_VIRTUAL - PAGESIZE;
  void *phys_stack_page = kalloc(PAGESIZE);
  assert(phys_stack_page != nullptr);
  assert(stack_page_virt_addr == round_down(stack_page_virt_addr, PAGESIZE));
  int r = vmiter(proc_pg_tbl, stack_page_virt_addr)
              .try_map((uintptr_t)phys_stack_page, PTE_PWU);
  assert(r == 0);

  // set rsp to the top of the stack
  ptable[pid].regs.reg_rsp = stack_page_virt_addr + PAGESIZE;
  // set rip to program entry point
  ptable[pid].regs.reg_rip = pgm.entry();
  // mark process as runnable
  ptable[pid].state = P_RUNNABLE;
}

// exception(regs)
//    Exception handler (for interrupts, traps, and faults).
//
//    The register values from exception time are stored in `regs`.
//    The processor responds to an exception by saving application state on
//    the kernel's stack, then jumping to kernel assembly code (in
//    k-exception.S). That code saves more registers on the kernel's stack,
//    then calls exception().
//
//    Note that hardware interrupts are disabled when the kernel is running.

void exception(regstate *regs) {
  // Copy the saved registers into the `current` process descriptor.
  current->regs = *regs;
  regs = &current->regs;

  // It can be useful to log events using `log_printf`.
  // Events logged this way are stored in the host's `log.txt` file.
  /* log_printf("proc %d: exception %d at rip %p\n",
              current->pid, regs->reg_intno, regs->reg_rip); */

  // Show the current cursor location and memory state
  // (unless this is a kernel fault).
  console_show_cursor(cursorpos);
  if (regs->reg_intno != INT_PF || (regs->reg_errcode & PTE_U)) {
    memshow();
  }

  // If Control-C was typed, exit the virtual machine.
  check_keyboard();

  // Actually handle the exception.
  switch (regs->reg_intno) {

  case INT_IRQ + IRQ_TIMER:
    ++ticks;
    lapicstate::get().ack();
    schedule();
    break; /* will not be reached */

  case INT_PF: {
    // Analyze faulting address and access type.
    uintptr_t addr = rdcr2();
    const char *operation = regs->reg_errcode & PTE_W ? "write" : "read";
    const char *problem =
        regs->reg_errcode & PTE_P ? "protection problem" : "missing page";

    if (!(regs->reg_errcode & PTE_U)) {
      proc_panic(current, "Kernel page fault on %p (%s %s, rip=%p)!\n", addr,
                 operation, problem, regs->reg_rip);
    }
    error_printf(CPOS(24, 0), 0x0C00,
                 "Process %d page fault on %p (%s %s, rip=%p)!\n", current->pid,
                 addr, operation, problem, regs->reg_rip);
    current->state = P_FAULTED;
    break;
  }

  default:
    proc_panic(current, "Unhandled exception %d (rip=%p)!\n", regs->reg_intno,
               regs->reg_rip);
  }

  // Return to the current process (or run something else).
  if (current->state == P_RUNNABLE) {
    run(current);
  } else {
    schedule();
  }
}

// syscall(regs)
//    Handle a system call initiated by a `syscall` instruction.
//    The process’s register values at system call time are accessible in
//    `regs`.
//
//    If this function returns with value `V`, then the user process will
//    resume with `V` stored in `%rax` (so the system call effectively
//    returns `V`). Alternately, the kernel can exit this function by
//    calling `schedule()`, perhaps after storing the eventual system call
//    return value in `current->regs.reg_rax`.
//
//    It is only valid to return from this function if
//    `current->state == P_RUNNABLE`.
//
//    Note that hardware interrupts are disabled when the kernel is running.

uintptr_t syscall(regstate *regs) {
  // Copy the saved registers into the `current` process descriptor.
  current->regs = *regs;
  regs = &current->regs;

  // It can be useful to log events using `log_printf`.
  // Events logged this way are stored in the host's `log.txt` file.
  /* log_printf("proc %d: syscall %d at rip %p\n",
                current->pid, regs->reg_rax, regs->reg_rip); */

  // Show the current cursor location and memory state.
  console_show_cursor(cursorpos);
  memshow();

  // If Control-C was typed, exit the virtual machine.
  check_keyboard();

  // Actually handle the exception.
  switch (regs->reg_rax) {

  case SYSCALL_PANIC:
    user_panic(current);
    break; // will not be reached

  case SYSCALL_GETPID:
    return current->pid;

  case SYSCALL_YIELD:
    current->regs.reg_rax = 0;
    schedule(); // does not return

  case SYSCALL_PAGE_ALLOC:
    return syscall_page_alloc(current->regs.reg_rdi);

  case SYSCALL_FORK:
    return syscall_fork();

  case SYSCALL_EXIT:
    syscall_exit();
    break; // will not be reached

  default:
    proc_panic(current, "Unhandled system call %ld (pid=%d, rip=%p)!\n",
               regs->reg_rax, current->pid, regs->reg_rip);
  }

  panic("Should not get here!\n");
}

// syscall_page_alloc(addr)
//    Handles the SYSCALL_PAGE_ALLOC system call. This function
//    should implement the specification for `sys_page_alloc`
//    in `u-lib.hh` (but in the handout code, it does not).

int syscall_page_alloc(uintptr_t addr) {
  if (addr % PAGESIZE != 0) {
    // Improper alignment
    return -1;
  }
  if (addr < PROC_START_ADDR || addr >= MEMSIZE_VIRTUAL) {
    // Invalid address space
    return -2;
  }
  void *phys_page = kalloc(PAGESIZE);
  if (phys_page == nullptr) {
    // no more memory available
    return -3;
  }
  int r =
      vmiter(current->pagetable, addr).try_map((uintptr_t)phys_page, PTE_PWU);
  if (r != 0) {
    // ran out of open pages, unable to assign new page
    kfree(phys_page);
    return -4;
  }
  memset(phys_page, 0, PAGESIZE);
  return 0;
}

// schedule
//    Pick the next process to run and then run it.
//    If there are no runnable processes, spins forever.

void schedule() {
  pid_t pid = current->pid;
  for (unsigned spins = 1; true; ++spins) {
    pid = (pid + 1) % PID_MAX;
    if (ptable[pid].state == P_RUNNABLE) {
      run(&ptable[pid]);
    }

    // If Control-C was typed, exit the virtual machine.
    check_keyboard();

    // If spinning forever, show the memviewer.
    if (spins % (1 << 12) == 0) {
      memshow();
      log_printf("%u\n", spins);
    }
  }
}

// run(p)
//    Run process `p`. This involves setting `current = p` and calling
//    `exception_return` to restore its page table and registers.

void run(proc *p) {
  assert(p->state == P_RUNNABLE);
  current = p;

  // Check the process's current pagetable.
  check_pagetable(p->pagetable);

  // This function is defined in k-exception.S. It restores the process's
  // registers then jumps back to user mode.
  exception_return(p);

  // should never get here
  while (true) {
  }
}

// memshow()
//    Draw a picture of memory (physical and virtual) on the CGA console.
//    Switches to a new process's virtual memory map every 0.25 sec.
//    Uses `console_memviewer()`, a function defined in `k-memviewer.cc`.

void memshow() {
  static unsigned last_ticks = 0;
  static int showing = 0;

  // switch to a new process every 0.25 sec
  if (last_ticks == 0 || ticks - last_ticks >= HZ / 2) {
    last_ticks = ticks;
    showing = (showing + 1) % PID_MAX;
  }

  proc *p = nullptr;
  for (int search = 0; !p && search < PID_MAX; ++search) {
    if (ptable[showing].state != P_FREE && ptable[showing].pagetable) {
      p = &ptable[showing];
    } else {
      showing = (showing + 1) % PID_MAX;
    }
  }

  console_memviewer(p);
  if (!p) {
    console_printf(CPOS(10, 26), 0x0F00,
                   "   VIRTUAL ADDRESS SPACE\n"
                   "                          [All processes have exited]\n"
                   "\n\n\n\n\n\n\n\n\n\n\n");
  }
}

/// Searches for an open process ID. Returns -1 if all processes are active.
int request_new_pid() {
  for (int ind = 1; ind < PID_MAX; ind++) {
    if (ptable[ind].state == P_FREE) {
      return ind;
    }
  }
  return -1;
}

/// deallocates a process and all user-level pages
/// frees the page table its given
/// !!! Assume all addresses related to this process are invalid
/// after this function exits
void dealloc_pg_tbl(x86_64_pagetable *pg_tbl) {
  assert(pg_tbl != nullptr);
  // free virtual addresses
  for (vmiter pg_iter(pg_tbl, PROC_START_ADDR); pg_iter.va() < MEMSIZE_VIRTUAL;
       pg_iter.next()) {
    if (!pg_iter.user()) {
      continue;
    }
    kfree(pg_iter.kptr());
  }
  // free child page tables
  for (ptiter pg_iter(pg_tbl); !pg_iter.done(); pg_iter.next()) {
    kfree(pg_iter.kptr());
  }
  kfree(pg_tbl);
}

/// If a fork tried to create a child process and failed, this function ensures
/// the process exits cleanly.
int cleanup_failed_fork(x86_64_pagetable *child_pg_tbl, int child_pid) {
  if (child_pg_tbl != nullptr) {
    dealloc_pg_tbl(child_pg_tbl);
  }
  ptable[child_pid].state = P_FREE;
  current->regs.reg_rax = -1;
  return -1;
}

/// Handles the fork system call request
/// Attempts to spawn a new process. Cleans up and returns -1 if it cannot.
int syscall_fork() {
  int child_pid = request_new_pid();
  if (child_pid < 0) {
    // all processes busy, but there's nothing to clean up either
    return -1;
  }
  assert(child_pid != 0);

  x86_64_pagetable *child_pg_tbl = kalloc_pagetable();
  if (child_pg_tbl == nullptr) {
    return cleanup_failed_fork(child_pg_tbl, child_pid);
  }

  // Copy system pages
  for (uintptr_t addr = 0; addr < PROC_START_ADDR; addr += PAGESIZE) {
    uintptr_t kernel_perm = vmiter(current->pagetable, addr).perm();
    int r = vmiter(child_pg_tbl, addr).try_map(addr, kernel_perm);
    if (r != 0) {
      return cleanup_failed_fork(child_pg_tbl, child_pid);
    }
  }

  // Copy process pages
  for (vmiter parent_iter(current->pagetable, PROC_START_ADDR);
       parent_iter.va() < MEMSIZE_VIRTUAL; parent_iter.next()) {
    if (!parent_iter.user()) {
      continue;
    }
    void *child_phys_page = nullptr;
    // either borrow the page if it's not writeable, or create a copy page
    // if it is
    if (!parent_iter.writable()) {
      child_phys_page = kborrow(parent_iter.pa());
      assert(child_phys_page != nullptr);
    } else {
      child_phys_page = kalloc(PAGESIZE);
    }
    if (child_phys_page == nullptr) {
      return cleanup_failed_fork(child_pg_tbl, child_pid);
    }
    int r = vmiter(child_pg_tbl, parent_iter.va())
                .try_map((uintptr_t)child_phys_page, parent_iter.perm());
    if (r != 0) {
      kfree(child_phys_page);
      return cleanup_failed_fork(child_pg_tbl, child_pid);
    }
    void *parent_addr = (void *)parent_iter.pa();
    assert(parent_addr != nullptr);
    memcpy(child_phys_page, parent_addr, PAGESIZE);
  }

  ptable[child_pid].pagetable = child_pg_tbl;
  ptable[child_pid].state = P_RUNNABLE;
  ptable[child_pid].regs = current->regs;
  ptable[child_pid].regs.reg_rax = 0;
  current->regs.reg_rax = child_pid;
  return child_pid;
}

/// Handles an exit syscall request. Will not return.
int syscall_exit() {
  dealloc_pg_tbl(current->pagetable);
  ptable[current->pid].state = P_FREE;
  schedule();
}
