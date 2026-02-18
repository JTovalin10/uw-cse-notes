# Unsigned Integers

Unsigned integers represent **non-negative numbers** (0 and positive). The bit pattern matches standard binary numerals stored in a fixed width.

**Related:** [[Two's Complement]], [[Binary and Hexadecimal]], [[Overflow]]

---

## Data Types and Ranges

On a typical 64-bit machine:

| Type | Size | Range |
|------|------|-------|
| `unsigned char` | 1 byte (8 bits) | 0 to 255 |
| `unsigned short` | 2 bytes (16 bits) | 0 to 65,535 |
| `unsigned int` | 4 bytes (32 bits) | 0 to ~4.3 billion |
| `unsigned long` | 8 bytes (64 bits) | 0 to ~18 quintillion |

For $n$ bits: range is **$0$ to $2^n - 1$**

---

## Binary Arithmetic

Addition and subtraction work like decimal, but **carry/borrow** happens at value **2** instead of 10.

### Example: Binary Addition (8-bit)

Adding `170 + 73 = 243`:
- `170` = `10101010`
- `73` = `01001001`

```
  10101010
+ 01001001
----------
  11110011  (243)
```

**Related:** [[Overflow]], [[Bit Shifting]]
