# seq

**[[seq]]**: Short for "sequence," it is a utility used to print a sequence of numbers. It is most commonly used in Bash scripts for loop iteration.

## Common Syntax
- `seq LAST`: Prints from 1 to `LAST` (e.g., `seq 5` -> 1, 2, 3, 4, 5).
- `seq FIRST LAST`: Prints from `FIRST` to `LAST` (e.g., `seq 2 5` -> 2, 3, 4, 5).
- `seq FIRST INCREMENT LAST`: Prints from `FIRST` to `LAST`, increasing by `INCREMENT` each time (e.g., `seq 1 2 5` -> 1, 3, 5).

## Common Flags
| Flag | Description |
| :--- | :--- |
| `-s`, `--separator=STRING` | Use `STRING` to separate numbers (default is `\n`). |
| `-w`, `--equal-width` | Pad numbers with leading zeros to maintain equal width. |
| `-f`, `--format=FORMAT` | Use a `printf` style floating-point `FORMAT`. |

## Usage Examples

### 1. Basic loop iteration
The most common use case in a for loop.
```bash
for i in $(seq 1 5); do
    echo "Iteration $i"
done
```

### 2. Custom separator
Print numbers on a single line separated by commas.
```bash
seq -s ", " 1 5
# Output: 1, 2, 3, 4, 5
```

### 3. Step increment
Generate even numbers between 1 and 10.
```bash
seq 2 2 10
# Output: 2, 4, 6, 8, 10
```

### 4. Counting backwards
Use a negative increment to count down.
```bash
seq 10 -1 1
# Output: 10, 9, 8, ... 1
```

### 5. Equal width padding
Useful for generating filenames that sort correctly.
```bash
seq -w 01 10
# Output: 01, 02, 03, ... 10
```

### 6. Custom formatting
Format numbers as currency or with extra text.
```bash
seq -f "Value: %02g" 1 3
# Output:
# Value: 01
# Value: 02
# Value: 03
```
