# Overflow

Arithmetic on fixed-width binary numbers uses **modular arithmetic**. Bits past the fixed width are dropped, causing values to "wrap around."

**Related:** [[Two's Complement]], [[Unsigned Integers]], [[Bit Shifting]]

---

## Modular Arithmetic

Subtraction is performed by adding the negative. For signed integers, use Two's Complement: `-x == ~x + 1`

---

## 4-bit Examples

| Operation | HW Result | Unsigned | Signed |
|-----------|-----------|----------|--------|
| `0011 + 0010` | `0101` | 3 + 2 = 5 | 3 + 2 = 5 |
| `0100 + 1101` | `10001` | 4 + 13 = **17 -> 1** | 4 + (-3) = 1 |
| `0101 + 0100` | `1001` | 5 + 4 = 9 | 5 + 4 = **-7** |
| `1011 + 1100` | `10111` | 11 + 12 = **23 -> 7** | (-5) + (-4) = **7** |

---

## Unsigned Overflow

Occurs when result falls outside $[0, 2^n - 1]$.

**Detection:** Carry-out from the MSB

**Example:** `4 + 13 = 17`, but 17 > 15 (max for 4-bit). Result wraps to `17 mod 16 = 1`.

---

## Signed Overflow

Occurs when result falls outside $[-2^{n-1}, 2^{n-1} - 1]$.

**Detection Rule:**
> Signed overflow occurs when adding two numbers with the **same sign** produces a result with the **opposite sign**.

### Positive + Positive -> Negative
`5 + 4` should be `9`, but result `1001` = `-7`. **Overflow!**

### Negative + Negative -> Positive
`(-5) + (-4)` should be `-9`, but result `0111` = `7`. **Overflow!**

**Note:** Adding numbers with different signs **cannot** cause signed overflow.

**Related:** [[Two's Complement]], [[Condition Codes]]
