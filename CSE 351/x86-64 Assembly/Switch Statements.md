# Switch Statements

Switch statements use **jump tables** and **indirect jumps** for efficient multi-way branching.

**Related:** [[Jump Instructions]], [[Conditionals]], [[Program Counter]]

---

## Jump Tables

A **jump table** is an array of code block addresses.

### Structure
- Array indices = case values
- Array entries = addresses of code blocks
- More efficient than sequential if-else

---

## Program Counter (`%rip`)

Special register holding the **address of the next instruction** to execute.

- **Normal execution:** Advances sequentially
- **Jump instructions:** Alter `%rip` to jump

---

## Indirect Jumps

### Syntax
```assembly
jmp *Loc
```

- **Asterisk (`*`)** indicates indirect jump
- Address is **found in** `Loc`, not directly given

### Example with Jump Table
```assembly
jmp *.L4(,%rdi,8)
```
- `.L4` = jump table start
- `%rdi` = switch value
- `8` = pointer size

---

## Complete Example

### C Code
```c
switch (x) {
    case 0: return a;
    case 1: return b;
    case 2:
    case 3: return c;
    default: return d;
}
```

### Jump Table
```assembly
.L4:
    .quad .L_case0    # case 0
    .quad .L_case1    # case 1
    .quad .L_case23   # case 2
    .quad .L_case23   # case 3 (same address)
```

### Assembly
```assembly
cmpq $3, %rdi         # Check bounds
ja .L_default         # Jump to default if out of range
jmp *.L4(,%rdi,8)     # Indirect jump using table

.L_case0:
    movq %rax, %rax
    ret
.L_case1:
    movq %rbx, %rax
    ret
.L_case23:
    movq %rcx, %rax
    ret
.L_default:
    movq %rdx, %rax
    ret
```

---

## Handling Special Cases

| Case | Implementation |
|------|----------------|
| Multiple labels | Same address in multiple entries |
| Fall-through | Consecutive code blocks |
| Default | Non-specified indices point to default |

**Related:** [[Arrays]], [[Memory Layout]]
