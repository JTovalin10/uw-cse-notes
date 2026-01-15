# Binary and Hexadecimal

## Conversion to Decimal
$$ \sum_{i=0}^n d \times b^i$$
What this means is that we take the digit at position $i$ and multiply it by our current base to the power of the current index (working backwards from least significant digit).

**Related:** [[Two's Complement]], [[Unsigned Integers]]

---

## Converting from Decimal to Binary

To convert a decimal (base-10) number to binary (base-2), use the subtraction method:

1. **Find the largest power of 2** that is less than or equal to your target number
2. **Place a '1'** in the corresponding position
3. **Subtract** that power of 2 from your target
4. **Repeat** until the remainder is 0
5. **Place a '0'** in any skipped positions

### Example: Converting 114 to Binary

- $64$ ($2^6$) fits: Result `1xxxxxx`, Remainder: $114 - 64 = 50$
- $32$ ($2^5$) fits: Result `11xxxxx`, Remainder: $50 - 32 = 18$
- $16$ ($2^4$) fits: Result `111xxxx`, Remainder: $18 - 16 = 2$
- $8$ ($2^3$) > 2: Result `1110xxx`
- $4$ ($2^2$) > 2: Result `11100xx`
- $2$ ($2^1$) fits: Result `111001x`, Remainder: $2 - 2 = 0$
- $1$ ($2^0$): Result `1110010`

**Result:** $114_{10} = 1110010_2$

---

## Hexadecimal Representation

**Hexadecimal** is a **base-16** number system using digits 0-9 and letters A-F for values 10-15.

| Decimal | Hex |
|---------|-----|
| 0-9 | `0x0`-`0x9` |
| 10 | `0xA` |
| 11 | `0xB` |
| 12 | `0xC` |
| 13 | `0xD` |
| 14 | `0xE` |
| 15 | `0xF` |

Each hex digit corresponds to exactly 4 binary bits (a nibble).

**Related:** [[Bitwise Operations]], [[Memory and Addresses]]
