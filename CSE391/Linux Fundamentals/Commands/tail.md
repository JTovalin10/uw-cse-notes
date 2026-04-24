# tail

**[[tail]]**: Displays the last few lines of a file or standard input. By default, it outputs the last 10 lines.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-n`, `--lines` | Display the last `n` lines. |
| `-c`, `--bytes` | Display the last `n` bytes. |
| `-f`, `--follow` | Keep the file open and output new data as it is appended (live view). |
| `-q`, `--quiet` | Never print headers giving file names. |
| `-v`, `--verbose` | Always print headers giving file names. |

## Usage Examples

### 1. View end of a file (default)
Displays the last 10 lines.
```bash
tail server.log
```

### 2. View a specific number of lines
Show only the last 50 lines.
```bash
tail -n 50 application.log
```
*Note: Short notation like `tail -50 file.log` also works.*

### 3. Use with positive line count
Start printing from line `n` to the end of the file.
```bash
tail -n +20 big_data.csv  # Prints starting from the 20th line
```

### 4. Real-time log monitoring
The most common use case for developers. Automatically prints new lines as they arrive.
```bash
tail -f access.log
```

### 5. Combine with grep
Monitor a live log but only show lines with "ERROR".
```bash
tail -f access.log | grep "ERROR"
```

### 6. View end of multiple files
Shows headers for each file to distinguish them.
```bash
tail file1.txt file2.txt
```
