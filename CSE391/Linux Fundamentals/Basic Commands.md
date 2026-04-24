# CSE391: Common Command Reference

Quick reference for essential Linux commands covered in CSE391. Click each command for detailed usage, flags, and examples.

## Navigation & File Management
| Command | Purpose |
| :--- | :--- |
| **[[Linux Fundamentals/Commands/pwd\|pwd]]** | Prints the current working directory path. |
| **[[Linux Fundamentals/Commands/ls\|ls]]** | Lists directory contents (files and folders). |
| **[[Linux Fundamentals/Commands/cd\|cd]]** | Changes the current working directory. |
| **[[Linux Fundamentals/Commands/mkdir\|mkdir]]** | Creates one or more new directories. |
| **[[Linux Fundamentals/Commands/cp\|cp]]** | Copies files and directories. |
| **[[Linux Fundamentals/Commands/mv\|mv]]** | Moves or renames files and directories. |
| **[[Linux Fundamentals/Commands/rm\|rm]]** | Removes (deletes) files and directories. |

## Text & Data Processing
| Command | Purpose |
| :--- | :--- |
| **[[Linux Fundamentals/Commands/cat\|cat]]** | Concatenates and displays entire file content to stdout. |
| **[[Linux Fundamentals/Commands/echo\|echo]]** | Prints text or variables to the terminal. |
| **[[Linux Fundamentals/Commands/grep\|grep]]** | Searches for patterns using regular expressions. |
| **[[Sed/Sed Commands\|sed]]** | A stream editor used for transforming and filtering text. |
| **[[Linux Fundamentals/Commands/sort\|sort]]** | Reorders lines of text alphabetically or numerically. |
| **[[Linux Fundamentals/Commands/uniq\|uniq]]** | Filters out adjacent duplicate lines; often used with `sort`. |
| **[[Intermediate Command Line/Find and Cut#cut\|cut]]** | Extracts specific columns or fields from structured text. |
| **[[Linux Fundamentals/Commands/head\|head]]** | Displays the first few lines of a file (default 10). |
| **[[Linux Fundamentals/Commands/tail\|tail]]** | Displays the last few lines of a file (useful for logs with `-f`). |
| **[[Linux Fundamentals/Commands/wc\|wc]]** | Counts lines, words, and characters in a file or stream. |

## Advanced Search & Utility
| Command | Purpose |
| :--- | :--- |
| **[[Intermediate Command Line/Find and Cut#find\|find]]** | Searches for files and directories based on various criteria. |
| **[[Intermediate Command Line/Xargs\|xargs]]** | Builds and executes command lines from standard input. |

## Pipes & Redirection
| Operator | Purpose |
| :--- | :--- |
| **[[Streams Redirection and Pipes/Pipes\|\|]]** | Passes the output of one command as input to the next. |
| **[[Streams Redirection and Pipes/Input Output Redirection#Output Redirection (>)\|>]]** | Redirects standard output to a file (overwrites). |
| **[[Streams Redirection and Pipes/Input Output Redirection#Append Redirection (>>)\|>>]]** | Appends standard output to a file. |
| **[[Streams Redirection and Pipes/Input Output Redirection#Input Redirection (<)\|<]]** | Redirects a file's contents into a command's standard input. |
| **[[Streams Redirection and Pipes/Input Output Redirection#Error Redirection (2>)\|2>]]** | Redirects only the error output (**[[Streams Redirection and Pipes/Standard Streams#3. stderr (Standard Error) - File Descriptor 2\|stderr]]**) to a file. |

## Control Flow
| Operator                                                                            | Purpose                                                         |
| :---------------------------------------------------------------------------------- | :-------------------------------------------------------------- |
| **[[Intermediate Command Line/Control Flow Operators#Background Operator (&)\|&]]** | Runs the command in the background.                             |
| **[[Intermediate Command Line/Control Flow Operators#Semicolon (;)\|;]]**           | Runs multiple commands sequentially.                            |
| **[[Intermediate Command Line/Control Flow Operators#AND Operator (&&)\|&&]]**      | Runs the next command only if the previous one succeeded (AND). |
| **[[Intermediate Command Line/Control Flow Operators#OR Operator (II)]]**           | Runs the next command only if the previous one failed (OR).     |

## Quick Comparison: head vs. tail
- Use `head -n 5` to see the top of a file.
- Use `tail -n 5` to see the bottom of a file.
- Use `tail -f` to watch a file grow in real-time (e.g., logs).

## Quick Comparison: sort vs. uniq
- `sort` organizes data.
- `uniq` removes duplicates but *only if they are adjacent*.
- **Standard pattern:** `sort file.txt | uniq`
