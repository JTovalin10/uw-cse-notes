# CSE391: Find and Cut

These commands are powerful tools for searching the file system and extracting specific portions of text data.

## find
The **[[find]]** command searches for files in a directory hierarchy based on various criteria (name, size, type, etc.).
- Example: `find . -name "*.java"` (finds all `.java` files in the current directory and subdirectories).

## cut
The **[[cut]]** command extracts sections (columns) from each line of input. It is particularly useful for processing CSV or other delimited data.
- **Flags:**
    - `-d`: Specifies the delimiter (default is Tab).
    - `-f`: Specifies which field(s) to extract.
    - `-c`: Specifies character positions.
- Example: `cut -d, -f4 survey.csv` (extracts the 4th column from a comma-separated file).
- Example: `cut -c1-10 file` (extracts the first 10 characters of each line).

## Related/See-also
- [[Streams Redirection and Pipes/Common Shell Commands|Common Shell Commands]]
- [[Intermediate Command Line/Xargs|Xargs]]
