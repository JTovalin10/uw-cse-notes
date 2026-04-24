# sort

**[[sort]]**: Reorders the lines of a text file or standard input. It is one of the most powerful tools for organizing and processing data in the shell.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-n`, `--numeric-sort` | Sort based on numeric values (otherwise 10 comes before 2). |
| `-r`, `--reverse` | Sort in reverse order (e.g., Z to A). |
| `-u`, `--unique` | Output only the first of an equal run (effectively removes duplicates). |
| `-k`, `--key` | Sort based on a specific column/field. |
| `-t`, `--field-separator` | Use a custom delimiter for columns (default is whitespace). |
| `-f`, `--ignore-case` | Ignore case differences (treats 'a' and 'A' the same). |
| `-M`, `--month-sort` | Sort by month name (JAN, FEB, etc.). |
| `-h`, `--human-numeric-sort` | Sort human-readable numbers (e.g., 2K, 1G). |

## Usage Examples

### 1. Basic alphabetical sort
Sort lines from A to Z.
```bash
sort names.txt
```

### 2. Sort numbers numerically
Crucial for sorting numeric data properly.
```bash
sort -n grades.csv
```

### 3. Sort in reverse
List newest files by date (if using timestamp data).
```bash
sort -r unsorted_list.txt
```

### 4. Sort by a specific column
Sort a CSV file based on the second column (age), using a comma as a delimiter.
```bash
sort -t "," -k 2,2 -n data.csv
```

### 5. Remove duplicates while sorting
Handy for quickly cleaning up lists.
```bash
sort -u raw_logs.txt
```

### 6. Human-readable sort
Sort file sizes from `du` command.
```bash
du -h | sort -h
```

### 7. Combine with pipes
See which commands you use most (combined with `uniq`).
```bash
history | cut -c 8- | sort | uniq -c | sort -nr | head
```
