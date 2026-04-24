# Find and Cut

**[[find]]** and **[[cut]]** are powerful tools for searching the file system and extracting specific portions of text data.

## find
The **[[find]]** command is a versatile utility for searching for files and directories based on various criteria.

### Common Filters and Flags
| Filter / Flag | Description |
| :--- | :--- |
| `-name` | Search by filename (case-sensitive). |
| `-iname` | Search by filename (case-insensitive). |
| `-type f` | Search for files only. |
| `-type d` | Search for directories only. |
| `-size` | Search by file size (e.g., `+5M` for > 5 MB, `-10k` for < 10 KB). |
| `-mtime` | Search by modification time (e.g., `-7` for within 7 days). |
| `-user` | Search for files owned by a specific user. |
| `-exec` | Run a command on every file found. |
| `-maxdepth` | Limit the search depth to a specific level. |
| `-delete` | Delete files that match the criteria. |

### Usage Examples
- **Find by name:** `find . -name "*.java"` (all Java files in current dir and subfolders).
- **Find and Execute:** `find . -name "*.sh" -exec chmod +x {} \;` (make all shell scripts executable).
- **Find by size:** `find /var/log -size +50M` (find logs larger than 50 megabytes).
- **Find empty files:** `find . -type f -empty` (find all files with zero bytes).

---

## cut
The **[[cut]]** command extracts specific columns or fields from each line of text data.

### Common Flags
| Flag | Description |
| :--- | :--- |
| `-f`, `--fields` | Select only these fields (used with `-d`). |
| `-d`, `--delimiter` | Use a custom delimiter instead of the default TAB. |
| `-c`, `--characters` | Select only these characters (by position). |
| `--complement` | Select everything EXCEPT the specified fields/characters. |
| `--output-delimiter` | Use a different string as the output delimiter. |

### Usage Examples
- **Extract by fields (CSV):** `cut -d "," -f 1,3 data.csv` (get the 1st and 3rd columns).
- **Extract by characters:** `cut -c 1-10 names.txt` (get the first 10 characters of each line).
- **Change delimiter:** `cut -d ":" -f 1 --output-delimiter=" | " /etc/passwd` (get usernames and separate with a bar).

## Related/See-also
- [[Streams Redirection and Pipes/Common Shell Commands|Common Shell Commands]]
- [[Intermediate Command Line/Xargs|Xargs]]
