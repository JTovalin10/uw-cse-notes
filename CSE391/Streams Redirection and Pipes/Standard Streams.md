# Standard Streams (stdin, stdout, stderr)

Unix processes have three **streams**: abstract locations that specify where a program reads its input from and where it writes its output and error messages to.

## The Three Standard Streams

### 1. stdin (Standard Input) - File Descriptor 0
The default source of data for a command.
- **Default:** The keyboard.
- **Redirection (<):** Reads from a file instead of the keyboard. `grep "pattern" < file.txt`
- **Piping (|):** Reads from the output of a previous command. `cat file.txt | grep "pattern"`

### 2. stdout (Standard Output) - File Descriptor 1
The default destination for a command's normal output.
- **Default:** The terminal screen.
- **Redirection (>):** Writes output to a file (overwrites). `ls > files.txt`
- **Append Redirection (>>):** Adds output to the end of a file. `date >> log.txt`

### 3. stderr (Standard Error) - File Descriptor 2
The destination for all error messages and diagnostics. This is separate from `stdout` so that errors don't get mixed with valid data when piping or redirecting.
- **Default:** The terminal screen.
- **Redirection (2>):** Writes error messages to a file. `find / -name "test" 2> errors.log`
- **Silencing errors:** Send them to the "null" device. `command 2> /dev/null`

---

## Stream Overview Table
| Integer (FD) | Stream Name | Java Equivalent | Redirect | Append |
| :--- | :--- | :--- | :--- | :--- |
| **0** | **stdin** | `System.in` | `<` | N/A |
| **1** | **stdout** | `System.out` | `>` | `>>` |
| **2** | **stderr** | `System.err` | `2>` | `2>>` |

---

## Redirection Techniques

### Redirecting Both stdout and stderr
To send all output (both data and errors) to the same file:
```bash
# Old style:
command > output.txt 2>&1
# Modern Bash style:
command &> output.txt
```

### Standard Input vs. Parameters
It is crucial to distinguish between **stdin** and **parameters** (arguments):
- **Parameters** are arguments given directly on the command line.
    - `ls dir1` (`dir1` is a parameter).
- **Standard Input** is data the program "reads" during execution.
    - `grep "a" < berries.txt` (the content of `berries.txt` is fed into `grep` via `stdin`).

## Related/See-also
- [[Input Output Redirection\|Input/Output Redirection]]
- [[Pipes\|Pipes]]
- [[Common Shell Commands\|Common Shell Commands]]
