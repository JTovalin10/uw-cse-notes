# Unsigned Integers

Unsigned integers represent **non-negative numbers** (i.e., counting up from 0). The bit pattern used matches standard binary numerals but is stored in a fixed width based on the C data type.

---

## Data Types and Ranges

On a typical 64-bit machine, the standard unsigned integer types are:
* `unsigned char`: 1 byte (8 bits)
* `unsigned short`: 2 bytes (16 bits)
* `unsigned int`: 4 bytes (32 bits)
* `unsigned long`: 8 bytes (64 bits)

For a given integer width of $n$ bits, we can represent $2^n$ different values. For unsigned integers, this covers the range from **$0$ to $2^n - 1$**.

For example, an 8-bit `unsigned char` can represent values from $0$ to $2^8 - 1$ (which is $0$ to $255$).

---

## Binary Arithmetic

We can perform addition and subtraction in binary much like we do in decimal, except that the **carry** and **borrow** happen at the value of **2** instead of 10.

### Example: Binary Addition (8-bit)

Let's add `170 + 73 = 243`.
* `170` in binary is `10101010`
* `73` in binary is `01001001`