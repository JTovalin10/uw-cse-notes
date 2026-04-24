# CSE351: Conditionals (If-Else)

Conditionals use [[CSE351/x86-64 Assembly/Labels|labels]] and [[CSE351/x86-64 Assembly/Jump Instructions|jump instructions]] to ensure only one branch executes.

---

## Basic Strategy

1. Set condition codes with `cmp` or `test`
2. Use a conditional jump to skip one branch
3. Use an unconditional `jmp` to skip the other branch

---

## Key Principle

All conditional jumps test the result **compared to zero**.

- `x >= y` becomes `x - y >= 0`
- `x == 3` becomes `x - 3 == 0`

---

## Example: If-Else

### C Code
```c
if (x < 3)          // x in %rax
    y += 2;         // y in %rbx
else
    y = 10;
```

### Assembly (Version 1)
```assembly
cmpq $2, %rax       # Compare x with 2
jg .L2              # Jump if x > 2 (i.e., x >= 3)
addq $2, %rbx       # if case: y += 2
jmp .L3             # Skip else case
.L2:
movq $10, %rbx      # else case: y = 10
.L3:
```

### Assembly (Version 2)
```assembly
cmpq $3, %rax       # Compare x with 3
jl .L2              # Jump if x < 3
movq $10, %rbx      # else case: y = 10
jmp .L3             # Skip if case
.L2:
addq $2, %rbx       # if case: y += 2
.L3:
```

---

## Pattern: Jump on Opposite Condition

To execute code when a condition is true, **jump on the opposite condition** to skip to else.

| C Condition | Jump to Skip |
|:---|:---|
| `x < 3` | `jge` (jump if >= 3) |
| `x > 1` | `jle` (jump if <= 1) |
| `x == 0` | `jne` (jump if != 0) |

---

## Related
- [[CSE351/x86-64 Assembly/Condition Codes|Condition Codes]]
- [[CSE351/x86-64 Assembly/Jump Instructions|Jump Instructions]]
- [[CSE351/x86-64 Assembly/Labels|Labels]]
- [[CSE351/x86-64 Assembly/Loops|Loops]]
- [[CSE351/x86-64 Assembly/Switch Statements|Switch Statements]]
