# CSE391: Standard Streams

Unix processes have three **streams**: abstract locations that tell a program where to read input from and where to write output to.

There are three standard streams:
- **[[stdin]]** (standard input): The default source of data for a command.
- **[[stdout]]** (standard output): The default destination for a command's output.
- **[[stderr]]** (standard error): The destination for error messages.

## Stream Overview
| Integer | Stream | Java Equivalent | Description |
|---|---|---|---|
| 0 | stdin | `System.in` | Standard Input |
| 1 | stdout | `System.out` | Standard Output |
| 2 | stderr | `System.err` | Standard Error |

By default, these streams are connected to the console (terminal).

## Standard Input vs. Parameters
One of the most important distinctions is the difference between **standard input (stdin)** and a command's **parameters** (arguments):
- **Parameters** are arguments given directly on the command line.
    - Example: In `ls dir1`, `dir1` is a parameter.
    - Example: In `grep "a"`, `"a"` is a parameter.
- **Standard Input** comes from the user, a file, or another program.
    - Example: In `grep "a" < berries.txt`, the contents of `berries.txt` go into `stdin`.
    - Example: Typing `grep "a"` and then typing text into the keyboard until pressing `Ctrl + D` (which closes the stream).

## Related/See-also
- [[Streams Redirection and Pipes/Input Output Redirection|Input/Output Redirection]]
- [[Streams Redirection and Pipes/Pipes|Pipes]]
- [[Streams Redirection and Pipes/Common Shell Commands|Common Shell Commands]]
