# pwd

**[[pwd]]**: Short for "print working directory." It shows the full absolute path of the directory you are currently in.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-L`, `--logical` | Use PWD from environment, even if it contains symlinks. |
| `-P`, `--physical` | Avoid all symlinks (show the physical directory). |

## Usage Examples

### 1. Identify your location
The most common usage of the command.
```bash
pwd
# Example Output: /home/justin/Desktop/uw-cse-notes/CSE391
```

### 2. Physical path vs. Symbolic link
If you are inside a directory that is a link, use `-P` to see the actual path on disk.
```bash
cd /var/mail
pwd     # Output: /var/mail
pwd -P  # Output: /var/spool/mail
```

### 3. Store path in a variable
In shell scripting, you can store the current path for later use.
```bash
CURRENT_DIR=$(pwd)
echo "The script is running in $CURRENT_DIR"
```
