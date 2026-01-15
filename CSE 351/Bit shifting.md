
The shift operators (`<<`, `>>`) move all bits in a variable to the left or right by a specified number of positions, `n`. Bits that "fall off" one end are discarded, and the newly vacant bit positions on the other end are filled in.

---

## Types of Shifts

### Left Shift (`<<`)
A **left shift** (`x << n`) shifts all bits to the left and fills the `n` vacated bits on the right with **zeros**.

* **8-bit Example:** `00011001 << 2`
    * The two bits on the left (`00`) fall off.
    * The remaining bits shift left.
    * Two `0`s are added to the right.
    * Result: `01100100`

### Logical Right Shift (`>>` on `unsigned` types)
A **logical right shift** shifts all bits to the right and fills the `n` vacated bits on the left with **zeros**. This is the default behavior for `unsigned` data types.

* **8-bit Unsigned Example:** `10010001 >> 2`
    * The two bits on the right (`01`) fall off.
    * The remaining bits shift right.
    * Two `0`s are added to the left.
    * Result: `00100100`

### Arithmetic Right Shift (`>>` on `signed` types)
An **arithmetic right shift** shifts all bits to the right but fills the `n` vacated bits on the left with copies of the **original most significant bit (MSB)**. This is crucial as it preserves the number's sign.

* **8-bit Signed Example (Negative Number):** `-111` is `10010001`
    * The original MSB is `1`.
    * The two bits on the right (`01`) fall off.
    * The remaining bits shift right.
    * Two copies of the MSB (`1`) are added to the left.
    * Result: `11100100`

> **Warning:** Shifting by a negative amount or by an amount greater than or equal to the variable's bit width is undefined behavior in C.

---

## Bit Shifting as Arithmetic 🧠

Shifting bits is a very fast and efficient way to perform multiplication and division by powers of 2.

* **Left Shift (`x << n`) is equivalent to multiplying by $2^n$.**
    This can lead to overflow if the result is too large for the data type.

    * **Example:**
        `char x = 5;` (`0b00000101`)
        `char y = x << 2;`
        The result `y` is `0b00010100`, which is 20.
        This is the same as $5 \times 2^2 = 5 \times 4 = 20$.

* **Right Shift (`x >> n`) is equivalent to dividing by $2^n$.**
    For negative numbers, the result of an arithmetic right shift is typically rounded down (towards negative infinity), which may differ slightly from C's standard integer division (which truncates toward zero).