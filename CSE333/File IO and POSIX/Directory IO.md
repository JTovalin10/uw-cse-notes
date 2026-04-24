# CSE 333: Directory IO

POSIX provides functions to interact with the file system's directory structure.

## Directory Functions (`<dirent.h>`)
- **opendir()**: `DIR* opendir(const char* name)`
  - Opens a directory stream.
- **readdir()**: `struct dirent* readdir(DIR* dirp)`
  - Returns a pointer to a struct representing the next directory entry.
  - Returns `NULL` at the end of the directory or on error.
- **closedir()**: `int closedir(DIR* dirp)`

## struct dirent
Contains information about a file, including:
- `ino_t d_ino`: Inode number.
- `char d_name[]`: Filename.

## Manual Sections
When looking up documentation:
- `man 2 <func>`: System calls (e.g., `man 2 open`).
- `man 3 <func>`: Library functions (e.g., `man 3 fopen`, `man 3 opendir`).

Related: [[POSIX IO]]
