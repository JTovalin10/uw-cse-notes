# CSE391: Common Command Reference

Quick reference for essential Linux commands covered in CSE391. Click each command for detailed usage, flags, and examples.

## Navigation & File Management

| Command | Purpose |
| :--- | :--- |
| **[[pwd\|pwd]]** | Prints the current working directory path. |
| **[[ls\|ls]]** | Lists directory contents (files and folders). |
| **[[cd\|cd]]** | Changes the current working directory. |
| **[[mkdir\|mkdir]]** | Creates one or more new directories. |
| **[[cp\|cp]]** | Copies files and directories. |
| **[[mv\|mv]]** | Moves or renames files and directories. |
| **[[rm\|rm]]** | Removes (deletes) files and directories. |

## Text & Data Processing

| Command | Purpose |
| :--- | :--- |
| **[[cat\|cat]]** | Concatenates and displays entire file content to stdout. |
| **[[echo\|echo]]** | Prints text or variables to the terminal. |
| **[[grep\|grep]]** | Searches for patterns using regular expressions. |
| **[[Sed Commands\|sed]]** | A stream editor used for transforming and filtering text. |
| **[[sort\|sort]]** | Reorders lines of text alphabetically or numerically. |
| **[[uniq\|uniq]]** | Filters out adjacent duplicate lines; often used with `sort`. |
| **[[Find and Cut#cut\|cut]]** | Extracts specific columns or fields from structured text. |
| **[[head\|head]]** | Displays the first few lines of a file (default 10). |
| **[[tail\|tail]]** | Displays the last few lines of a file (useful for logs with `-f`). |
| **[[wc\|wc]]** | Counts lines, words, and characters in a file or stream. |

## Advanced Search & Utility

| Command | Purpose |
| :--- | :--- |
| **[[Find and Cut#find\|find]]** | Searches for files and directories based on various criteria. |
| **[[Xargs\|xargs]]** | Builds and executes command lines from standard input. |

## Pipes & Redirection

| Operator | Purpose |
| :--- | :--- |
| **[[System and Software Tools/Streams Redirection and Pipes/Pipes\|\|]]** | Passes the output of one command as input to the next. |
| **[[Input Output Redirection#Output Redirection (>)\|>]]** | Redirects standard output to a file (overwrites). |
| **[[Input Output Redirection#Append Redirection (>>)\|>>]]** | Appends standard output to a file. |
| **[[Input Output Redirection#Input Redirection (<)\|<]]** | Redirects a file's contents into a command's standard input. |
| **[[Input Output Redirection#Error Redirection (2>)\|2>]]** | Redirects only the error output (**[[Standard Streams#3. stderr (Standard Error) - File Descriptor 2\|stderr]]**) to a file. |

## Control Flow

| Operator | Purpose |
| :--- | :--- |
| **[[Control Flow Operators#Background Operator (&)\|&]]** | Runs the command in the background. |
| **[[Control Flow Operators#Semicolon (;)\|;]]** | Runs multiple commands sequentially. |
| **[[Control Flow Operators#AND Operator (&&)\|&&]]** | Runs the next command only if the previous one succeeded (AND). |
| **[[CSE391/Intermediate Command Line/Control Flow Operators#OR Operator (II)\|\\|\\|]]** | Runs the next command only if the previous one failed (OR). |

## Quick Comparison: head vs. tail
- Use `head -n 5` to see the top of a file.
- Use `tail -n 5` to see the bottom of a file.
- Use `tail -f` to watch a file grow in real-time (e.g., logs).

## Quick Comparison: sort vs. uniq
- `sort` organizes data.
- `uniq` removes duplicates but *only if they are adjacent*.
- **Standard pattern:** `sort file.txt | uniq`

## Related
- [[Unix File System|Unix File System]]
- [[System and Software Tools/Streams Redirection and Pipes/Pipes|Pipes]]
- [[Find and Cut|Find and Cut]]
