# Control Flow in Bash

Bash scripts use several structures to control the flow of execution, including conditionals (`if`), loops (`for`, `while`), and selection (`case`).

## Conditionals: If Statements
The syntax for `if` statements requires specific keyword and spacing rules.
```bash
if [ condition ]; then
  # Commands to run if condition is true
elif [ other_condition ]; then
  # Optional else-if block
else
  # Commands to run if all conditions fail
fi
```
*Note: Always remember to close the block with `fi` (if spelled backwards).*

---

## Loops

### 1. For Loops (Java-style)
To iterate over a range of numbers, use the `seq` command.
```bash
# Iterates 1, 2, 3, 4, 5
for i in $(seq 1 5); do
  echo "Iteration $i"
done
```

### 2. For Loops (C-style)
Useful for more complex index manipulation.
```bash
for (( i=0; i<10; i+=2 )); do
  echo "Even: $i"
done
```

### 3. Iterating over Files (Wildcards)
The most common and useful loop in shell scripting.
```bash
for file in *.txt; do
  echo "Processing $file..."
  cp "$file" "backup_$file"
done
```

### 4. While Loops
Executes as long as the condition remains true.
```bash
COUNT=0
while [ $COUNT -lt 5 ]; do
  echo "Count is $COUNT"
  let COUNT++
done
```

---

## Selection: Case Statements
A more readable alternative to multiple `if-elif` blocks when comparing a single variable against several patterns.
```bash
case "$1" in
  start)
    echo "Starting server..."
    ;;
  stop)
    echo "Stopping server..."
    ;;
  status)
    echo "Checking status..."
    ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    exit 1
    ;;
esac
```

---

## Command Result Control Flow
Shorthand for simple conditional logic using exit codes.
- **AND (`&&`):** Execute the second command **only if** the first succeeds.
  ```bash
  gcc main.c -o main && ./main
  ```
- **OR (`||`):** Execute the second command **only if** the first fails.
  ```bash
  grep "Dubs" file.txt || echo "Pattern not found"
  ```

## Related/See-also
- [[Comparisons\|Comparison Operators (gt, lt, eq)]]
- [[Variables and Arithmetic\|Bash Variables and Math]]
- [[Bash Scripting Basics\|Bash Scripting Fundamentals]]
