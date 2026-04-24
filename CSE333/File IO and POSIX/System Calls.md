# CSE 333: System Calls

**System Calls** are the interface between an application and the Operating System kernel.

## OS Responsibilities
The OS is the "layer below" that:
- Directly interacts with hardware.
- Manages hardware resources (CPU, memory, disk).
- Provides abstractions (files, processes, network stacks).
- Protects the system from untrusted user-level code.

## Privilege Levels
- **Unprivileged Mode (User Mode)**: Application code runs here. Access to hardware is restricted.
- **Privileged Mode (Kernel Mode)**: The OS kernel runs here. Has full control over hardware.

## System Call Execution
1. Application code invokes a system call (e.g., via `glibc` wrapper).
2. A **trap** (using instructions like `SYSENTER` on x86) transitions the CPU to privileged mode.
3. The kernel executes the appropriate handler.
4. The CPU transitions back to user mode and returns results to the application.

## strace
**strace** is a Linux utility that shows the sequence of system calls a process makes. It is an invaluable tool for debugging I/O and process issues.

# Related
- [[Standard C Streams]]
- [[POSIX IO]]
- [[CSE451/Kernel Abstraction/Traps/System Call|CSE451: System Calls]]
