# Variables and Arithmetic in Bash

Bash variables are dynamic and weakly typed. While they are easy to use, they require specific syntax for assignment, expansion, and arithmetic operations.

## Variables

### 1. Assignment
To set a variable, use the `=` operator.
- **CRITICAL:** Do NOT put spaces around the `=`.
- **CORRECT:** `NAME="Justin"`
- **INCORRECT:** `NAME = "Justin"` (Bash thinks `NAME` is a command and `=` is an argument).

### 2. Access and Expansion
Use the `$` prefix to retrieve a variable's value.
- **Basic:** `echo $NAME`
- **Braces:** Use `${}` to prevent ambiguity, especially when appending text to a variable name.
  ```bash
  PREFIX="data"
  echo "${PREFIX}_backup.txt"  # Output: data_backup.txt
  ```

### 3. Command Substitution
Capture the output of a command into a variable using `$(...)`.
```bash
FILES=$(ls)
CURRENT_DATE=$(date +%Y-%m-%d)
```

---

## Quoting Rules
Quoting is essential in Bash to prevent the shell from splitting strings on spaces or expanding special characters.

| Quote Type | Description | Example | Result |
| :--- | :--- | :--- | :--- |
| **Double (`""`)** | **Weak Quoting:** Performs variable expansion and handles escapes. | `"Hello $USER"` | "Hello justin" |
| **Single (`''`)** | **Strong Quoting:** Literal interpretation of every character. | `'Hello $USER'` | "Hello $USER" |
| **Backslash (`\`)** | **Escaping:** Treats the next character literally. | `\$10.00` | "$10.00" |

---

## Arithmetic Operations
By default, Bash treats all variables as strings. To perform math, you must use specific syntax.

### 1. Arithmetic Expansion `$(( ... ))`
This is the most common and recommended way to do integer math.
- **Syntax:** `result=$(( expression ))`
- **Supported:** `+`, `-`, `*`, `/` (integer division), `%` (modulo), `**` (exponentiation).
```bash
A=10
B=3
echo $(( A + B ))  # 13
echo $(( A / B ))  # 3 (Integer division)
echo $(( A % B ))  # 1 (Remainder)
```

### 2. The `let` Command
An alternative way to perform assignment and arithmetic at once.
```bash
let "X = 5 * 10"
echo $X  # 50
```

### 3. Floating Point (Advanced)
Bash **does not support decimals** natively. Use the `bc` (Basic Calculator) utility for floating-point math.
```bash
echo "scale=2; 10 / 3" | bc
# Output: 3.33
```

---

## Predefined Shell Variables
| Variable | Description |
| :--- | :--- |
| `$0` | Name of the script being run. |
| `$1, $2, ...` | Positional parameters (command line arguments). |
| `$#` | Number of command line arguments provided. |
| `$@` | List of all command line arguments. |
| `$?` | Exit status of the last executed command (0 = success). |
| `$$` | Process ID (PID) of the current shell. |

## Related/See-also
- [[Bash Scripting Basics\|Bash Scripting Basics]]
- [[Comparisons\|Comparison Operators]]
- [[Control Flow\|Loops and If Statements]]
