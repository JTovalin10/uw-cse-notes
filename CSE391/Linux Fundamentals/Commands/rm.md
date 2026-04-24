# rm

**[[rm]]**: Short for "remove." It is used to delete files and directories from the filesystem.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-r`, `-R`, `--recursive` | Remove directories and their contents recursively. |
| `-f`, `--force` | Ignore nonexistent files and never prompt for confirmation. |
| `-i` | Prompt for confirmation before every removal. |
| `-I` | Prompt once before removing more than three files or when removing recursively. |
| `-v`, `--verbose` | Print a message for every file removed. |

## Usage Examples

### 1. Delete a single file
Permanent deletion!
```bash
rm old_notes.txt
```

### 2. Delete a directory and all its content
Necessary when the directory is not empty.
```bash
rm -rf folder_to_delete
```
*Note: The `-rf` combination is extremely powerful and dangerous. Use with caution.*

### 3. Delete with a prompt for safety
Good for preventing accidental deletion of important files.
```bash
rm -i *.java
# Output: rm: remove 'Main.java'? y
```

### 4. Remove multiple files matching a pattern
Using wildcards to clean up.
```bash
rm *.tmp temp_* log.old
```

### 5. Combine with find (advanced)
Search for old logs and remove them.
```bash
find /var/log -name "*.log" -mtime +30 -exec rm {} \;
```

### 6. Delete empty directories (alternate)
If you only want to delete a directory if it is empty, use `rmdir`.
```bash
rmdir empty_folder
```
