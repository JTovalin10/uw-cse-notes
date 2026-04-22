# CSE351: Condition Codes

**Condition codes** (also known as flags) are status bits within the CPU that track information about the most recently executed instruction. These bits are stored in the **`EFLAGS` register**.

## The Four Main Flags

| Flag | Name | Description |
|:---:|:---|:---|
| **`CF`** | **Carry Flag** | Set if unsigned overflow occurred. |
| **`ZF`** | **Zero Flag** | Set if the result was zero. |
| **`SF`** | **Sign Flag** | Set if the result was negative (MSB = 1). |
| **`OF`** | **Overflow Flag** | Set if signed overflow occurred. |

## How Condition Codes Are Set

### 1. Implicit Setting (Side Effects)
Arithmetic and logical operations (like `addq`, `subq`, `imulq`) **automatically update** condition codes as a side effect of the operation.

- **Example**: If `%al = 0x80` (-128 in 2's complement), then `addb %al, %al` results in `%al = 0x00` with flags:
  - `CF = 1` (unsigned overflow: 0x80 + 0x80 = 0x100)
  - `ZF = 1` (result is zero)
  - `SF = 0` (result MSB is 0)
  - `OF = 1` (signed overflow: -128 + -128 = -256, which is too small for 1 byte)

### 2. Explicit Setting (Dedicated Instructions)
Some instructions are designed specifically to set condition codes without storing a result:

- **`cmpq A, B`**: Performs the subtraction `B - A` but **does not store the result**. It is used to compare values.
- **`testq A, B`**: Performs a bitwise AND (`B & A`) but **does not store the result**. It is often used to check if a value is zero or to test individual bits.

## Key Properties
- **Bitwise Operations**: Instructions like `and`, `or`, and `xor` always set `CF = 0` and `OF = 0`.
- **`cmp` and `test`**: These instructions never modify their operands, only the condition codes.

## Related
- [[CSE351/x86-64 Assembly/Jump Instructions|Jump Instructions]]
- [[CSE351/Number Representation/Bitwise Operations|Bitwise Operations]]
- [[CSE351/Number Representation/Overflow|Overflow]]
- [[CSE351/x86-64 Assembly/Conditionals|Conditionals]]
- [[CSE351/x86-64 Assembly/Loops|Loops]]
