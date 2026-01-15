Pointer arithmetic takes the size of the data type being pointed to into account by automatically scaling the operation. You can think of this as a change in units from bytes to "elements" of the data type.

---

## Adding an Integer to a Pointer

This operation calculates the memory address of an element a certain number of places away from the current one.

**Formula:**
`New Address = Current Address + (Integer * sizeof(Data Type))`

### Examples

#### `int` Pointer (assuming `sizeof(int)` is 4 bytes)
- **Operation:** `p1 + 3`
- **Pointer `p1` Address:** `0x1000`
- **Calculation:** `0x1000 + (3 * 4 bytes)` = `0x1000 + 12`
- **Resulting Address:** `0x100c`

#### `char` Pointer (assuming `sizeof(char)` is 1 byte)
- **Operation:** `p1 + 3`
- **Pointer `p1` Address:** `0x1000`
- **Calculation:** `0x1000 + (3 * 1 byte)` = `0x1000 + 3`
- **Resulting Address:** `0x1003`

---

## Subtracting Two Pointers

Subtracting two pointers of the same type gives you the number of elements that fit between their two memory addresses.

**Formula:**
`Element Difference = (Address 2 - Address 1) / sizeof(Data Type)`

### Example

#### `int` Pointers (assuming `sizeof(int)` is 4 bytes)
- **Pointer `p1` Address:** `0x1000`
- **Pointer `p2` Address:** `0x1030`
- **Byte Difference:** `0x1030 - 0x1000` = `0x30` (48 in decimal)
- **Calculation:** `48 bytes / 4 bytes` = 12
- **Result:** `12` (which is `0xc` in hexadecimal)