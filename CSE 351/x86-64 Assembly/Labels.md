# Labels

A **label** is a symbolic name for an instruction's memory address.

**Related:** [[Jump Instructions]], [[Conditionals]], [[Loops]]

---

## Syntax

- **Declaration:** `identifier:` (with colon)
- **Usage:** `identifier` (without colon)

---

## Examples

```assembly
main:               # Label declaration
    movq %rdi, %rax
    jmp done        # Label usage

done:               # Another label
    ret
```

---

## Auto-generated Labels

Compilers typically use format: `.L#:` (GCC convention)

```assembly
.L1:                # Auto-generated label
    addq $1, %rax
.L2:                # Another auto-generated label
    ret
```

---

## Label Association

Labels are associated with the **next instruction** after them (ignoring whitespace).

**Related:** [[Program Counter]], [[Conditionals]]
