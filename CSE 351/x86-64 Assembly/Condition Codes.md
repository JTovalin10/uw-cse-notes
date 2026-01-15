# Condition Codes

**Condition codes** are status bits in the CPU that track information about the most recently executed instruction. They're part of the `EFLAGS` register.

**Related:** [[Jump Instructions]], [[Bitwise Operations]], [[Overflow]]

---

## The Four Main Flags

| Flag | Name | Indicates |
|------|------|-----------|
| `CF` | Carry Flag | Unsigned overflow occurred |
| `ZF` | Zero Flag | Result was zero |
| `SF` | Sign Flag | Result was negative |
| `OF` | Overflow Flag | Signed overflow occurred |

---

## How Condition Codes Are Set

### 1. Implicit Setting (Side Effects)

Arithmetic and logical operations **automatically update** condition codes.

```assembly
# If %al = 0x80
addb %al, %al           # %al = 0x00
```

**Result:** `%al = 0x00` with:
- `CF = 1` (unsigned overflow: 0x80 + 0x80 = 0x100)
- `ZF = 1` (result is zero)
- `SF = 0` (result MSB is 0)
- `OF = 1` (signed overflow: -128 + -128)

### 2. Explicit Setting (Dedicated Instructions)

#### Compare (`cmp`)
Performs subtraction but **doesn't store result**

```assembly
cmpq %rax, %rbx         # Computes %rbx - %rax, sets flags only
```

#### Test (`test`)
Performs bitwise AND but **doesn't store result**

```assembly
testq %rax, %rax        # Computes %rax & %rax, sets flags only
```

---

## Important Notes

- **Bitwise operations:** Always have `CF = 0` and `OF = 0`
- **`cmp` and `test`:** Never modify operands, only condition codes

**Related:** [[Jump Instructions]], [[Conditionals]], [[Loops]]
