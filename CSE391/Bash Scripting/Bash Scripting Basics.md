# Bash Scripting Basics

**[[Bash Scripting]]** is the process of writing a sequence of commands in a text file (a "script") to be executed by the Bash **[[Shell]]**, allowing for automation of complex tasks.

## The Shebang (`#!`)
Every Bash script should begin with a **shebang** line as the very first line. This tells the operating system which interpreter to use to run the script.
```bash
#!/bin/bash
```
*Note: Using `#!/bin/bash` is standard for Linux systems. Some cross-platform scripts use `#!/usr/bin/env bash` for better compatibility.*

## Script Execution
Before a script can be run, it must have **execute permissions**.
1. **Set permissions:** `chmod +x myscript.sh`
2. **Run the script:** `./myscript.sh` (The `./` is necessary to specify the current directory).

## Variables and Typing
Bash is **[[Tentatively Typed]]**, meaning variables do not have strict data types like `int` or `boolean`.
- **Everything is a String:** By default, Bash treats all variables as strings.
- **Context Matters:** A variable is treated as a number only when used in an arithmetic context (e.g., inside `$(( ... ))`).
- **No Spaces in Assignment:** `NAME=Justin` is correct. `NAME = Justin` will fail because Bash thinks `NAME` is a command and `=` is its first argument.

## Variable Expansion
**[[Variable Expansion]]** is the process where the shell replaces a variable name with its stored value.
- **Accessing Values:** Use the `$` prefix. `echo $NAME`
- **Brace Expansion:** Use `{}` to avoid ambiguity. `echo "${NAME}_file.txt"`
- **Command Substitution:** Capture the output of a command into a variable using `$(...)`.
  ```bash
  FILES=$(ls)
  DATE=$(date)
  ```

## Whitespace Significance
Unlike Java, **whitespace** in Bash is syntactically significant.
- **Assignment:** `VAR=value` (NO spaces around `=`).
- **Arguments:** `ls -l /home` (spaces separate commands from arguments).
- **Conditionals:** `[ $A == $B ]` (spaces ARE required inside the brackets).

## Comparison to Java
| Feature | Java | Bash |
| :--- | :--- | :--- |
| **Typing** | Strong/Static | Weak/Dynamic (mostly strings) |
| **Whitespace** | Ignored (mostly) | **Syntactically Significant** |
| **Compilation** | Required (`javac`) | Interpreted (runs directly) |
| **Variable Access** | `name` | `$name` |
| **Loops** | `for (int i=0; ...)` | `for i in $(seq ...)` or `for ((...))` |

## Debugging Strategies
- **Echo Debugging:** Use `echo` to print variable values and track execution flow.
- **Shell Flags:** Run your script with `-x` to see every command as it executes: `bash -x myscript.sh`.
- **Incremental Development:** Build and test small pieces of logic before combining them into a large script.

## Related/See-also
- [[Variables and Arithmetic]]
- [[Control Flow]]
- [[Comparisons]]
- [[Linux Fundamentals/Shell\|The Shell]]
- [[seq\|The seq Command]]
