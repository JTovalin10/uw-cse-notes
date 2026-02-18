# Jump Instructions

Jump (`j*`) and Set (`set*`) instructions work with [[Condition Codes]] to implement control flow.

**Related:** [[Condition Codes]], [[CSE351/x86-64 Assembly/Conditionals]], [[CSE351/x86-64 Assembly/Loops]], [[Labels]]

---

## Jump Instructions (`j*`)

Change which instruction executes next.

| Instruction | Description | Condition |
|-------------|-------------|-----------|
| `jmp` | Unconditional | Always |
| `je` | Equal / Zero | ZF = 1 |
| `jne` | Not equal | ZF = 0 |
| `jg` | Greater (signed) | SF = OF and ZF = 0 |
| `jge` | Greater or equal | SF = OF |
| `jl` | Less (signed) | SF != OF |
| `jle` | Less or equal | SF != OF or ZF = 1 |
| `ja` | Above (unsigned) | CF = 0 and ZF = 0 |
| `jb` | Below (unsigned) | CF = 1 |

---

## Set Instructions (`set*`)

Set a 1-byte register to 0 or 1 based on condition.

```assembly
cmpq %rsi, %rdi         # Compare x - y
setg %al                # %al = 1 if x > y, else 0
```

---

## Typical Pattern

1. **Set condition codes** (`cmp`, `test`, or arithmetic)
2. **Use condition** (`jump` or `set`)

### Jump Example
```assembly
cmpq %rsi, %rdi         # Compare x - y
jg greater_label        # Jump if x > y
```

### Set Example
```assembly
cmpq %rsi, %rdi         # Compare x - y
setg %al                # %al = 1 if x > y
```

---

## Testing for Zero

```assembly
testq %rax, %rax        # Sets ZF = 1 if %rax == 0
je is_zero              # Jump if zero
```

---

## Signed vs Unsigned

| Signed | Unsigned | Meaning |
|--------|----------|---------|
| `jg` | `ja` | Greater/Above |
| `jl` | `jb` | Less/Below |
| `jge` | `jae` | Greater-equal/Above-equal |
| `jle` | `jbe` | Less-equal/Below-equal |

**Related:** [[CSE351/x86-64 Assembly/Conditionals]], [[CSE351/x86-64 Assembly/Loops]], [[Two's Complement]], [[Unsigned Integers]]
