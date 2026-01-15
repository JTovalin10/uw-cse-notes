# x86-64 Memory Operands

**Related:** [[x86-64 Operand Types]], [[Pointer Arithmetic]], [[Arrays]]

---

## General Form: `D(Rb,Ri,S)`

| Component | Description |
|-----------|-------------|
| **D** | Displacement (immediate/constant) |
| **Rb** | Base register |
| **Ri** | Index register |
| **S** | Scale factor (1, 2, 4, or 8 only) |

**Address calculation:** `Reg[Rb] + Reg[Ri] * S + D`

---

## Example

```assembly
movb 8(%rax,%rbx,2), %cl    # Address = %rax + %rbx*2 + 8
```
Copies 1 byte from memory at that address into `%cl`.

---

## Default Values (Omitted Parts)

| Part | Default |
|------|---------|
| D | 0 |
| Reg[Rb] | 0 |
| Reg[Ri] | 0 |
| S | 1 |

---

## Common Examples

```assembly
(%rsi)              # Mem[%rsi]
4(%r10,%r11)        # Mem[%r10 + %r11 + 4]
(,%rdx,2)           # Mem[%rdx * 2]
12(%rbp)            # Mem[%rbp + 12]
```

---

## Common Patterns

### Array Access
```assembly
# arr[i] where arr in %rdi, i in %rsi (8-byte elements)
movq (%rdi,%rsi,8), %rax
```

### Stack Operations
```assembly
pushq %rax              # Push onto stack
popq %rbx               # Pop from stack
```

**Important:** Always use 64-bit register names in memory operands since addresses are 8 bytes.

**Related:** [[Pointer Arithmetic]], [[Stack Pointer]], [[Arrays]]
