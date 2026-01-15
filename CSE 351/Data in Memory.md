data is moved and manipulated in a fixed length chunks. with each chunk:
**Most Significant bit (MSB)**: left-most bit
**Least Significant bit (LSB)**: right-most bit
$$
MSB \rightarrow 00000000000001012_2 \leftarrow LSB
$$
***

For multibyte data, consecutive bytes are stored in consecutive memory addresses. **Endianness** refers to the order in which those bytes are arranged in memory.

* In a **big-endian** machine, the **most significant byte** (the "big end") is stored first, at the lowest memory address.
* In a **little-endian** machine, the **least significant byte** (the "little end") is stored first, at the lowest memory address.

***

### Example: Storing `0xA1B2C3D4` 🖥️

Let's store the 4-byte hexadecimal value `0xA1B2C3D4` starting at memory address `0x100`.

* **Most Significant Byte (MSB):** `A1`
* **Least Significant Byte (LSB):** `D4`

#### Big-Endian ("Natural Order")

The most significant byte, `A1`, is stored at the lowest address. The byte order is preserved as written.

| Memory Address | Stored Byte |
| :------------- | :---------- |
| `0x100`        | `A1`        |
| `0x101`        | `B2`        |
| `0x102`        | `C3`        |
| `0x103`        | `D4`        |

#### Little-Endian (Reversed Order)

The least significant byte, `D4`, is stored at the lowest address. The byte order is reversed.

| Memory Address | Stored Byte |
| :------------- | :---------- |
| `0x100`        | `D4`        |
| `0x101`        | `C3`        |
| `0x102`        | `B2`        |
| `0x103`        | `A1`
[[Memory and Addresses]]