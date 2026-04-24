# CSE333: Process Management

In systems programming, **[[Process Management]]** involves creating, controlling, and synchronizing multiple processes to execute concurrently.

## Creating Processes

### fork()
The `fork()` system call creates a new process that is an exact clone of the current process.

```c
#include <unistd.h>
#include <sys/types.h>

pid_t fork(void);
```
- **Returns**: 0 to the child process, and the child's PID to the parent process.
- Everything but threads is an exact copy.
- Used in:
    - **Servers**: To handle new connections concurrently.
    - **Shells**: To fork a child before executing a new program.
- Forking causes the OS to clone the entire address space.

## Executing Programs

### exec()
The `exec` family of functions replaces the current process image with a new process image.

```c
#include <unistd.h>

int execl(const char *path, const char *arg, ...);
int execv(const char *path, char *const argv[]);
```
- A successful `exec` call does not return; the new program starts executing from its `main` function.
- It preserves the PID and open file descriptors (unless `O_CLOEXEC` is set).

## Synchronizing Processes

### wait()
The `wait()` and `waitpid()` system calls allow a parent process to wait for the termination of a child process.

```c
#include <sys/wait.h>

pid_t wait(int *status);
pid_t waitpid(pid_t pid, int *status, int options);
```
- **wait()**: Blocks until any child process terminates.
- **waitpid()**: Blocks until the specific child process terminates.
- Important for cleaning up terminated processes (avoiding "zombie processes").

## Related
- CSE333/Definitions/Creating a new process
- [[CSE333/File IO and POSIX/POSIX perror]]
- [[CSE351/System Programming/Exceptions]]
