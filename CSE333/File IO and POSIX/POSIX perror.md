# POSIX perror

`perror()` is a standard library function in C used to print a descriptive error message to `stderr`.

## Usage

```c
#include <stdio.h>

void perror(const char *s);
```

When a system call or library function fails, it usually sets a global integer variable called **`errno`** to a specific value representing the error.

`perror()` does the following:
1.  Prints the string `s` (if it is not `NULL` and not empty).
2.  Prints a colon and a space.
3.  Prints the system error message corresponding to the current value of `errno`.
4.  Prints a newline.

## Example

```c
FILE *fp = fopen("nonexistent_file.txt", "r");
if (fp == NULL) {
    perror("Error opening file");
}
```
**Output:**
`Error opening file: No such file or directory`

## Relation to errno
While `perror()` prints to `stderr`, you can use **`strerror()`** (from `<string.h>`) to get the error message string directly if you need to log it elsewhere or process it.

## Related
- [[Standard C Streams]] — information on `stderr`
- [[Process Management]] — where `perror` is commonly used after `fork` or `exec` failures
