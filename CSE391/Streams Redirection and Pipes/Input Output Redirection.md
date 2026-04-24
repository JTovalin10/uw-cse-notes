# CSE391: Input/Output Redirection

**Redirection** allows you to change where a command reads its input from or writes its output to, instead of using the default terminal.

## Output Redirection (`>`)
The `>` operator redirects **[[stdout]]** to a file. If the file already exists, its contents will be overwritten.
- Example: `ls > files.txt` stores the list of files in `files.txt`.
- Example: `grep "berry" fruits.txt > berries.txt` stores all lines containing "berry" from `fruits.txt` into `berries.txt`.

## Input Redirection (`<`)
The `<` operator redirects a file's contents into a command's **[[stdin]]**.
- Example: `grep "a" < berries.txt` searches for "a" within the contents of `berries.txt`.

## Append Redirection (`>>`)
The `>>` operator redirects **[[stdout]]** to a file, but appends the output to the end of the file instead of overwriting it.

## Error Redirection (`2>`)
Since **[[stderr]]** is stream 2, you can redirect it using `2>`.
- Example: `command 2> errors.txt` redirects only the error messages to `errors.txt`.
- Example: `command > output.txt 2>&1` redirects both `stdout` and `stderr` to the same file.

## Related/See-also
- [[Streams Redirection and Pipes/Standard Streams|Standard Streams]]
- [[Streams Redirection and Pipes/Pipes|Pipes]]
