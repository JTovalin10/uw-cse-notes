# cut

**[[cut]]**: Extracts specific columns, fields, or characters from each line of a text file or standard input. It is particularly useful for processing structured data like CSVs or log files.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-f`, `--fields` | Select only these fields (used with `-d`). |
| `-d`, `--delimiter` | Use a custom delimiter instead of the default TAB. |
| `-c`, `--characters` | Select only these characters (by position). |
| `--complement` | Select everything EXCEPT the specified fields/characters. |
| `--output-delimiter` | Use a different string as the output delimiter. |

## Usage Examples

### 1. Extract by fields (default TAB delimiter)
Extract the first and third fields from a file.
```bash
cut -f 1,3 data.tsv
```

### 2. Specify a custom delimiter
Extract the username (1st field) from the `/etc/passwd` file, which uses `:` as a separator.
```bash
cut -d ":" -f 1 /etc/passwd
```

### 3. Extract a range of characters
Get the first 10 characters of every line.
```bash
cut -c 1-10 file.txt
```

### 4. Extract from specific character to end
Get everything from the 5th character onwards.
```bash
cut -c 5- file.txt
```

### 5. Complement (exclude specific fields)
Show everything except the 2nd field.
```bash
cut -d "," -f 2 --complement data.csv
```

### 6. Change output delimiter
Extract fields but separate them with a different character in the output.
```bash
cut -d ":" -f 1,3 --output-delimiter=" | " /etc/passwd
```
