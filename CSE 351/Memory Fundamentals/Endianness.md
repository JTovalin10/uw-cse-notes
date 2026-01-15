# Endianness

Data is moved and manipulated in fixed-length chunks.

**Related:** [[Words and Memory]], [[Pointers]], [[Data in Memory]]

---

## MSB and LSB

| Term | Definition |
|------|------------|
| **Most Significant Bit (MSB)** | Left-most bit |
| **Least Significant Bit (LSB)** | Right-most bit |

$$MSB \rightarrow 00000000000001012_2 \leftarrow LSB$$

---

## Byte Ordering

For **multibyte data**, consecutive bytes are stored in consecutive memory addresses. **Endianness** refers to the byte ordering.

### Big-Endian
- **Most significant byte** stored first (lowest address)
- "Natural" reading order

### Little-Endian
- **Least significant byte** stored first (lowest address)
- x86-64 uses little-endian

---

## Example: Storing `0xA1B2C3D4` at address `0x100`

- **MSB:** `A1`
- **LSB:** `D4`

### Big-Endian

| Address | Byte |
|---------|------|
| `0x100` | `A1` |
| `0x101` | `B2` |
| `0x102` | `C3` |
| `0x103` | `D4` |

### Little-Endian

| Address | Byte |
|---------|------|
| `0x100` | `D4` |
| `0x101` | `C3` |
| `0x102` | `B2` |
| `0x103` | `A1` |

**Related:** [[Buffer Overflow]], [[Two's Complement]]
