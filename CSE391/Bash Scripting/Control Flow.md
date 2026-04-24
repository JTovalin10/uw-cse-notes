# CSE391: Bash Control Flow

Control flow in Bash includes `if` statements, loops, and conditional execution.

## If Statements
The basic syntax for an `if` statement:

```bash
if [ expression ]; then
  # commands
elif [ expression ]; then
  # commands
else
  # commands
fi
```
*Note: The `if` is closed with `fi` (if backwards).*

## For Loops
Bash supports several types of loops. A common pattern is iterating over a sequence of numbers or a list of items.

### Using `seq`
To mimic a Java-style loop:
```bash
# for (int i = 0; i < 10; i += 2)
for i in $(seq 0 2 10); do
  echo $i
done
```

### Iterating over Files
```bash
for file in *.txt; do
  echo "Processing $file"
done
```

## Conditional Execution Operators
These are shorthand for simple `if` logic:
- `&&`: Execute the second command only if the first succeeds (exit code 0).
- `||`: Execute the second command only if the first fails (non-zero exit code).

## Related
- [[Comparisons]]
- [[Bash Scripting Basics]]
- [[Intermediate Command Line/Control Flow Operators|Shell Operators]]
