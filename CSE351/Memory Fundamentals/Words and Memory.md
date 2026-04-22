# CSE351: Words and Memory

In systems programming, **memory** is a hardware component that acts as local data storage for the CPU during instruction execution. Data is moved and manipulated in fixed-length chunks called **words**.

## Word Size
**Word size** is the number of bits used by the CPU to execute instructions. 
- On a 64-bit system, the word size is **8 bytes** (64 bits).
- The word size determines the size of pointers and the maximum addressable memory.

## Memory Addresses
Each byte in memory is assigned a unique **memory address**, typically represented in hexadecimal.
- On 64-bit systems, addresses are 8 bytes wide.
- The address space is the set of all possible addresses the CPU can generate.

---

## Endianness (Byte Ordering)

**Endianness** refers to the order in which the individual bytes of a multi-byte data type (like an `int` or `long`) are stored in memory.

### MSB and LSB
- **Most Significant Bit (MSB)**: The left-most bit in a word.
- **Least Significant Bit (LSB)**: The right-most bit in a word.
- **Most Significant Byte**: The byte containing the MSB.
- **Least Significant Byte**: The byte containing the LSB.

### Byte Ordering Models
For multibyte data, consecutive bytes are stored in consecutive memory addresses. 

| Model | Description |
|:---|:---|
| **Big-Endian** | The **most significant byte** is stored first (at the lowest address). This matches "natural" reading order. |
| **Little-Endian** | The **least significant byte** is stored first (at the lowest address). **x86-64** uses little-endian. |

### Example: Storing `0xA1B2C3D4` at address `0x100`
- **MSB Byte**: `A1`
- **LSB Byte**: `D4`

| Address | Big-Endian | Little-Endian |
|:---:|:---:|:---:|
| `0x100` | `A1` | `D4` |
| `0x101` | `B2` | `C3` |
| `0x102` | `C3` | `B2` |
| `0x103` | `D4` | `A1` |

## Related
- [[CSE351/Memory Fundamentals/Pointers|Pointers]]
- [[CSE351/Number Representation/Binary and Hexadecimal|Binary and Hexadecimal]]
- [[CSE351/x86-64 Assembly/x86-64 Registers|x86-64 Registers]]
- [[CSE351/Security/Buffer Overflow|Buffer Overflow]]
