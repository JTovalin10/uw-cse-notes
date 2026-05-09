# CSE451: System Calls and Signals

The Operating System provides a protected interface for user programs to interact with hardware through **[[System Calls]]**.

### System Call Mechanism
When a program needs a service (e.g., `read()`), it triggers a **[[Trap]]** to switch from **[[Ring 3 (User Mode)]]** to **[[Ring 0 (Kernel Mode)]]**.

1. The CPU looks up the **[[Interrupt Descriptor Table (IDT)]]** (or Trap Table) for the entry corresponding to the system call.
2. It saves the user's registers and stack pointer.
3. It executes the kernel's system call handler.
4. It restores the user state and executes a `sysret` or `iret` to return to user mode.

#### Modern Optimizations
- **[[syscall / sysenter]]**: Optimized instructions that bypass the legacy interrupt mechanism.
- **[[vDSO (virtual Dynamic Shared Object)]]**: A shared library mapped into every process that allows certain system calls (like `gettimeofday`) to be executed entirely in user mode by reading kernel-mapped pages.

### File Descriptors
A **[[File Descriptor (FD)]]** is a small integer that acts as a handle to an open file or I/O stream.

#### Three Levels of Indirection
1. **[[Process File Descriptor Table]]**: Maps the integer (e.g., 3) to an entry in the system-wide open file table.
2. **[[Open File Table]]**: Stores the current offset, status flags (e.g., `O_APPEND`), and a pointer to the inode.
3. **[[Inode Table]]**: Stores the actual file metadata (permissions, owner, disk blocks).

- **[[dup2(old, new)]]**: Copies a file descriptor entry, allowing multiple FDs to share the same open file table entry (and thus the same offset).
- **[[Pipes]]**: A unidirectional data channel for Inter-Process Communication (IPC). `pipe()` creates two FDs: one for reading and one for writing.

### Signals
**[[Signals]]** are software interrupts sent to a process to notify it of an event.

- **[[SIGKILL]]**: Immediately terminates the process. Cannot be caught or ignored.
- **[[SIGTERM]]**: Requests process termination. Can be caught for a graceful shutdown.
- **[[SIGSEGV]]**: Triggered by an invalid memory access.

#### Async-Signal-Safety
A function is **[[Async-Signal-Safe]]** if it can be safely called from within a signal handler. Many standard functions (like `printf` or `malloc`) are NOT safe because they use internal locks that the signal handler might interrupt, leading to deadlocks.

### Related
- [[CSE451/Processes/Context Switching]]
- [[CSE333/File IO/File Descriptors]]
