# System Calls

System calls are the interface for user programs to request services from the OS kernel.

**Related:** [[Exceptions]], [[Processes]], [[Fork-Exec Model]]

---

## How System Calls Work

System calls are implemented as **trap** exceptions:

1. User program executes system call instruction
2. Control transfers to kernel (privilege escalation)
3. Kernel executes requested service
4. Control returns to user program

---

## Common System Calls

### Process Management

| Call | Purpose |
|------|---------|
| `fork()` | Create child process |
| `exec*()` | Replace process image |
| `wait()` | Wait for child termination |
| `exit()` | Terminate process |

### File Operations

| Call | Purpose |
|------|---------|
| `open()` | Open file |
| `read()` | Read from file |
| `write()` | Write to file |
| `close()` | Close file |

### Memory Management

| Call | Purpose |
|------|---------|
| `brk()` | Change heap size |
| `mmap()` | Map memory |
| `munmap()` | Unmap memory |

---

## System Call Summary

| Call | Purpose | Returns |
|------|---------|---------|
| `fork()` | Create child | Child PID (parent), 0 (child), -1 (error) |
| `exec*()` | Replace process | Only on error (-1) |
| `wait()` | Wait for child | Child PID, -1 (error) |
| `waitpid()` | Wait for specific child | Child PID, -1 (error) |
| `exit()` | Terminate | Does not return |

---

## User Mode vs Kernel Mode

| Aspect | User Mode | Kernel Mode |
|--------|-----------|-------------|
| Privileges | Limited | Full |
| Memory access | Restricted | Unrestricted |
| Instructions | Subset | All |
| Transition | Via system call | Via exception return |

**Related:** [[Virtual Memory]], [[Exceptions]]
