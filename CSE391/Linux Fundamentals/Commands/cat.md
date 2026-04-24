# cat

**[[cat]]**: Short for "concatenate," used to read, output, and combine the content of one or more files to the terminal (standard output).

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-n`, `--number` | Number all output lines. |
| `-b`, `--number-nonblank` | Number nonempty output lines (overrides `-n`). |
| `-s`, `--squeeze-blank` | Squeeze multiple adjacent blank lines into one. |
| `-E`, `--show-ends` | Display a `$` character at the end of each line. |
| `-T`, `--show-tabs` | Display TAB characters as `^I`. |
| `-v`, `--show-nonprinting` | Use `^` and `M-` notation, except for LFD and TAB. |
| `-A`, `--show-all` | Equivalent to `-vET`. |

## Usage Examples

### 1. Display file content
The most common use case is simply reading a file.
```bash
cat filename.txt
```

### 2. Concatenate multiple files
You can list multiple files to see their contents sequentially.
```bash
cat file1.txt file2.txt
```

### 3. Display with line numbers
Useful for debugging code or identifying specific lines.
```bash
cat -n script.sh
```

### 4. Create or overwrite a file
Using redirection (`>`), you can create a file and type its content directly from the keyboard. Press `Ctrl+D` to save and exit.
```bash
cat > newfile.txt
```

### 5. Append to a file
Using append redirection (`>>`), you can add content to the end of an existing file.
```bash
cat >> existingfile.txt
```

### 6. Combine files into a new file
Merge multiple files into a single target file.
```bash
cat file1.txt file2.txt > combined.txt
```

### 7. Squeeze blank lines
If a file has many empty lines, use `-s` to make it more readable.
```bash
cat -s document.txt
```
