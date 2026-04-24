# ls

**[[ls]]**: List directory contents. It is one of the most frequently used commands to navigate the filesystem.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-l` | Use a long listing format (shows permissions, owner, size, and date). |
| `-a`, `--all` | Do not ignore entries starting with `.` (shows hidden files). |
| `-h`, `--human-readable` | With `-l`, print sizes in human-readable format (e.g., 1K, 234M, 2G). |
| `-t` | Sort by modification time, newest first. |
| `-S` | Sort by file size, largest first. |
| `-r`, `--reverse` | Reverse order while sorting. |
| `-R`, `--recursive` | List subdirectories recursively. |
| `-F`, `--classify` | Append indicator (one of `*/=>@|`) to entries. |

## Usage Examples

### 1. Simple list
List files in the current directory.
```bash
ls
```

### 2. Detailed listing
See file sizes and permissions.
```bash
ls -l
```

### 3. Show hidden files
List everything, including configuration files like `.bashrc`.
```bash
ls -a
```

### 4. Sort by time
See the files you most recently modified.
```bash
ls -lt
```

### 5. Human-readable sizes
Make the output of `-l` easier to read.
```bash
ls -lh
```

### 6. Recursive list
See all files in the current directory and all subfolders.
```bash
ls -R
```

### 7. List a specific directory
You don't have to be in the directory to list it.
```bash
ls /etc
```
