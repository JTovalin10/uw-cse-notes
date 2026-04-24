# CSE391: Sed Basics

**[[Sed/Sed Commands|sed]]** (Stream Editor) is a powerful utility used to parse and transform text in a functional and automated way. Unlike a typical text editor, `sed` processes text line-by-line and outputs the result to **[[Streams Redirection and Pipes/Standard Streams#2. stdout (Standard Output) - File Descriptor 1|stdout]]**.

## Basic Syntax
`sed [options] 'command' file`

Common options:
- `-n`: Suppress automatic printing of pattern space.
- `-e script`: Add the script to the commands to be executed.
- `-f script-file`: Add the contents of script-file to the commands to be executed.
- `-i`: Edit files in-place.
- `-E`: Use extended regular expressions.

## Related/See-also
- [[Sed/Sed Commands|Detailed Sed Reference (Flags & Examples)]]
- [[Regular Expressions/Regex Basics|Regex Basics and Syntax]]
