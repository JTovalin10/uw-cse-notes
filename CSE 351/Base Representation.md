# Conversion to Decimal
$$ \sum_{i=0}^n d \times b^i$$
what this means is that we take the decimal at $b_i$ and multiply it by our current base to the power of the current index (working backwards)
### Converting from Decimal to Binary

To convert a decimal (base-10) number to binary (base-2), you can use the subtraction method. The goal is to find which powers of 2 sum up to your target number.

1.  **Find the largest power of 2** that is less than or equal to your target number.
2.  **Place a '1'** in the corresponding position for that power of 2 in your binary result.
3.  **Subtract** that power of 2 from your target number to get a new remainder.
4.  **Repeat** the process with the new remainder until it becomes 0.
5.  **Place a '0'** in the positions for any powers of 2 that were skipped.

***

### Example: Converting 114 to Binary

Let's convert the decimal number $114_{10}$ to binary.

* The largest power of 2 less than or equal to 114 is $64$ ($2^6$).
    * Result: `1xxxxxx`
    * Subtract: $114 - 64 = 50$

* The largest power of 2 less than or equal to the remainder, 50, is $32$ ($2^5$).
    * Result: `11xxxxx`
    * Subtract: $50 - 32 = 18$

* The largest power of 2 less than or equal to the remainder, 18, is $16$ ($2^4$).
    * Result: `111xxxx`
    * Subtract: $18 - 16 = 2$

* The next power of 2 is $8$ ($2^3$), which is greater than 2. So, we place a 0.
    * Result: `1110xxx`

* The next power of 2 is $4$ ($2^2$), which is also greater than 2. So, we place another 0.
    * Result: `11100xx`

* The largest power of 2 less than or equal to the remainder, 2, is $2$ ($2^1$).
    * Result: `111001x`
    * Subtract: $2 - 2 = 0$

* The remainder is now 0. We fill the final position, $2^0$, with a 0.
    * Result: `1110010`

Thus, the decimal number 114 is represented in binary as **1110010**.

We can verify this by adding the values of the positions with a '1':
$$
(1 \times 2^6) + (1 \times 2^5) + (1 \times 2^4) + (0 \times 2^3) + (0 \times 2^2) + (1 \times 2^1) + (0 \times 2^0)
$$
$$
64 + 32 + 16 + 0 + 0 + 2 + 0 = 114
$$
Therefore:
$$
114_{10} = 1110010_2
$$
***
### Hexadecimal Representation (0-15)

* 0 = `0x0`
* 1 = `0x1`
* 2 = `0x2`
* 3 = `0x3`
* 4 = `0x4`
* 5 = `0x5`
* 6 = `0x6`
* 7 = `0x7`
* 8 = `0x8`
* 9 = `0x9`
* 10 = `0xA`
* 11 = `0xB`
* 12 = `0xC`
* 13 = `0xD`
* 14 = `0xE`
* 15 = `0xF`

***

### How It Works 🧠

**Hexadecimal** is a **base-16** number system. It uses the digits **0-9** for the first ten values and the letters **A-F** for the values 10 through 15. Each single character in hexadecimal corresponds to a four-digit binary number (a nibble).