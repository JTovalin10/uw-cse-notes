# cd

**[[cd]]**: Change the shell working directory. It is the primary command used for navigating the Unix directory tree.

## Common Flags
The `cd` command is a shell builtin and does not have many standard flags, but it has several useful shortcuts.

## Navigation Shortcuts
| Shortcut | Description |
| :--- | :--- |
| `cd ..` | Go up to the parent directory. |
| `cd` (by itself) | Go to your home directory. |
| `cd ~` | Go to your home directory. |
| `cd -` | Go to the previous working directory (toggle between two locations). |
| `cd /` | Go to the root directory. |
| `cd /path/to/dir` | Go to an absolute path. |
| `cd relative/path` | Go to a relative path from current directory. |

## Usage Examples

### 1. Move to a subdirectory
Go into a folder named `Documents`.
```bash
cd Documents
```

### 2. Move up one level
Exit the current folder and go to its parent.
```bash
cd ..
```

### 3. Move up two levels
Jump two folders up in the hierarchy.
```bash
cd ../..
```

### 4. Jump back to previous folder
Very useful for quickly toggling between two different directories.
```bash
cd -
```

### 5. Return home
Instantly return to your home directory (`/home/username`).
```bash
cd
```

### 6. Use tilde for home paths
Access folders relative to your home directory.
```bash
cd ~/Desktop/projects
```
