# mkdir

**[[mkdir]]**: Short for "make directory." It is used to create new folders on the filesystem.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-p`, `--parents` | Create parent directories if they don't exist (no error if they do). |
| `-m`, `--mode` | Set file permissions (mode) as the directory is created. |
| `-v`, `--verbose` | Print a message for each directory created. |

## Usage Examples

### 1. Simple directory creation
Creates a single folder in the current directory.
```bash
mkdir new_project
```

### 2. Create nested directories
Normally `mkdir a/b/c` will fail if `a` and `b` don't exist. The `-p` flag fixes this.
```bash
mkdir -p projects/2026/january
```

### 3. Create multiple directories at once
You can create multiple folders in a single command.
```bash
mkdir logs images docs tests
```

### 4. Set permissions on creation
Create a directory that only the owner can access (700).
```bash
mkdir -m 700 private_keys
```

### 5. Create with verbose output
Useful when creating multiple levels and wanting to verify.
```bash
mkdir -pv build/release/bin
# Output: mkdir: created directory 'build'
# Output: mkdir: created directory 'build/release'
# Output: mkdir: created directory 'build/release/bin'
```
