# Two's Complement

Two's Complement is the standard representation for **signed integers** in all modern computers, allowing both positive and negative numbers.

**Related:** [[Unsigned Integers]], [[Binary and Hexadecimal]], [[Overflow]]

---

## Representation

The **most significant bit (MSB)** has a negative weight. For $n$ bits, the MSB weight is $-2^{n-1}$ instead of $2^{n-1}$.

### 8-bit Example
Value of `0b10001110`:
- MSB is `1`: value $-2^7 = -128$
- Other set bits: $2^3 + 2^2 + 2^1 = 8 + 4 + 2 = 14$
- **Total:** $-128 + 14 = -114$

---

## Range

For $n$ bits: **$-2^{n-1}$ to $2^{n-1} - 1$**

| Bits | Range |
|------|-------|
| 8 | -128 to 127 |
| 16 | -32,768 to 32,767 |
| 32 | ~-2.1 billion to ~2.1 billion |

---

## Advantages

- **Unique Zero:** All zeros = 0
- **Balanced Range:** Roughly equal positive and negative values
- **Consistent Positives:** Positive numbers match unsigned representation
- **Simple Negation:** Flip bits and add one

---

## Negation: Flip and Add One

**Formula:** `-x == ~x + 1`

### Example: -114 to 114
1. Start: `0b10001110` (-114)
2. Flip bits: `0b01110001`
3. Add one: `0b01110010`
4. Verify: $64 + 32 + 16 + 2 = 114$

### Example: 50 to -50
1. Start: `0b00110010` (50)
2. Flip bits: `0b11001101`
3. Add one: `0b11001110`
4. Verify: $-128 + 64 + 8 + 4 + 2 = -50$

**Related:** [[Bitwise Operations]], [[Overflow]]
