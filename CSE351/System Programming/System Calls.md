# CSE351: System Calls

System calls are the interface for user programs to request services from the OS kernel.

---

## How System Calls Work

System calls are implemented as **trap** exceptions:

1. User program executes the system call instruction
2. Control transfers to the kernel (privilege escalation)
3. Kernel executes the requested service
4. Control returns to the user program

---

## Common System Calls

### Process Management

| Call | Purpose |
|:---|:---|
| `fork()` | Create child process |
| `exec*()` | Replace process image |
| `wait()` | Wait for child termination |
| `exit()` | Terminate process |

### File Operations

| Call | Purpose |
|:---|:---|
| `open()` | Open file |
| `read()` | Read from file |
| `write()` | Write to file |
| `close()` | Close file |

### Memory Management

| Call | Purpose |
|:---|:---|
| `brk()` | Change heap size |
| `mmap()` | Map memory |
| `munmap()` | Unmap memory |

---

## System Call Summary

| Call | Purpose | Returns |
|:---|:---|:---|
| `fork()` | Create child | Child PID (parent), 0 (child), -1 (error) |
| `exec*()` | Replace process | Only on error (-1) |
| `wait()` | Wait for child | Child PID, -1 (error) |
| `waitpid()` | Wait for specific child | Child PID, -1 (error) |
| `exit()` | Terminate | Does not return |

---

## User Mode vs. Kernel Mode

| Aspect | User Mode | Kernel Mode |
|:---|:---|:---|
| Privileges | Limited | Full |
| Memory access | Restricted | Unrestricted |
| Instructions | Subset | All |
| Transition | Via system call (trap) | Via exception return |

---

## Related
- [[CSE351/System Programming/Exceptions|Exceptions]]
- [[CSE351/System Programming/Processes|Processes]]
- [[CSE351/System Programming/Fork-Exec Model|Fork-Exec Model]]
- [[CSE451/Kernel Abstraction/Traps/Traps|Traps / System Calls (CSE451)]]
- [[CSE451/Kernel Abstraction/Traps/System Call|System Call (CSE451)]]
- [[CSE333/File IO and POSIX/POSIX Open|POSIX File I/O (CSE333)]]
