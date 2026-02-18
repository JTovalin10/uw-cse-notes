# Bit Shifting

Shift operators (`<<`, `>>`) move bits left or right by specified positions. Bits that "fall off" are discarded.

**Related:** [[Bitwise Operations]], [[Two's Complement]], [[Unsigned Integers]]

---

## Types of Shifts

### Left Shift (`<<`)
Shifts bits left, fills vacated positions on right with **zeros**.

```
00011001 << 2
Result: 01100100
```

### Logical Right Shift (`>>` on unsigned)
Shifts bits right, fills vacated positions on left with **zeros**.

```
10010001 >> 2  (unsigned)
Result: 00100100
```

### Arithmetic Right Shift (`>>` on signed)
Shifts bits right, fills vacated positions with copies of the **sign bit (MSB)**. Preserves the number's sign.

```
10010001 >> 2  (signed, -111)
Result: 11100100  (MSB was 1, fills with 1s)
```

---

## Shifting as Arithmetic

Shifts are fast multiplication/division by powers of 2.

| Operation | Equivalent | Example |
|-----------|------------|---------|
| `x << n` | $x \times 2^n$ | `5 << 2` = 20 (5 * 4) |
| `x >> n` | $x \div 2^n$ | `20 >> 2` = 5 (20 / 4) |

### Example
```c
char x = 5;      // 0b00000101
char y = x << 2; // 0b00010100 = 20
```

---

## Undefined Behavior Warning

Shifting by a **negative amount** or by an amount **>= bit width** is undefined behavior in C.

**Related:** [[Overflow]], [[x86-64 Registers]]
