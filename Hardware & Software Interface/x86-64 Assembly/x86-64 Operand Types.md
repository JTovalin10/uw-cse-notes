# CSE351: x86-64 Operand Types

x86-64 instructions can draw their operands from three sources: constants embedded in the instruction (**immediates**), CPU **registers**, or **memory**. Understanding which combinations are legal is essential for reading and writing assembly correctly.

---

## 1. Immediates (Constants)

- **Prefix:** `$`
- Constant integer values encoded directly in the instruction stream.
- Limited to a maximum of 32-bit values in most contexts (sign-extended to 64 bits).

```assembly
movq $42, %rax        # Move constant 42 into %rax
addl $10, %ebx        # Add 10 to %ebx
```

---

## 2. Registers

- **Prefix:** `%`
- Names of the 16 general-purpose registers. See [[x86-64 Registers|x86-64 Registers]] for the full table.

```assembly
movq %rdi, %rax       # Copy %rdi to %rax
subq %rcx, %rdx       # Subtract %rcx from %rdx
```

---

## 3. Memory

- Uses **parentheses** `()`  to indicate that the operand is the value at a memory address.
- Full addressing mode: `D(Rb, Ri, S)` — see [[x86-64 Memory Operands|Memory Operands]] for details.

```assembly
movq (%rsp), %rax     # Load 8 bytes from address in %rsp
movl 4(%rbp), %ecx    # Load 4 bytes from %rbp + 4
```

---

## Operand Restrictions

The hardware enforces these constraints:

**Cannot do:**
- Use an immediate as a destination: ~~`movq %rax, $5`~~
- Perform memory-to-memory operations in one instruction: ~~`movq (%rax), (%rbx)`~~

**Valid combinations:**

```assembly
movq $5, %rax         # immediate → register
movq %rax, (%rbx)     # register → memory
movq (%rax), %rbx     # memory → register
```

The memory-to-memory restriction means that copying between two memory locations always requires a register as an intermediate.

---

```mermaid
flowchart LR
    I["Immediate ($)"] -->|"Valid src"| R["Register (%)"]
    R -->|"Valid src or dst"| M["Memory ()"]
    M -->|"Valid src"| R
    I -.->|"NOT valid dst"| X["(blocked)"]
    M -.->|"NOT directly to memory"| X
```

---

## Related

- [[x86-64 Instruction Format|Instruction Format]]
- [[x86-64 Registers|x86-64 Registers]]
- [[x86-64 Memory Operands|Memory Operands]]
- [[Systems Programming/C Fundamentals/Pointers|Pointers (CSE333)]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|:---|:---|
| Immediate (`$`) | Literal operand; embedded constant; immediate value |
| Register operand (`%`) | Register operand; architectural register |
| Memory operand `()` | Memory reference; indirect addressing |
| `D(Rb,Ri,S)` general form | Base + scaled index + displacement addressing mode |
