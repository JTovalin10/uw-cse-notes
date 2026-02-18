# x86-64 Instruction Format

Instructions follow the pattern: **instruction name + operands**

**Related:** [[x86-64 Registers]], [[x86-64 Memory Operands]], [[x86-64 Operand Types]]

---

## Basic Syntax

```assembly
instr op                # 1 operand: negq %rsi
instr src, dst          # 2 operands: addq %rdi, %rax
```

---

## Instruction Categories

1. **Data transfer** - copying data between locations
2. **Arithmetic and logical** - mathematical and bitwise operations
3. **Control flow** - changing execution order (jumps, calls)

---

## Size Specifiers

Every instruction ends with a size specifier:

| Suffix | Name | Size |
|--------|------|------|
| `b` | byte | 1 byte |
| `w` | word | 2 bytes |
| `l` | long word | 4 bytes |
| `q` | quad word | 8 bytes |

### Examples
```assembly
addb %al, %bl      # 1-byte addition
addw %ax, %bx      # 2-byte addition
addl %eax, %ebx    # 4-byte addition
addq %rax, %rbx    # 8-byte addition
```

**Related:** [[x86-64 Registers]], [[Unsigned Integers]], [[Two's Complement]]
