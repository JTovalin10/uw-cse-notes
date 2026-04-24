# grep

**[[grep]]**: Searches for patterns (regular expressions) in files or standard input. It is one of the most powerful and widely used tools in the command line for filtering data.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-i`, `--ignore-case` | Case-insensitive search. |
| `-v`, `--invert-match` | Select lines that DO NOT match the pattern. |
| `-r` / `-R`, `--recursive` | Search directories recursively. |
| `-n`, `--line-number` | Prefix each line of output with its 1-based line number. |
| `-l`, `--files-with-matches` | Print only the names of files containing matches. |
| `-c`, `--count` | Print only a count of matching lines per file. |
| `-E`, `--extended-regexp` | Interpret the pattern as an extended regular expression (ERE). |
| `-w`, `--word-regexp` | Select only lines containing matches that form whole words. |
| `-A n` / `-B n` / `-C n` | Show `n` lines of After / Before / Context (both) around matches. |

## Usage Examples

### 1. Simple search
Find all lines containing "TODO" in `task.txt`.
```bash
grep "TODO" task.txt
```

### 2. Case-insensitive search
Find "error", "Error", or "ERROR" in a log file.
```bash
grep -i "error" server.log
```

### 3. Invert search (Exclude patterns)
Find all lines that DO NOT contain "success".
```bash
grep -v "success" results.csv
```

### 4. Recursive search across files
Find where a function is used in a large project folder.
```bash
grep -r "myFunction" src/
```

### 5. Count matches
See how many times "login" appears in the auth log.
```bash
grep -c "login" /var/log/auth.log
```

### 6. Search with line numbers
Identify where a pattern occurs for easy editing.
```bash
grep -n "bug" script.sh
```

### 7. Find whole words only
Only matches "cat", but not "concatenate".
```bash
grep -w "cat" document.txt
```

### 8. Use context around matches
See 3 lines of code before and after a specific keyword.
```bash
grep -C 3 "CRITICAL" system.log
```
