# CSE333: POSIX perror

**`perror()`** is a standard library function in C used to print a descriptive error message to `stderr` after a system call or library function fails.

## Usage

```c
#include <stdio.h>

void perror(const char *s);
```

When a system call or library function fails, it sets a global integer variable called **`errno`** (defined in `<errno.h>`) to a specific value representing the error type.

`perror()` performs the following steps:

1. Prints the string `s` (if it is not `NULL` and not empty).
2. Prints a colon and a space: `": "`.
3. Prints the system error message corresponding to the current value of `errno`.
4. Prints a newline.

## Example

```c
FILE *fp = fopen("nonexistent_file.txt", "r");
if (fp == NULL) {
    perror("Error opening file");
    // Output: Error opening file: No such file or directory
}
```

```c
int fd = open("missing.txt", O_RDONLY);
if (fd == -1) {
    perror("open failed");
    // Output: open failed: No such file or directory
}
```

## Relation to errno and strerror

`perror()` always prints to `stderr`. If you need the error message string for logging elsewhere or want to format it into a custom message, use **`strerror()`** from `<string.h>`:

```c
fprintf(log_file, "Operation failed: %s\n", strerror(errno));
```

**Important**: `errno` is only meaningful immediately after a failing call. The next system call may overwrite it, so always check and save/print `errno` before making any additional calls.

## Related

- [[Standard C Streams|Standard C Streams]] — information on `stderr`
- [[POSIX IO|POSIX IO]] — where `errno` is set by `open`, `read`, `write`, `close`
- [[Systems Programming/Process Management/Process Management|Process Management]] — where `perror` is commonly used after `fork` or `exec` failures

## Industry Standard Terms

- **`errno`** — A POSIX-standard thread-local global; in multithreaded code it is implemented as a thread-local variable so each thread has its own `errno`
- **`strerror()`** — Converts an `errno` integer to a human-readable string; use `strerror_r()` (the reentrant version) in multithreaded code
- **`perror()`** — The simplest error-reporting idiom; production code often uses structured logging instead (e.g., syslog, log4c)
