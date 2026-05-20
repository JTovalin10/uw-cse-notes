# CSE333: Directory IO

POSIX provides functions to interact with the file system's directory structure, allowing a program to list and enumerate directory contents.

## Directory Functions (`<dirent.h>`)

- **`opendir()`**: `DIR* opendir(const char* name)`
  - Opens a directory stream for the directory at `name`.
  - Returns a `DIR*` handle, or `NULL` on error.
- **`readdir()`**: `struct dirent* readdir(DIR* dirp)`
  - Returns a pointer to a `struct dirent` representing the next directory entry.
  - Returns `NULL` at the end of the directory or on error. To distinguish EOF from error, set `errno = 0` before the call and check `errno` afterward if `NULL` is returned.
- **`closedir()`**: `int closedir(DIR* dirp)`
  - Closes the directory stream and releases resources.

## struct dirent

Contains information about a file or directory entry:

- `ino_t d_ino`: Inode number — the unique identifier for the file in the file system.
- `char d_name[]`: The filename (null-terminated string), not including the directory path.

## Typical Usage Pattern

```c
#include <dirent.h>
#include <stdio.h>

void list_directory(const char* path) {
    DIR* dir = opendir(path);
    if (dir == NULL) { perror("opendir"); return; }

    struct dirent* entry;
    while ((entry = readdir(dir)) != NULL) {
        printf("Inode: %lu  Name: %s\n", entry->d_ino, entry->d_name);
    }
    closedir(dir);
}
```

Note that every directory contains two special entries: `.` (the directory itself) and `..` (its parent).

## Manual Sections

When looking up documentation, use the correct `man` section:

- `man 2 <func>`: System calls (e.g., `man 2 open`).
- `man 3 <func>`: Library functions (e.g., `man 3 fopen`, `man 3 opendir`).

## Related

- [[CSE333/File IO and POSIX/POSIX IO|POSIX IO]]
- [[CSE333/File IO and POSIX/Standard C Streams|Standard C Streams]]
- [[CSE333/File IO and POSIX/System Calls|System Calls]]

## Industry Standard Terms

- **`DIR*`** — An opaque directory stream handle; analogous to `FILE*` for files
- **Inode** — The kernel data structure that stores file metadata (permissions, timestamps, block locations); the filename-to-inode mapping is stored in the directory entry
- **Directory entry (dirent)** — A record in a directory that maps a filename string to an inode number
