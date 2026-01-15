
---

## Bitwise vs. Logical Operators

In C, it's important to distinguish between **bitwise operators**, which manipulate individual bits of data, and **logical operators**, which evaluate the overall "truth" of expressions.

### Bitwise Operators (`&`, `|`, `^`, `~`)

Bitwise operators work on integral data types like `char`, `int`, and `long`. They apply Boolean algebra operations to each pair of corresponding bits in the operands.

* **AND (`&`)**
    The `&` operator compares each bit of the first operand to the corresponding bit of the second operand. If both bits are `1`, the corresponding result bit is set to `1`. Otherwise, the result bit is set to `0`.
    **Use Case:** Often used to "mask" or isolate specific bits.
    ```c
      01010101  (85)
    & 00110011  (51)
    ------------------
    = 00010001  (17)
    ```

* **OR (`|`)**
    The `|` operator compares each bit of the first operand to the corresponding bit of the second. If at least one of the bits is `1`, the corresponding result bit is set to `1`.
    **Use Case:** Often used to "set" or turn on specific bits.
    ```c
      01010101  (85)
    | 00110011  (51)
    ------------------
    = 01110111  (119)
    ```

* **XOR (`^`) - Exclusive OR**
    The `^` operator compares each bit of the first operand to the corresponding bit of the second. If the bits are *different*, the corresponding result bit is `1`. If they are the same, the result bit is `0`.
    **Use Case:** Often used to "flip" or toggle specific bits.
    ```c
      01010101  (85)
    ^ 00110011  (51)
    ------------------
    = 01100110  (102)
    ```

* **NOT (`~`) - Complement**
    This unary operator inverts all the bits of its operand.
    ```c
    ~ 01010101  (85)
    ------------------
    = 10101010  (-86, due to two's complement representation)
    ```

### Logical Operators (`&&`, `||`, `!`)

Logical operators treat entire values as either **true** or **false**. In C, `0` is false, and any non-zero value is true. They always return `1` for true and `0` for false.

* **Logical AND (`&&`)**
    Evaluates to true (`1`) only if **both** operands are true (non-zero).
    ```c
    int result = (5 && 0); // result is 0 (false)
    ```

* **Logical OR (`||`)**
    Evaluates to true (`1`) if **at least one** of the operands is true (non-zero).
    ```c
    int result = (5 || 0); // result is 1 (true)
    ```

* **Logical NOT (`!`)**
    Reverses the logical state of its operand.
    ```c
    int result = !0; // result is 1 (true)
    ```
[[Base Representation]]