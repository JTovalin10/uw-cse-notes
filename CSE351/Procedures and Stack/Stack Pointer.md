# Stack Pointer (`%rsp`)

The stack pointer holds the address of the current "top" of the stack.

**Related:** [[CSE351/Procedures and Stack/Memory Layout]], [[The Stack]], [[x86-64 Registers]]

---

## Key Concept

- Addresses **below** `%rsp` are **not part** of the stack
- Stack "top" moves as `%rsp` is manipulated
- Useful reference point for accessing stack data

---

## Accessing Stack Data

```assembly
movq 8(%rsp), %rax      # Access data 8 bytes from top
movq -16(%rsp), %rbx    # Access data 16 bytes "into" stack
```

---

## Stack Manipulation

### Direct Manipulation
```assembly
subq $16, %rsp          # Allocate 16 bytes (grows down)
addq $16, %rsp          # Deallocate 16 bytes
```

**Note:** This only changes `%rsp`, not actual memory data!

---

## Push Instruction

```assembly
pushq %rax              # Push %rax onto stack
```

**Steps:**
1. Decrement `%rsp` by 8 (allocate)
2. Copy `%rax` to memory at new `%rsp`

**Equivalent to:**
```assembly
subq $8, %rsp
movq %rax, (%rsp)
```

---

## Pop Instruction

```assembly
popq %rbx               # Pop into %rbx
```

**Steps:**
1. Copy data from `(%rsp)` to `%rbx`
2. Increment `%rsp` by 8 (deallocate)

**Equivalent to:**
```assembly
movq (%rsp), %rbx
addq $8, %rsp
```

---

## Example

If `%rsp = 0x7fffff000000`, after `popq %rbx`:
- `%rsp = 0x7fffff000008`
- Pop deallocates 8 bytes → increases `%rsp`

**Related:** [[Stack Frames]], [[Calling Conventions]]
