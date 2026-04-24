# CSE391: Common Shell Commands

These are some of the most frequently used commands for processing text and files in the Unix/Linux environment.

## Text Processing Commands
- **[[grep]]**: Searches for patterns in text.
    - `grep "pattern" file`
- **[[wc]]**: Counts words, lines, or characters.
    - `wc -l file` (count lines)
- **[[sort]]**: Sorts lines of text.
- **[[uniq]]**: Filters out repeated lines (usually requires sorted input).
- **[[head]]**: Outputs the first part of a file.
    - `head -n 5 file` (first 5 lines)
- **[[tail]]**: Outputs the last part of a file.

## Utility Commands
- **[[echo]]**: Prints text to the terminal.
- **[[cat]]**: Concatenates and displays files.
- **less**: Displays file content one page at a time (better for large files than `cat`).

## Wildcards
**[[Wildcards]]** are special characters used to select multiple files at once.
- `*`: Matches any string of characters.
    - Example: `ls *.java` (list all Java files).
    - Example: `grep "TODO" project/*` (search for TODO in all files within the `project` folder).
- `?`: Matches any single character.

## Related/See-also
- [[Linux Fundamentals/Basic Commands|Basic Commands]]
- [[Streams Redirection and Pipes/Pipes|Pipes]]
