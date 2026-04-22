# CSE351: Jump Instructions

**Jump** (`j*`) and **Set** (`set*`) instructions work in conjunction with **[[Condition Codes]]** to implement control flow in x86-64 assembly.

## Jump Instructions (`j*`)

Jump instructions change the flow of execution by setting the **Program Counter** to a new address if a specific condition is met.

| Instruction | Description | Condition Flag State |
|:---:|:---|:---|
| `jmp` | **Unconditional** | Always jumps |
| `je` | **Equal / Zero** | `ZF = 1` |
| `jne` | **Not Equal** | `ZF = 0` |
| `jg` | **Greater** (signed) | `SF = OF` and `ZF = 0` |
| `jge` | **Greater or Equal** | `SF = OF` |
| `jl` | **Less** (signed) | `SF != OF` |
| `jle` | **Less or Equal** | `SF != OF` or `ZF = 1` |
| `ja` | **Above** (unsigned) | `CF = 0` and `ZF = 0` |
| `jb` | **Below** (unsigned) | `CF = 1` |

## Set Instructions (`set*`)

Set instructions set a 1-byte register (like `%al`) to 0 or 1 based on the current state of the condition codes. They do not change the program counter.

```assembly
cmpq %rsi, %rdi         # Compare x and y (computes x - y)
setg %al                # %al = 1 if x > y, else 0
```

## Typical Usage Pattern

A common assembly pattern involves two steps:
1. **Set Condition Codes**: Use `cmp`, `test`, or an arithmetic instruction.
2. **Use Condition**: Execute a `jump` or `set` instruction based on those codes.

### Example: Conditional Jump
```assembly
cmpq %rsi, %rdi         # Compare x and y
jg greater_label        # Jump to 'greater_label' if x > y
```

### Example: Testing for Zero
```assembly
testq %rax, %rax        # Sets ZF = 1 if %rax == 0
je is_zero              # Jump if zero
```

## Signed vs Unsigned Jumps

| Signed Comparison | Unsigned Comparison | Meaning |
|:---:|:---:|:---|
| `jg` | `ja` | Greater / Above |
| `jl` | `jb` | Less / Below |
| `jge` | `jae` | Greater-equal / Above-equal |
| `jle` | `jbe` | Less-equal / Above-equal |

## Related
- [[CSE351/x86-64 Assembly/Condition Codes|Condition Codes]]
- [[CSE351/x86-64 Assembly/Conditionals|Conditionals]]
- [[CSE351/x86-64 Assembly/Loops|Loops]]
- [[CSE351/x86-64 Assembly/Labels|Labels]]
- [[CSE351/Number Representation/Two's Complement|Two's Complement]]
- [[CSE351/Number Representation/Unsigned Integers|Unsigned Integers]]
