# Comparison Operators in Bash

Bash uses different operators depending on whether you are comparing **integers**, **strings**, or checking **file properties**. Using the wrong type of operator (e.g., using `>` for numbers) is a very common source of bugs.

## 1. Integer Comparisons (Numeric)
These are used within `[ ]` or `[[ ]]`. Remember to use the letter-based codes for numbers.

| Operator | Description | Java Equivalent |
| :--- | :--- | :--- |
| `-eq` | Equal to | `==` |
| `-ne` | Not equal to | `!=` |
| `-gt` | Greater than | `>` |
| `-ge` | Greater than or equal to | `>=` |
| `-lt` | Less than | `<` |
| `-le` | Less than or equal to | `<=` |

**Example:**
```bash
if [ "$COUNT" -gt 10 ]; then
    echo "Count is greater than 10"
fi
```

---

## 2. String Comparisons
Use these for text. Always wrap your variables in **double quotes** to prevent errors if the variable is empty or contains spaces.

| Operator | Description | Example |
| :--- | :--- | :--- |
| `=` or `==` | Strings are identical | `[ "$A" == "$B" ]` |
| `!=` | Strings are different | `[ "$A" != "$B" ]` |
| `-z` | String is **NULL** (empty) | `[ -z "$VAR" ]` |
| `-n` | String is **NOT NULL** | `[ -n "$VAR" ]` |

**Example:**
```bash
if [ "$USER_INPUT" == "yes" ]; then
    echo "Proceeding..."
fi
```

---

## 3. File Property Tests
These allow you to check the state of the filesystem.

| Operator | Description | Example |
| :--- | :--- | :--- |
| `-e` | File or directory exists | `[ -e "path/to/thing" ]` |
| `-f` | It is a regular **file** | `[ -f "notes.txt" ]` |
| `-d` | It is a **directory** | `[ -d "my_folder" ]` |
| `-r` | File is **readable** | `[ -r "config.json" ]` |
| `-w` | File is **writable** | `[ -w "log.txt" ]` |
| `-x` | File is **executable** | `[ -x "script.sh" ]` |
| `-s` | File is **not empty** | `[ -s "data.csv" ]` |

**Example:**
```bash
if [ -f "build.log" ]; then
    rm "build.log"
fi
```

---

## 4. Logical Operators (Combining Tests)
Use these to check multiple conditions at once.

| Operator | Description | Syntax |
| :--- | :--- | :--- |
| `&&` or `-a` | **AND** (Both must be true) | `[ cond1 ] && [ cond2 ]` |
| `\|\|` or `-o` | **OR** (Either can be true) | `[ cond1 ] \|\| [ cond2 ]` |
| `!` | **NOT** (Invert result) | `[ ! cond ]` |

**Example:**
```bash
if [ "$TEMP" -ge 0 ] && [ "$TEMP" -le 100 ]; then
    echo "Temperature is in range."
fi
```

## Common Pitfall: Whitespace
In Bash, `[` is actually a command, and `]` is its last argument. Therefore, **spaces are mandatory** inside the brackets.
- **WRONG:** `if [$A -eq $B]; then`
- **CORRECT:** `if [ $A -eq $B ]; then`

## Related/See-also
- [[Control Flow\|Loops and If Statements]]
- [[Variables and Arithmetic\|Bash Variables and Math]]
- [[Bash Scripting Basics\|Bash Scripting Fundamentals]]
