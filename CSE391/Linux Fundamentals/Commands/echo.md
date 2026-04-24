# echo

**[[echo]]**: Displays a line of text or the value of a variable to the standard output. It is frequently used in shell scripts to output status messages or print variable contents.

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-n` | Do not output the trailing newline. |
| `-e` | Enable interpretation of backslash escapes (e.g., `\n`, `\t`). |
| `-E` | Explicitly disable interpretation of backslash escapes (default behavior). |

## Backslash Escapes (requires `-e`)
| Escape | Description |
| :--- | :--- |
| `\\` | Backslash |
| `\n` | New line |
| `\t` | Horizontal tab |
| `\b` | Backspace |
| `\r` | Carriage return |
| `\v` | Vertical tab |
| `\c` | Produce no further output (truncate the line) |

## Usage Examples

### 1. Simple text output
Prints the string followed by a newline.
```bash
echo "Hello, CSE 391!"
```

### 2. Print variable values
Access shell variables using the `$` prefix.
```bash
NAME="Justin"
echo "Hello, $NAME"
```

### 3. Output without a newline
Useful when you want to keep the cursor on the same line (e.g., for prompts).
```bash
echo -n "Checking system status..."
# Result: Checking system status... (no newline here)
```

### 4. Using escape sequences
Format output with tabs or newlines using the `-e` flag.
```bash
echo -e "Item\tPrice\nApple\t$1.00\nOrange\t$0.75"
```

### 5. Displaying literal special characters
Use single quotes to prevent the shell from interpreting variables or use backslashes to escape.
```bash
echo 'The variable is $PATH'  # Prints literal $PATH
echo "The value is \$10.00"   # Escapes the $ sign
```

### 6. Redirecting output to a file
Create or overwrite a file with specific text.
```bash
echo "Config complete" > log.txt
```

### 7. Appending output to a file
Add a line to an existing file.
```bash
echo "New entry" >> log.txt
```
