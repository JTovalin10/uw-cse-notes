# CSE391: Bash Scripting Basics

A **[[Bash Script]]** is a plain text file containing a series of commands that are executed by the Bash shell. It allows for automation of repetitive tasks and complex command sequences.

## Key Concepts

### Whitespace Matters
Unlike Java, where whitespace is mostly for readability, **whitespace** in Bash is syntactically significant.
- **Assignment**: `VAR=value` (no spaces around `=`).
- **Tests**: `[ $a -eq $b ]` (spaces required inside the brackets).

## Comparison to Java
| Feature | Java | Bash |
|---------|------|------|
| Typing | Strong/Static | Weak/Dynamic (mostly strings) |
| Whitespace | Ignored (mostly) | **Syntactically Significant** |
| Loops | `for (int i=0; ...)` | `for i in $(seq ...)` or `for ((...))` |
| String Ops | `.equals()` | `=`, `!=` |

## Debugging Strategies
- **Echo Debugging**: Use `echo` to print variable values and track execution flow.
- **Output Redirection**: Dump variable contents or errors to a file for later inspection: `command > debug.txt 2>&1`.
- **Incremental Development**: Don't solve the whole problem at once; build and test small pieces.

## Related
- [[Variables and Arithmetic]]
- [[Control Flow]]
- [[Comparisons]]
- The Shell
