# CSE333: Process Management

In systems programming, **Process Management** involves creating, controlling, and synchronizing multiple processes to execute concurrently.

## Creating Processes

### fork()

The **`fork()`** system call creates a new process that is an exact clone of the current process.

```c
#include <unistd.h>
#include <sys/types.h>

pid_t fork(void);
```

- **Returns**: `0` to the **child** process, and the child's **PID** to the parent process. On failure, returns `-1`.
- Everything except threads is cloned exactly: address space, open file descriptors, signal handlers.
- Common uses:
    - **Servers**: Fork a child to handle each new connection concurrently.
    - **Shells**: Fork before `exec`-ing a new program.

Forking causes the OS to clone the entire address space, typically using **Copy-on-Write (CoW)**: the pages are shared read-only until one of the processes writes to them, at which point the OS creates a private copy.

## Executing Programs

### exec()

The **`exec`** family of functions replaces the current process image with a new program.

```c
#include <unistd.h>

int execl(const char *path, const char *arg, ...);
int execv(const char *path, char *const argv[]);
```

- A successful `exec` call **does not return** — the new program starts executing from its `main` function.
- It preserves the PID and open file descriptors (unless `O_CLOEXEC` is set on them).
- The `exec` family uses the `fork`/`exec` model: `fork()` first to create a child, then `exec()` to replace the child's image with the new program.

## Synchronizing Processes

### wait()

The **`wait()`** and **`waitpid()`** system calls allow a parent process to wait for the termination of a child process.

```c
#include <sys/wait.h>

pid_t wait(int *status);
pid_t waitpid(pid_t pid, int *status, int options);
```

- **`wait()`**: Blocks until any child process terminates.
- **`waitpid()`**: Blocks until the specific child process (identified by `pid`) terminates.
- Calling `wait()` is critical to avoid **zombie processes** — children that have terminated but whose exit status has not yet been collected by the parent.

### The Double-Fork Trick

If a parent does not want to `wait()` for a child (e.g., to run a background daemon), it can use the **double-fork trick** to orphan the grandchild:

1. Parent forks child.
2. Child forks grandchild, then immediately exits.
3. Grandchild is orphaned and adopted by `init` (PID 1), which reaps it automatically.
4. Parent calls `wait()` for the short-lived child immediately.

## Processes vs. Threads for Servers

| Feature | Processes | Threads |
| :--- | :--- | :--- |
| **Creation** | Slow (~0.25 ms/fork) | Fast (~0.036 ms/thread) |
| **Address Space** | Private (Isolated) | Shared |
| **Communication** | Complex (IPC, Pipes, Files) | Easy (Shared Memory + Locks) |
| **Failure Isolation** | Independent — one crash does not affect others | Shared — a rogue thread can crash the whole process |
| **Context Switch Overhead** | High | Lower |

## Thread Pools

In high-performance servers, creating a new thread or process for every request is still too expensive. A **thread pool** creates a fixed set of worker threads at startup. Requests are placed in a shared queue, and idle workers dequeue and handle tasks.

## Related

- [[CSE333/Concurrency/Threads|Threads]]
- [[CSE333/Concurrency/Concurrency Intro|Concurrency Intro]]
- [[CSE333/File IO and POSIX/POSIX perror|POSIX perror]]
- [[Exceptions|CSE351: Exceptions]]

## Industry Standard Terms

- **`fork()`** — The Unix mechanism for creating new processes; combined with `exec()` it implements the "fork-exec" model used by all Unix shells
- **`exec()`** — Replaces the calling process's image with a new program; the `execve()` variant is the actual system call; others (`execl`, `execv`, etc.) are wrappers
- **Zombie process** — A process that has exited but whose exit status has not been collected by the parent via `wait()`; its entry remains in the process table
- **Copy-on-Write (CoW)** — The OS optimization that makes `fork()` fast by sharing pages between parent and child until one of them writes; only then is a private copy made
- **Thread pool** — A design pattern where a fixed set of worker threads service a queue of tasks; avoids the overhead of creating/destroying threads per request; used in web servers (e.g., Apache's MPM Prefork) and Java's `ExecutorService`
