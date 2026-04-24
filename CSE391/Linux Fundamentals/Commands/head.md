# head

**[[head]]**: Displays the first few lines of a file or standard input. By default, it outputs the first 10 lines.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-n`, `--lines` | Display the first `n` lines. |
| `-c`, `--bytes` | Display the first `n` bytes. |
| `-q`, `--quiet` | Never print headers giving file names. |
| `-v`, `--verbose` | Always print headers giving file names. |

## Usage Examples

### 1. View start of a file (default)
Displays the first 10 lines.
```bash
head notes.txt
```

### 2. View a specific number of lines
Show only the first 25 lines of a long file.
```bash
head -n 25 big_file.txt
```
*Note: Short notation like `head -25 file.txt` also works.*

### 3. Use with pipes
Often used to see the first few results of a command.
```bash
find . -type f | head -n 5
```

### 4. Negative line count
Output all lines EXCEPT the last `n` lines.
```bash
head -n -10 data.csv  # Prints all but the last 10 lines
```

### 5. View start of multiple files
Shows headers for each file to distinguish them.
```bash
head file1.txt file2.txt
```
