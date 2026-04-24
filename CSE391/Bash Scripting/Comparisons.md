# CSE391: Bash Comparisons

Bash uses different operators depending on whether you are comparing numbers, strings, or checking file properties.

## Arithmetic Comparisons (Integers)
These operators are used within `[ ]` or `[[ ]]` for numeric values.

| Operator | Description |
|----------|-------------|
| `-gt` | Greater than |
| `-ge` | Greater than or equal to |
| `-lt` | Less than |
| `-le` | Less than or equal to |
| `-eq` | Equal to |
| `-ne` | Not equal to |

**Example**:
```bash
if [ $a -lt $b ]; then
  echo "$a is less than $b"
fi
```

## String Comparisons
| Operator | Description |
|----------|-------------|
| `=` | Strings are equal |
| `!=` | Strings are not equal |
| `-z` | String is empty (zero length) |
| `-n` | String is non-empty |

**Example**:
```bash
if [ -n "$NAME" ]; then
  echo "Variable \$NAME exists and is not empty"
fi
```

## File Comparisons
These tests allow you to check the state of the filesystem.

| Operator | Description |
|----------|-------------|
| `-f` | Test if a file exists and is a regular file |
| `-d` | Test if a directory exists |
| `-r` | File exists and is readable |
| `-w` | File exists and is writable |
| `-x` | File exists and is executable |

## Boolean Comparisons
Used to combine multiple expressions.

| Operator | Description |
|----------|-------------|
| `-a` or `&&` | **And** |
| `-o` or `||` | **Or** |
| `!` | **Negation** (Not) |

**Example**:
```bash
if [ $a -lt 10 ] && [ $a -gt 5 ]; then
  echo "variable a is between 5 and 10"
fi
```

## Related
- [[Control Flow]]
- [[Bash Scripting Basics]]
