# CSE 333: POSIX IO

**POSIX I/O** provides low-level, unbuffered access to files and devices. These are thin wrappers around Linux system calls.

## File Descriptors
Instead of `FILE*`, POSIX uses **File Descriptors (fd)**, which are small non-negative integers.
- `0`: `STDIN_FILENO`
- `1`: `STDOUT_FILENO`
- `2`: `STDERR_FILENO`

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
    - `O_CREAT`: Create file if it doesn't exist (requires `mode`).
    - `O_TRUNC`: Truncate file to zero length if it exists.
  - `mode`: (Only used with `O_CREAT`) File permissions (e.g., `0644`).
- **Returns**: New `fd` on success, `-1` on error.

### 2. `read()`
Reads up to `count` bytes from `fd` into `buf`.
```c
ssize_t read(int fd, void* buf, size_t count);
```
- **Parameters**:
  - `fd`: The file descriptor to read from.
  - `buf`: Pointer to the buffer where data will be stored.
  - `count`: Maximum number of bytes to read.
- **Returns**: 
  - `> 0`: Number of bytes actually read.
  - `0`: End of File (EOF).
  - `-1`: Error (check `errno`).

### 3. `write()`
Writes up to `count` bytes from `buf` to `fd`.
```c
ssize_t write(int fd, const void* buf, size_t count);
```
- **Parameters**:
  - `fd`: The file descriptor to write to.
  - `buf`: Pointer to the data to be written.
  - `count`: Number of bytes to write.
- **Returns**: Number of bytes actually written, or `-1` on error.

### 4. `close()`
Closes a file descriptor so it no longer refers to any file.
```c
int close(int fd);
```
- **Returns**: `0` on success, `-1` on error.

---

## Important: Handling Short Counts
POSIX I/O calls can return **short counts** (reading/writing fewer bytes than requested). This can happen due to:
- Interruption by a signal (`errno == EINTR`).
- Reading from a pipe or network socket.
- Reaching EOF mid-read.

**Correct Usage (The Read Loop)**:
```c
ssize_t res;
size_t bytes_left = count;
char* ptr = buf;

while (bytes_left > 0) {
    res = read(fd, ptr, bytes_left);
    if (res == -1) {
        if (errno == EINTR) continue; // Interrupted, try again
        break; // Real error
    }
    if (res == 0) break; // EOF
    bytes_left -= res;
    ptr += res;
}
```

## Error Handling
POSIX functions return `-1` on error and set the global variable **errno**.
- Always check for `-1` and handle `EINTR` specifically.

## Related
- [[Standard C Streams]]
- [[System Calls]]
- [[POSIX perror]]
- [[Directory IO]]
