# CSE391: Sed Basics

**[[Sed Commands|sed]]** (Stream Editor) is a powerful utility used to parse and transform text in a functional and automated way. Unlike a typical text editor, `sed` processes text line-by-line and outputs the result to **[[Standard Streams#(2) stdout (Standard Output) — File Descriptor 1|stdout]]**.

## Basic Syntax

`sed [options] 'command' file`

### Common Options

| Option | Description |
| :--- | :--- |
| `-n` | Suppress automatic printing of pattern space. |
| `-e script` | Add the script to the commands to be executed. |
| `-f script-file` | Add the contents of script-file to the commands to be executed. |
| `-i` | Edit files in-place (modifies the original file directly). |
| `-E` | Use extended regular expressions. |

## How sed Works

`sed` reads input one line at a time into a "pattern space," applies the specified commands, then (by default) prints the result to stdout and moves to the next line. The `-n` flag suppresses this automatic printing, allowing you to print only specific lines with the `p` command.

## Related
- [[Sed Commands|Detailed Sed Reference (Flags & Examples)]]
- [[Find and Replace with Sed|Find and Replace with Sed]]
- [[Regex Basics|Regex Basics and Syntax]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
| :--- | :--- |
| sed | GNU sed — Stream EDitor |
| Pattern space | sed's internal line buffer |
| In-place editing (`-i`) | In-place file modification |
