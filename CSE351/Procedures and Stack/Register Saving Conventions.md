# Register Saving Conventions

Define how procedures handle register reuse to avoid destroying other procedures' data.

**Related:** [[Calling Conventions]], [[Stack Frames]], [[x86-64 Registers]]

---

## Two Types of Registers

### Callee-saved Registers

- **Responsibility:** Callee saves/restores if used
- **Timing:** Save early, restore before `ret`
- **Caller view:** Values unchanged across calls

**Registers:** `%rbx`, `%rbp`, `%r12`-`%r15`

### Caller-saved Registers

- **Responsibility:** Caller saves/restores if needed later
- **Timing:** Save before `call`, restore after
- **Callee view:** Free to modify

**Registers:** `%rax`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%r8`-`%r11`

---

## Examples

### Callee-saved (`%rbx`)

```assembly
function:
    pushq %rbx          # Save old value
    movq %rdi, %rbx     # Use %rbx
    # ... function body ...
    popq %rbx           # Restore old value
    ret
```

### Caller-saved (`%rax`)

```assembly
# Caller code
movq %rax, %r10         # Save if needed later
call some_function      # May overwrite %rax
movq %r10, %rax         # Restore
```

---

## Stack Ordering (LIFO)

When saving multiple registers:

```assembly
# Save
pushq %rcx
pushq %rdx

# Restore (REVERSE order)
popq %rdx
popq %rcx
```

---

## Stack Frame Integration

```
┌─────────────────┐
│ Return address  │
├─────────────────┤
│ Callee-saved    │ ← Saved early
├─────────────────┤
│ Local variables │
├─────────────────┤
│ Caller-saved    │ ← Saved before calls
├─────────────────┤
│ Arguments 7+    │
└─────────────────┘
```

---

## Optimization

- Use **caller-saved** for temporaries not needed across calls
- Use **callee-saved** for values needed throughout function
- Compilers optimize allocation automatically

**Related:** [[Recursion]], [[Stack Frames]]
