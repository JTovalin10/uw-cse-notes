# sed

**[[Sed Commands]]**: Short for "Stream Editor," it is a non-interactive text editor that processes input (files or standard input) line-by-line and applies specific commands to the text. It is a cornerstone of Unix text processing.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-i[SUFFIX]` | **In-place editing:** Modifies the file directly. If a suffix is provided (e.g., `-i.bak`), a backup is created. |
| `-E`, `-r` | **Extended Regex:** Enables extended regular expression syntax (e.g., `+`, `?`, `|`, `()`). |
| `-n`, `--quiet` | **Suppress printing:** By default, `sed` prints every line. `-n` suppresses this, usually used with the `p` command. |
| `-f script-file` | **Script file:** Reads `sed` commands from a specified file instead of the command line. |
| `-e script` | **Multiple scripts:** Allows you to chain multiple commands from the command line. |

## The Substitution Command (`s`)
Syntax: `sed 's/pattern/replacement/flags' file`

### Substitution Flags
| Flag | Description |
| :--- | :--- |
| `g` | **Global:** Replaces all occurrences on a line, not just the first one. |
| `I`, `i` | **Case-insensitive:** Matches the pattern regardless of case. |
| `n` | **Ordinal:** Replaces only the *n*-th occurrence on a line (e.g., `s/old/new/2`). |
| `p` | **Print:** If substitution occurred, print the result (usually used with `-n`). |
| `w file` | **Write:** If substitution occurred, write the result to the specified file. |

## Other Common Commands
| Command | Action | Example |
| :--- | :--- | :--- |
| `d` | **Delete:** Removes lines matching the pattern or range. | `sed '1,5d' file` |
| `p` | **Print:** Displays the current line. | `sed -n '1,5p' file` |
| `q` | **Quit:** Stops processing after reaching a certain line. | `sed '10q' file` |
| `a` | **Append:** Adds text *after* a specific line. | `sed '3a New line' file` |
| `i` | **Insert:** Adds text *before* a specific line. | `sed '3i New line' file` |
| `c` | **Change:** Replaces the entire line with new text. | `sed '3c New line' file` |

---

## Usage Examples

### 1. Basic Substitution (Global)
Replace every instance of "Windows" with "Linux".
```bash
sed 's/Windows/Linux/g' intro.txt
```

### 2. In-place Editing with Backup
Update a configuration file and save the original as `.old`.
```bash
sed -i.old 's/PORT=80/PORT=8080/g' config.env
```

### 3. Case-Insensitive Matching
Replace "error", "Error", or "ERROR".
```bash
sed 's/error/FIXED/gI' log.txt
```

### 4. Delete Lines by Range or Pattern
Remove the first 10 lines, or remove any line containing "DEBUG".
```bash
sed '1,10d' data.csv
sed '/DEBUG/d' application.log
```

### 5. Capture Groups and Backreferences (Advanced)
Swap the first and last name in a "First Last" format. `\1` and `\2` refer to the parenthesized groups.
```bash
sed -E 's/([A-Z][a-z]+) ([A-Z][a-z]+)/\2, \1/' names.txt
# Input: Justin Camara -> Output: Camara, Justin
```

### 6. Address Filtering
Run a command only on specific lines (e.g., replace "TODO" only on lines 50 through 100).
```bash
sed '50,100s/TODO/DONE/g' project.md
```

### 7. Using Different Delimiters
If you are editing file paths, use `|` or `#` instead of `/` to avoid escaping.
```bash
sed 's|/usr/bin|/usr/local/bin|g' setup.sh
```

### 8. Print only matching lines
Simulate `grep` behavior using `sed`.
```bash
sed -n '/critical_error/p' system.log
```

### 9. Multiple commands at once
Use the `-e` flag or a semicolon.
```bash
sed -e 's/cat/dog/g' -e 's/red/blue/g' file.txt
# OR
sed 's/cat/dog/g; s/red/blue/g' file.txt
```
