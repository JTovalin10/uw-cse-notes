# CSE 333: POSIX IO

**POSIX I/O** provides low-level, unbuffered access to files and devices. These are thin wrappers around Linux system calls.

## File Descriptors
Instead of `FILE*`, POSIX uses **File Descriptors (fd)**, which are small non-negative integers.
- `0`: `stdin`
- `1`: `stdout`
- `2`: `stderr`

## POSIX Functions (`<unistd.h>`, `<fcntl.h>`)
- **open()**: `int open(const char* pathname, int flags, ...)`
  - Flags: `O_RDONLY`, `O_WRONLY`, `O_RDWR`, `O_CREAT`.
- **close()**: `int close(int fd)`
- **read()**: `ssize_t read(int fd, void* buf, size_t count)`
  - Returns number of bytes read, `0` for EOF, `-1` for error.
  - **Short Reads**: May read fewer bytes than requested (!!!). Code must handle this in a loop.
- **write()**: `ssize_t write(int fd, const void* buf, size_t count)`
- **lseek()**: `off_t lseek(int fd, off_t offset, int whence)`
- **fsync()**: Flushes data from the OS buffer cache to the physical device.

## Error Handling
POSIX functions return `-1` on error and set the global variable **errno**.
- Common errors: `EBADF` (bad fd), `EFAULT` (bad address), `EINTR` (interrupted system call).
- If `errno == EINTR`, the operation should usually be retried.

Related: [[Standard C Streams]], [[System Calls]]
