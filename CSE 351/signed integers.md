# Signed Integers: Two's Complement

Signed integers represent both positive and negative numbers. While many encodings are possible, the standard implementation in all modern computers is **Two’s Complement**.

---

## Representation

The key idea is that the weight of the **most significant bit (MSB)** is made negative. For an $n$-bit number, the weight of the MSB is $-2^{n-1}$ instead of $2^{n-1}$. The weights of all other bits remain positive.

**8-bit Example:**
Let's find the value of `0b10001110`.

-   The MSB is `1`, so its value is $-2^7 = -128$.
-   The other set bits are `2^3`, `2^2`, and `2^1`.
-   **Total Value:** $-128 + 8 + 4 + 2 = -114$.

---

## Advantages of Two's Complement

This representation is used because it has several key advantages:

* **Unique Zero:** Zero has a single representation, an encoding of all zeros (`0b0...0`).
* **Balanced Range:** It represents roughly the same number of positive and negative numbers. The range for an $n$-bit number is from **$-2^{n-1}$ to $2^{n-1} - 1$**. For 8 bits, this is -128 to 127.
* **Consistent Positives:** The encodings for positive numbers exactly match their unsigned binary representations.
* **Simple Negation:** Negating a number is a straightforward two-step process.

---

## Negation Procedure

To find the two's complement negative of any integer (e.g., to turn 50 into -50 or -114 into 114), you follow one simple rule: **"flip the bits and add one."**

Mathematically, this is expressed as `-x == ~x + 1`.

### Example 1: Negative to Positive

Let's negate `-114` (`0b10001110`) to get `114`.

1.  **Flip the bits:** `~0b10001110` becomes `0b01110001`.
2.  **Add one:** `0b01110001 + 1` becomes `0b01110010`.

**Verification:**
`0b01110010` = $2^6 + 2^5 + 2^4 + 2^1 = 64 + 32 + 16 + 2 = 114$. ✅

### Example 2: Positive to Negative

Let's negate `50` to get `-50`. First, represent 50 in 8-bit binary: `0b00110010`.

1.  **Flip the bits:** `~0b00110010` becomes `0b11001101`.
2.  **Add one:** `0b11001101 + 1` becomes `0b11001110`.

**Verification:**
The value of `0b11001110` is $-128 + 64 + 8 + 4 + 2 = -50$. ✅