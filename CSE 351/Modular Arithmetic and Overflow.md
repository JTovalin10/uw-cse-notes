
### Modular Arithmetic

Arithmetic on fixed-width binary numbers is performed using **modular arithmetic**. This means that any bits that go past the fixed width are simply dropped, causing the values to "wrap around."

Subtraction is performed by adding the negative of a number. For signed integers, this uses the Two’s Complement negation technique: `-x == ~x + 1`.

### 4-bit Addition Examples

Here are some examples showing how the same binary addition can be interpreted differently depending on whether the numbers are treated as unsigned or signed (Two's Complement). The 4-bit unsigned range is [0, 15] and the signed range is [-8, 7].

| Operation              | HW Result | Unsigned (US) Interpretation | Signed (TC) Interpretation |
| ---------------------- | --------- | ---------------------------- | -------------------------- |
| `0011 + 0010`          | `0101`    | `3 + 2 = 5`                  | `3 + 2 = 5` (No Overflow)  |
| `0100 + 1101`          | `10001`   | `4 + 13 = 17 -> 1` (**Overflow**) | `4 + (-3) = 1` (No Overflow) |
| `0101 + 0100`          | `1001`    | `5 + 4 = 9`                  | `5 + 4 = -7` (**Overflow**) |
| `1011 + 1100`          | `10111`   | `11 + 12 = 23 -> 7` (**Overflow**) | `(-5) + (-4) = 7` (**Overflow**) |

---

## Arithmetic Overflow ⚠️

**Arithmetic overflow** occurs when the result of a calculation is too large or too small to be represented in the given number of bits. This is a direct consequence of working with fixed-width data types.

### Unsigned Overflow

This occurs when the result of an operation falls outside the range of $[0, 2^n - 1]$. For unsigned numbers, this is simply a carry-out from the most significant bit.

-   **In the table:** `4 + 13 = 17`, which is greater than the max value of 15. The hardware result `0b10001` drops the leading `1`, leaving `0001` (1). This is the same as `17 mod 16`.

### Signed Overflow

This occurs when the result of an operation falls outside the range of $[-2^{n-1}, 2^{n-1} - 1]$.

The easiest way to detect signed overflow is to check the signs of the operands and the result:

> **Signed overflow occurs if you add two numbers with the same sign, and the result has the opposite sign.**

-   **Positive + Positive -> Negative**
    -   In the table: `5 + 4` should be `9`. But the result `1001` represents `-7`. We added two positives and got a negative. **Overflow!**

-   **Negative + Negative -> Positive**
    -   In the table: `(-5) + (-4)` should be `-9`. But the result `0111` represents `7`. We added two negatives and got a positive. **Overflow!**

*Note: Adding two numbers with different signs can never cause signed overflow.*