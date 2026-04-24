# mv

**[[mv]]**: Short for "move." It is used to move or rename files and directories.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-i`, `--interactive` | Prompt before overwriting an existing file. |
| `-f`, `--force` | Do not prompt before overwriting (default if not interactive). |
| `-n`, `--no-clobber` | Do not overwrite an existing file. |
| `-u`, `--update` | Move only when the source is newer than the destination or when destination is missing. |
| `-v`, `--verbose` | Print a message for every file moved. |

## Usage Examples

### 1. Rename a file
Renaming is just moving a file to a new name in the same location.
```bash
mv old_name.txt new_name.txt
```

### 2. Move a file to another directory
Moves the file out of the current folder.
```bash
mv report.pdf Documents/
```

### 3. Rename a directory
Works exactly like renaming a file.
```bash
mv folder1/ project_folder/
```

### 4. Move multiple files
The last argument must be a directory.
```bash
mv *.jpg *.png images/
```

### 5. Interactive move
Asks before replacing a file that already exists at the destination.
```bash
mv -i script.sh backup/
```

### 6. Do not overwrite anything
Skips the move if the file already exists.
```bash
mv -n data.csv old_data.csv
```
