# CSE391: Sed Basics

**[[sed]]** (Stream Editor) is a powerful utility used to parse and transform text in a functional and automated way. Unlike a typical text editor, `sed` processes text line-by-line and outputs the result to **[[stdout]]**.

## Basic Syntax
`sed [options] 'command' file`

Common options:
- `-E`: Use extended regular expressions (recommended).
- `-i`: Edit the file "in-place" (be careful!).
- `-n`: Suppress automatic printing of lines.

## Basic Commands
- **Printing:** `sed -n '5p' file` (prints only the 5th line).
- **Deleting:** `sed '1,3d' file` (deletes lines 1 through 3 from the output).
- **Substitution:** The most common use of `sed`.

## Related/See-also
- Find and Replace with Sed
- [[Regular Expressions/Regex Basics|Regex Basics and Syntax]]
