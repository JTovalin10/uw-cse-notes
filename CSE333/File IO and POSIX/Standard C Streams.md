# CSE333: Standard C Streams

The C standard library (`<stdio.h>`) provides a high-level abstraction for file I/O called **streams**. Streams sit on top of [[CSE333/File IO and POSIX/POSIX IO|POSIX I/O]] and add buffering and formatted I/O.

## Streams and FILE*

- A stream is a sequence of characters read from or written to a device (a file, terminal, network socket, etc.).
- Managed via a `FILE*` pointer — an opaque handle to the stream's internal state.
- Three streams are provided by default:
  - **`stdin`**: Standard input (keyboard by default).
  - **`stdout`**: Standard output (terminal by default).
  - **`stderr`**: Standard error (terminal by default, unbuffered).

## Stream Functions

- **`fopen()`**: `FILE* fopen(const char* path, const char* mode)`
  - Modes: `"r"` (read), `"w"` (write, truncates), `"a"` (append), `"rb"` (read binary), `"wb"` (write binary).
  - Returns `NULL` on failure.
- **`fclose()`**: `int fclose(FILE* stream)` — Flushes the buffer and closes the stream.
- **`fread()`**: `size_t fread(void* ptr, size_t size, size_t nmemb, FILE* stream)` — Reads `nmemb` items of `size` bytes each.
- **`fwrite()`**: `size_t fwrite(const void* ptr, size_t size, size_t nmemb, FILE* stream)` — Writes `nmemb` items.
- **`fprintf()` / `fscanf()`**: Formatted I/O to/from a stream.

## Error Handling

- **`perror()`**: Prints a message and the error string associated with the global `errno`. See [[CSE333/File IO and POSIX/POSIX perror|POSIX perror]] for details.
- **`ferror()`**: Returns non-zero if the error indicator is set for a stream.
- **`clearerr()`**: Resets the error and EOF indicators on a stream.

## Buffering

By default, `stdio` uses **buffering** to improve performance by grouping many small writes or reads into a single larger system call.

- **Flush**: Data is "drained" to the destination when the buffer is full, `fflush()` is called, the stream is closed, or the program exits gracefully via `exit()`.
- **Reliability**: Buffering can lead to data loss if the program crashes (e.g., `SIGSEGV`) before a flush, since buffered data never reaches the file.
- **Performance**: Standard streams are generally faster than raw POSIX I/O for small, frequent I/O operations, but can be slower for very high-performance applications that require zero-copy I/O.
- **Disable Buffering**: Use `setbuf(stream, NULL)` to make a stream unbuffered — useful for `stderr`-style logging.

## Related

- [[CSE333/File IO and POSIX/System Calls|System Calls]]
- [[CSE333/File IO and POSIX/POSIX IO|POSIX IO]]
- [[CSE333/File IO and POSIX/POSIX perror|POSIX perror]]
- [[CSE333/File IO and POSIX/Directory IO|Directory IO]]

## Industry Standard Terms

- **Stream** — An abstraction over sequential data flow; the concept is generalized in C++ via `std::istream` / `std::ostream`
- **`FILE*`** — An opaque "file handle"; in C++, replaced by `std::fstream`, `std::ifstream`, `std::ofstream`
- **Buffered I/O** — Groups multiple small I/O calls into one large system call; the opposite is "unbuffered" or "direct" I/O
- **`fflush()`** — Forces the buffer to be written to the underlying file descriptor; critical for ensuring data durability before a process exit or crash
