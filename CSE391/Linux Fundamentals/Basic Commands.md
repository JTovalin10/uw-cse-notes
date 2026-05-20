# CSE391: Common Command Reference

Quick reference for essential Linux commands covered in CSE391. Click each command for detailed usage, flags, and examples.

## Navigation & File Management

| Command | Purpose |
| :--- | :--- |
| **[[CSE391/Linux Fundamentals/Commands/pwd\|pwd]]** | Prints the current working directory path. |
| **[[CSE391/Linux Fundamentals/Commands/ls\|ls]]** | Lists directory contents (files and folders). |
| **[[CSE391/Linux Fundamentals/Commands/cd\|cd]]** | Changes the current working directory. |
| **[[CSE391/Linux Fundamentals/Commands/mkdir\|mkdir]]** | Creates one or more new directories. |
| **[[CSE391/Linux Fundamentals/Commands/cp\|cp]]** | Copies files and directories. |
| **[[CSE391/Linux Fundamentals/Commands/mv\|mv]]** | Moves or renames files and directories. |
| **[[CSE391/Linux Fundamentals/Commands/rm\|rm]]** | Removes (deletes) files and directories. |

## Text & Data Processing

| Command | Purpose |
| :--- | :--- |
| **[[CSE391/Linux Fundamentals/Commands/cat\|cat]]** | Concatenates and displays entire file content to stdout. |
| **[[CSE391/Linux Fundamentals/Commands/echo\|echo]]** | Prints text or variables to the terminal. |
| **[[CSE391/Linux Fundamentals/Commands/grep\|grep]]** | Searches for patterns using regular expressions. |
| **[[CSE391/Sed/Sed Commands\|sed]]** | A stream editor used for transforming and filtering text. |
| **[[CSE391/Linux Fundamentals/Commands/sort\|sort]]** | Reorders lines of text alphabetically or numerically. |
| **[[CSE391/Linux Fundamentals/Commands/uniq\|uniq]]** | Filters out adjacent duplicate lines; often used with `sort`. |
| **[[CSE391/Intermediate Command Line/Find and Cut#cut\|cut]]** | Extracts specific columns or fields from structured text. |
| **[[CSE391/Linux Fundamentals/Commands/head\|head]]** | Displays the first few lines of a file (default 10). |
| **[[CSE391/Linux Fundamentals/Commands/tail\|tail]]** | Displays the last few lines of a file (useful for logs with `-f`). |
| **[[CSE391/Linux Fundamentals/Commands/wc\|wc]]** | Counts lines, words, and characters in a file or stream. |

## Advanced Search & Utility

| Command | Purpose |
| :--- | :--- |
| **[[CSE391/Intermediate Command Line/Find and Cut#find\|find]]** | Searches for files and directories based on various criteria. |
| **[[CSE391/Intermediate Command Line/Xargs\|xargs]]** | Builds and executes command lines from standard input. |

## Pipes & Redirection

| Operator | Purpose |
| :--- | :--- |
| **[[CSE391/Streams Redirection and Pipes/Pipes\|\|]]** | Passes the output of one command as input to the next. |
| **[[CSE391/Streams Redirection and Pipes/Input Output Redirection#Output Redirection (>)\|>]]** | Redirects standard output to a file (overwrites). |
| **[[CSE391/Streams Redirection and Pipes/Input Output Redirection#Append Redirection (>>)\|>>]]** | Appends standard output to a file. |
| **[[CSE391/Streams Redirection and Pipes/Input Output Redirection#Input Redirection (<)\|<]]** | Redirects a file's contents into a command's standard input. |
| **[[CSE391/Streams Redirection and Pipes/Input Output Redirection#Error Redirection (2>)\|2>]]** | Redirects only the error output (**[[CSE391/Streams Redirection and Pipes/Standard Streams#3. stderr (Standard Error) - File Descriptor 2\|stderr]]**) to a file. |

## Control Flow

| Operator | Purpose |
| :--- | :--- |
| **[[CSE391/Intermediate Command Line/Control Flow Operators#Background Operator (&)\|&]]** | Runs the command in the background. |
| **[[CSE391/Intermediate Command Line/Control Flow Operators#Semicolon (;)\|;]]** | Runs multiple commands sequentially. |
| **[[CSE391/Intermediate Command Line/Control Flow Operators#AND Operator (&&)\|&&]]** | Runs the next command only if the previous one succeeded (AND). |
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
- [[CSE391/Linux Fundamentals/Unix File System|Unix File System]]
- [[CSE391/Streams Redirection and Pipes/Pipes|Pipes]]
- [[CSE391/Intermediate Command Line/Find and Cut|Find and Cut]]
