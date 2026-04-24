# cp

**[[cp]]**: Short for "copy." It is used to copy files and directories from one location to another.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-r`, `-R`, `--recursive` | Copy directories and their contents recursively. |
| `-i`, `--interactive` | Prompt before overwriting an existing file. |
| `-p` | Preserve file attributes (mode, ownership, timestamps). |
| `-u`, `--update` | Copy only when the source file is newer than the destination file. |
| `-v`, `--verbose` | Print a message for every file copied. |
| `-a`, `--archive` | Copy everything recursively and preserve all attributes (equivalent to `-dpR`). |

## Usage Examples

### 1. Copy a file to a new name
Creates an identical copy in the same directory.
```bash
cp data.txt data_backup.txt
```

### 2. Copy a file into a directory
Moves a copy of the file into the specified folder.
```bash
cp script.sh ~/bin/
```

### 3. Copy a directory
Requires the `-r` flag to copy all files inside.
```bash
cp -r project/ backup_project/
```

### 4. Interactive copy
Prompts before overwriting to prevent data loss.
```bash
cp -i file.txt destination/
```

### 5. Preserve timestamps and permissions
Useful for backups when you want to keep the original creation date.
```bash
cp -p original.docx copy.docx
```

### 6. Copy multiple files into a directory
List all source files followed by the destination folder.
```bash
cp file1.txt file2.txt image.png gallery/
```
