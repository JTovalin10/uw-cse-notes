# wc

**[[wc]]**: Short for "word count," it is used to count lines, words, characters, and bytes in files or standard input.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-l`, `--lines` | Count the number of newline characters (effectively counting lines). |
| `-w`, `--words` | Count the number of words. |
| `-c`, `--bytes` | Count the number of bytes. |
| `-m`, `--chars` | Count the number of characters (different from bytes for multibyte text). |
| `-L`, `--max-line-length` | Print the length of the longest line. |

## Usage Examples

### 1. Basic usage
Print lines, words, and bytes for a file.
```bash
wc essay.txt
# Output: 45 320 1850 essay.txt
```

### 2. Count only lines
The most common usage of `wc`.
```bash
wc -l script.sh
```

### 3. Count files in a directory
Combine with `ls` or `find` to see how many files are present.
```bash
ls | wc -l
```

### 4. Use multiple flags
Count lines and words only.
```bash
wc -lw report.pdf
```

### 5. Check multiple files
Provides counts for each file and a "total" at the bottom.
```bash
wc -l part1.txt part2.txt
```

### 6. Read from standard input
Count the number of processes currently running.
```bash
ps aux | wc -l
```
