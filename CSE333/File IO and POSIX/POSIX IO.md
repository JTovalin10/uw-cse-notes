# CSE333: POSIX IO

**POSIX I/O** provides low-level, unbuffered access to files and devices. These are thin wrappers around Linux system calls and operate directly on **file descriptors** rather than the `FILE*` handles used by Standard C Streams.

## File Descriptors

Instead of `FILE*`, POSIX uses **File Descriptors (fd)**, which are small non-negative integers maintained by the kernel. Every open file, socket, or pipe in a process is represented by an fd.

- `0`: `STDIN_FILENO`
- `1`: `STDOUT_FILENO`
- `2`: `STDERR_FILENO`

New file descriptors are assigned sequentially, starting at 3.

## Core Functions (`<unistd.h>`, `<fcntl.h>`, `<sys/types.h>`, `<sys/stat.h>`)

### 1. `open()`

Opens a file and returns a new file descriptor.

```c
int open(const char* pathname, int flags, mode_t mode);
```

- **Parameters**:
  - `pathname`: String path to the file.
  - `flags`: Bitwise OR of access modes:
    - `O_RDONLY`: Read only.
    - `O_WRONLY`: Write only.
    - `O_RDWR`: Read and write.
    - `O_CREAT`: Create file if it does not exist (requires `mode`).
    - `O_TRUNC`: Truncate file to zero length if it exists.
  - `mode`: (Only used with `O_CREAT`) File permissions (e.g., `0644`).
- **Returns**: New `fd` on success, `-1` on error (sets `errno`).

### 2. `read()`

Reads up to `count` bytes from `fd` into `buf`.

```c
ssize_t read(int fd, void* buf, size_t count);
```

- **Returns**:
  - `> 0`: Number of bytes actually read.
  - `0`: End of File (EOF).
  - `-1`: Error (check `errno`).

### 3. `write()`

Writes up to `count` bytes from `buf` to `fd`.

```c
ssize_t write(int fd, const void* buf, size_t count);
```

- **Returns**: Number of bytes actually written, or `-1` on error.

### 4. `close()`

Closes a file descriptor so it no longer refers to any file.

```c
int close(int fd);
```

- **Returns**: `0` on success, `-1` on error.

---

## Important: Handling Short Counts

POSIX I/O calls can return **short counts** — reading or writing fewer bytes than requested. This is not an error. It can happen due to:

- Interruption by a signal (`errno == EINTR`).
- Reading from a pipe or network socket (data arrives in packets).
- Reaching EOF partway through a read.

**Correct Usage (The Read Loop)**:

```c
ssize_t res;
size_t bytes_left = count;
char* ptr = buf;

while (bytes_left > 0) {
    res = read(fd, ptr, bytes_left);
    if (res == -1) {
        if (errno == EINTR) continue; // Interrupted by signal, try again
        break; // Real error
    }
    if (res == 0) break; // EOF
    bytes_left -= res;
    ptr += res;
}
```

## Error Handling

POSIX functions return `-1` on error and set the global variable **`errno`**. Always check for `-1` and handle `EINTR` specifically. Use `perror()` or `strerror()` to print a human-readable error message. See [[CSE333/File IO and POSIX/POSIX perror|POSIX perror]] for details.

## Related

- [[CSE333/File IO and POSIX/Standard C Streams|Standard C Streams]]
- [[CSE333/File IO and POSIX/System Calls|System Calls]]
- [[CSE333/File IO and POSIX/POSIX perror|POSIX perror]]
- [[CSE333/File IO and POSIX/Directory IO|Directory IO]]

## Industry Standard Terms

- **File descriptor** — A small integer index into the kernel's per-process open file table; analogous to a "handle" in Windows
- **`errno`** — A thread-local global integer set by POSIX functions on failure; defined in `<errno.h>`
- **Short count** — A partial read or write; correctly handling short counts is a common source of bugs in network and file I/O code
- **`EINTR`** — The error code set when a system call is interrupted by a signal; the correct response is to restart the call
