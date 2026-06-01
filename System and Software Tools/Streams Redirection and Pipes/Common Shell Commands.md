# CSE391: Common Shell Commands (Streams)

These are some of the most frequently used commands for processing text and files in the Unix/Linux environment, particularly in the context of [[System and Software Tools/Streams Redirection and Pipes/Pipes|pipes]] and [[Input Output Redirection|redirection]].

## Text Processing Commands

- **[[grep|grep]]**: Searches for patterns in text.
    - `grep "pattern" file`
- **[[wc|wc]]**: Counts words, lines, or characters.
    - `wc -l file` (count lines)
- **[[sort|sort]]**: Sorts lines of text.
- **[[uniq|uniq]]**: Filters out repeated lines (usually requires sorted input).
- **[[head|head]]**: Outputs the first part of a file.
    - `head -n 5 file` (first 5 lines)
- **[[tail|tail]]**: Outputs the last part of a file.

## Utility Commands

- **[[echo|echo]]**: Prints text to the terminal.
- **[[cat|cat]]**: Concatenates and displays files.
- **less**: Displays file content one page at a time (better for large files than `cat`).

## Wildcards

**Wildcards** are special characters used to select multiple files at once.
- `*`: Matches any string of characters.
    - Example: `ls *.java` (list all Java files).
    - Example: `grep "TODO" project/*` (search for TODO in all files within the `project` folder).
- `?`: Matches any single character.

## Related
- [[Basic Commands|Full Command Reference]]
- [[System and Software Tools/Linux Fundamentals/Common Shell Commands|Common Shell Commands (Linux Fundamentals)]]
- [[System and Software Tools/Streams Redirection and Pipes/Pipes|Pipes]]
