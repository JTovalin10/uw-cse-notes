# CSE451: System Call

A **system call (syscall)** is a request by a program for the kernel to perform some operation on its behalf. It is the primary mechanism for user programs to access privileged OS functionality.

- Only a limited number of very carefully coded entry points are allowed
- On x86: the process executes a `syscall` (or legacy `int 0x80`) instruction, which traps into the kernel, pushes everything to the kernel stack, the OS wakes up, takes parameters off the stack, and executes the requested operation

## Dealing with System Calls
1. **Locate arguments** — find them in registers or on the user stack; translate user addresses into kernel addresses
2. **Copy arguments** — copy from user memory into kernel memory (protects kernel from malicious code evading checks)
3. **Validate arguments** — protect kernel from errors in user code
4. **Execute** — perform the requested operation
5. **Copy results** back into user memory — translate kernel addresses into user addresses
6. The kernel **double-checks** the user request in case another thread changed the data after the initial check

## Examples
- `open()` / `create()` — open or create a file
- `read()` / `write()` — read/write from a file or device
- `malloc()` / `brk()` — allocate memory (sometimes handled in user-mode libraries)
- `fork()` / `exec()` — process creation and replacement

## Related
- [[Traps]] — system calls are intentional traps
- [[How Traps Work]] — the mechanism behind syscall execution
- [[Privilege Level]] — syscalls cross the privilege boundary from user to kernel
- [[Mode Switch]] — the user-to-kernel transition triggered by a syscall
- [[Fork]] — a key syscall for process creation
- [[Exec]] — a key syscall for process replacement
