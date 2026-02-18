# x86-64 Operand Types

**Related:** [[x86-64 Instruction Format]], [[x86-64 Registers]], [[x86-64 Memory Operands]]

---

## 1. Immediates (Constants)

- **Prefix:** `$`
- Constant integer values

```assembly
movq $42, %rax        # Move constant 42 into %rax
addl $10, %ebx        # Add 10 to %ebx
```

---

## 2. Registers

- **Prefix:** `%`
- Names of the 16 general-purpose registers

```assembly
movq %rdi, %rax       # Copy %rdi to %rax
subq %rcx, %rdx       # Subtract %rcx from %rdx
```

---

## 3. Memory

- Uses **parentheses** `()`
- Specifies memory addresses to dereference

```assembly
movq (%rsp), %rax     # Load from address in %rsp
movl 4(%rbp), %ecx    # Load from %rbp + 4
```

---

## Operand Restrictions

**Cannot do:**
- Use immediate as destination: ~~`movq %rax, $5`~~
- Memory-to-memory operations: ~~`movq (%rax), (%rbx)`~~

**Valid combinations:**
```assembly
movq $5, %rax         # immediate -> register
movq %rax, (%rbx)     # register -> memory
movq (%rax), %rbx     # memory -> register
```

**Related:** [[CSE333/Memory Management/Pointers]], [[x86-64 Memory Operands]]
