# CSE 333: Standard C Streams

The C standard library (`<stdio.h>`) provides a high-level abstraction for file I/O called **streams**.

## Streams and FILE*
- A stream is a sequence of characters read from or written to a device.
- Managed via a `FILE*` pointer.
- Three streams are provided by default: `stdin`, `stdout`, and `stderr`.

## Stream Functions
- **fopen()**: `FILE* fopen(const char* path, const char* mode)`
  - Modes: `"r"` (read), `"w"` (write), `"a"` (append), `"rb"` (read binary), `"wb"` (write binary).
- **fclose()**: `int fclose(FILE* stream)`
- **fread()**: `size_t fread(void* ptr, size_t size, size_t nmemb, FILE* stream)`
- **fwrite()**: `size_t fwrite(const void* ptr, size_t size, size_t nmemb, FILE* stream)`
- **fprintf() / fscanf()**: Formatted I/O.

## Error Handling
- **perror()**: Prints a message and the error string associated with the global `errno`.
- **ferror()**: Checks if the error indicator is set for a stream.
- **clearerr()**: Resets error and EOF indicators.

## Buffering
By default, `stdio` uses **buffering** to improve performance by grouping many small writes/reads into a single larger operation.
- **Flush**: Data is "drained" to the destination when the buffer is full, `fflush()` is called, the stream is closed, or the program exits gracefully.
- **Reliability**: Buffering can lead to data loss if the program crashes before a flush.
- **Performance**: Standard streams are generally faster for small I/O but can be slower for very high-performance applications that require "zero-copy".
- **Disable Buffering**: Use `setbuf(stream, NULL)`.

Related: [[System Calls]], [[POSIX IO]]
