# xargs

**[[xargs]]**: Builds and executes command lines from standard input. It is used to convert lines of text (usually from a pipe) into arguments for another command that does not natively support standard input (**[[Streams Redirection and Pipes/Standard Streams#1. stdin (Standard Input) - File Descriptor 0|stdin]]**).

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-0`, `--null` | Input items are terminated by a null character instead of whitespace (safest for files with spaces). |
| `-I {}` | Replace occurrences of `{}` in the command with the input item. |
| `-n n` | Use at most `n` arguments per command line. |
| `-P n` | Run up to `n` processes at the same time (parallel execution). |
| `-t`, `--verbose` | Print the command on stderr before executing it. |
| `-p`, `--interactive` | Prompt the user before running each command. |

## Usage Examples

### 1. Basic bridging (Pipe to non-pipe command)
Many commands like `rm` don't read from stdin. `xargs` fixes this.
```bash
# Find all .log files and delete them
find . -name "*.log" | xargs rm
```

### 2. Handling files with spaces
The safest way to handle filenames that might contain spaces or special characters.
```bash
# -print0 uses a null character as a separator, which -0 then reads
find . -name "*.txt" -print0 | xargs -0 rm
```

### 3. Using a placeholder for arguments
Useful when the input needs to be placed in the middle of a command.
```bash
# Move every .mp3 file into a folder called 'music'
ls *.mp3 | xargs -I {} mv {} music/
```

### 4. Limit number of arguments
Run the command multiple times, each with a specific number of inputs.
```bash
# Run 'echo' for every 2 items
echo "a b c d e f" | xargs -n 2
# Output:
# a b
# c d
# e f
```

### 5. Parallel execution
Speeds up tasks by running them in parallel.
```bash
# Download multiple files at once using 4 parallel processes
cat urls.txt | xargs -n 1 -P 4 wget
```

### 6. Combining with find and grep
Find where specific keywords are located in a list of files.
```bash
find . -name "*.java" | xargs grep "TODO"
```

## Related/See-also
- [[Streams Redirection and Pipes/Standard Streams|Standard Streams]]
- [[Intermediate Command Line/Control Flow Operators|Control Flow Operators]]
