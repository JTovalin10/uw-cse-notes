# uniq

**[[uniq]]**: Filters out adjacent duplicate lines from a file or standard input. Because it only looks at *adjacent* lines, it is almost always used in combination with `sort`.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-c`, `--count` | Prefix each line with the number of times it occurred. |
| `-d`, `--repeated` | Only output duplicate lines (hide unique ones). |
| `-u`, `--unique` | Only output lines that occur exactly once. |
| `-i`, `--ignore-case` | Ignore case differences when comparing lines. |
| `-f n`, `--skip-fields=n` | Skip the first `n` fields before checking for uniqueness. |

## Usage Examples

### 1. Basic duplicate removal
Must sort the file first for `uniq` to be effective.
```bash
sort names.txt | uniq
```

### 2. Count occurrences
Determine how many times each item appears in a list.
```bash
sort fruits.txt | uniq -c
```

### 3. Identify common errors in logs
Find lines that appear more than once.
```bash
sort error.log | uniq -d
```

### 4. Find completely unique lines
Show only items that are not repeated at all.
```bash
sort list.txt | uniq -u
```

### 5. Count your most used commands
A classic example of combining `cut`, `sort`, and `uniq`.
```bash
history | cut -c 8- | sort | uniq -c | sort -nr | head
```

### 6. Case-insensitive unique check
Treat "Hello" and "hello" as the same.
```bash
sort greeting.txt | uniq -i
```
