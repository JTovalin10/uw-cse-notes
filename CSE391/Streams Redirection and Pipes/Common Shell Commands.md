# CSE391: Common Shell Commands (Streams)

These are some of the most frequently used commands for processing text and files in the Unix/Linux environment, particularly in the context of [[CSE391/Streams Redirection and Pipes/Pipes|pipes]] and [[CSE391/Streams Redirection and Pipes/Input Output Redirection|redirection]].

## Text Processing Commands

- **[[CSE391/Linux Fundamentals/Commands/grep|grep]]**: Searches for patterns in text.
    - `grep "pattern" file`
- **[[CSE391/Linux Fundamentals/Commands/wc|wc]]**: Counts words, lines, or characters.
    - `wc -l file` (count lines)
- **[[CSE391/Linux Fundamentals/Commands/sort|sort]]**: Sorts lines of text.
- **[[CSE391/Linux Fundamentals/Commands/uniq|uniq]]**: Filters out repeated lines (usually requires sorted input).
- **[[CSE391/Linux Fundamentals/Commands/head|head]]**: Outputs the first part of a file.
    - `head -n 5 file` (first 5 lines)
- **[[CSE391/Linux Fundamentals/Commands/tail|tail]]**: Outputs the last part of a file.

## Utility Commands

- **[[CSE391/Linux Fundamentals/Commands/echo|echo]]**: Prints text to the terminal.
- **[[CSE391/Linux Fundamentals/Commands/cat|cat]]**: Concatenates and displays files.
- **less**: Displays file content one page at a time (better for large files than `cat`).

## Wildcards

**Wildcards** are special characters used to select multiple files at once.
- `*`: Matches any string of characters.
    - Example: `ls *.java` (list all Java files).
    - Example: `grep "TODO" project/*` (search for TODO in all files within the `project` folder).
- `?`: Matches any single character.

## Related
- [[CSE391/Linux Fundamentals/Basic Commands|Full Command Reference]]
- [[CSE391/Linux Fundamentals/Common Shell Commands|Common Shell Commands (Linux Fundamentals)]]
- [[CSE391/Streams Redirection and Pipes/Pipes|Pipes]]
