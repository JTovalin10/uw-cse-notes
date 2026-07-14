# CSE451: System Calls and Signals

The Operating System provides a protected interface for user programs to interact with hardware through **[[Operating Systems/Virtualization/Mechanisms/Traps/System Call|System Calls]]**. A **[[Process and Thread Fundamentals|Process]]** cannot directly touch hardware or other processes' memory; instead, it must ask the kernel to do so on its behalf, and the kernel validates and performs the request from a position of full privilege.

## System Call Mechanism
When a program needs a service (e.g., `read()`), it triggers a **[[Operating Systems/Virtualization/Mechanisms/Traps/Traps|Trap]]** to switch from **[[Ring 3|Ring 3 (User Mode)]]** to **[[Ring 0|Ring 0 (Kernel Mode)]]**. This transition is necessary because privileged operations (touching hardware registers, reprogramming page tables, accessing another process's memory) are only permitted for code running in Ring 0; a Ring 3 process has no choice but to ask the kernel to act for it.

The trap-based transition proceeds in four steps:
1. The CPU looks up the **Interrupt Descriptor Table (IDT)** (or Trap Table) for the entry corresponding to the system call number the process placed in a register.
2. It saves the user's registers and stack pointer, so that execution can later resume in user mode exactly where it left off, unaware that a switch to the kernel ever happened.
3. It executes the kernel's system call handler, which validates the request's arguments (translating and copying them from user memory into kernel memory) before performing the requested operation — see **[[Operating Systems/Virtualization/Mechanisms/Traps/System Call#Dealing with System Calls|System Call: Dealing with System Calls]]** for the full argument-handling sequence.
4. It restores the user state and executes a `sysret` or `iret` to return to user mode, handing control back to the exact instruction after the trap.

### Modern Optimizations
Because the full trap sequence above (looking up the IDT, saving/restoring all registers, switching privilege levels) has non-trivial overhead, modern systems introduce faster paths for the most common cases:
- **syscall / sysenter**: Optimized instructions that bypass the legacy interrupt mechanism (`int 0x80`) by using a dedicated, pre-registered fast-entry point into the kernel instead of consulting the full Trap Table on every call.
- **vDSO (virtual Dynamic Shared Object)**: A shared library mapped into every process's address space that allows certain system calls (like `gettimeofday`) to be executed entirely in user mode by reading kernel-mapped pages directly — avoiding the trap into the kernel altogether for read-only queries that don't need kernel-side computation.

## File Descriptors
A **File Descriptor (FD)** is a small integer that acts as a handle to an open file or I/O stream. Every syscall that operates on an open file or socket (`read()`, `write()`, `close()`) takes an FD as its argument, rather than a filename, so the kernel must maintain a mapping from that small integer back to the actual open resource.

### Three Levels of Indirection
This mapping is implemented through three levels of indirection, which together allow multiple file descriptors — even in different processes — to safely share or independently track the same underlying file:
1. **Process File Descriptor Table**: Maps the integer (e.g., 3) to an entry in the system-wide open file table. This table is private per-process, which is why the same integer FD can refer to entirely different files in two different processes.
2. **Open File Table**: Stores the current offset, status flags (e.g., `O_APPEND`), and a pointer to the inode. This table is shared system-wide, which is what allows two file descriptors (in the same or different processes) to share the same file offset if they point to the same open file table entry.
3. **Inode Table**: Stores the actual file metadata (permissions, owner, disk blocks) — the persistent, on-disk representation of the file itself, independent of how many processes currently have it open.

- **`dup2(old, new)`**: Copies a file descriptor entry, allowing multiple FDs to share the same open file table entry (and thus the same offset). This is the mechanism shells use to implement I/O redirection (e.g., redirecting a child process's stdout to a file) — the child's FD 1 is made to point at the same open file table entry as the target file.
- **[[System and Software Tools/Streams Redirection and Pipes/Pipes|Pipes]]**: A unidirectional data channel for Inter-Process Communication (IPC). `pipe()` creates two FDs: one for reading and one for writing, and unlike a `dup2` alias, the two ends refer to a distinct in-kernel buffer rather than an on-disk file.

## Signals
**Signals** are software interrupts sent to a process to notify it of an event. Unlike system calls, which a process initiates deliberately, signals are typically delivered asynchronously — the kernel (or another process) interrupts the target process's execution to inform it something has happened, whether or not it was expecting it.

- **SIGKILL**: Immediately terminates the process. Cannot be caught or ignored, because it is delivered directly by the kernel forcibly tearing down the process rather than invoking a user-installed handler — this guarantees that a runaway or unresponsive process can always be terminated.
- **SIGTERM**: Requests process termination. Can be caught for a graceful shutdown, allowing the process to flush buffers, close files, or clean up child processes before exiting on its own terms.
- **SIGSEGV**: Triggered by an invalid memory access (e.g., dereferencing a null or out-of-bounds pointer), delivered by the kernel's page-fault handler when it determines the faulting address is not a valid, mapped part of the process's address space.

### Async-Signal-Safety
A function is **Async-Signal-Safe** if it can be safely called from within a signal handler. Many standard functions (like `printf` or `malloc`) are NOT safe because they use internal locks that the signal handler might interrupt — if the signal arrives while the interrupted thread already holds one of these locks, and the handler calls the same locking function again, the process deadlocks against itself, since the lock will never be released by the interrupted (and now stuck) original call.

## Deep Dive

### Formal Definition
A signal handler executing under async-signal-unsafe conditions models a nested critical section violation: if thread $T$ holds lock $L$ at the moment a signal is delivered, and the installed handler $H$ also attempts to acquire $L$, then $H$ blocks indefinitely waiting for $T$ to release $L$ — but $T$ cannot resume (and thus cannot release $L$) until $H$ returns. This is a self-deadlock:
$$T \text{ holds } L \implies H \text{ blocks on } L \implies T \text{ never resumes} \implies L \text{ never released}$$

### Simplified Explanation
If a signal handler tries to grab a lock that the code it interrupted was already holding, the program freezes waiting for itself to finish — which never happens, because the interrupted code cannot continue until the handler returns.

## Industry Standard Terms
- **Trap** $\rightarrow$ Software Interrupt / Exception
- **Ring 0 / Ring 3** $\rightarrow$ Kernel Mode / User Mode (or Supervisor Mode / Unprivileged Mode)
- **File Descriptor Table** $\rightarrow$ File Descriptor Array (POSIX terminology)
- **Open File Table** $\rightarrow$ System-Wide Open File Table / File Table
- **Signal** $\rightarrow$ POSIX Signal / Software Interrupt (to a process, as opposed to hardware interrupts to the CPU)
- **Async-Signal-Safe** $\rightarrow$ Reentrant / Signal-Safe function

## Related
- [[Process and Thread Fundamentals|Process and Thread Fundamentals]]
- [[Operating Systems/Kernel/Kernel Internals|Kernel Internals and Performance]]
- [[Operating Systems/Virtualization/Mechanisms/Traps/Traps|Traps]]
- [[Operating Systems/Virtualization/Mechanisms/Traps/TrapsComponents/Types of Traps|Types of Traps]]
- [[Systems Programming/File IO and POSIX/System Calls|CSE333: System Calls]]
- [[Systems Programming/Process Management/Process Management|CSE333: Process Management]]
