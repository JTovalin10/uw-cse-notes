# Extension Instructions (movz and movs)

Extension instructions handle **size mismatches** where source is smaller than destination.

**Related:** [[x86-64 Instruction Format]], [[Two's Complement]], [[Unsigned Integers]]

---

## Two Types

### Zero Extension (`movz`)
- Fills upper bits with **zeros**
- Used for **unsigned** values

### Sign Extension (`movs`)
- Fills upper bits with copies of **sign bit**
- Used for **signed** values

---

## Instruction Format

**Two size specifiers:** `mov[z|s][source_size][dest_size]`

---

## Examples

Starting with `%al = 0x80`:

```assembly
movzbw %al, %bx     # Zero extend byte->word: %bx = 0x0080
movsbw %al, %bx     # Sign extend byte->word: %bx = 0xFF80
movsbl %al, %ebx    # Sign extend byte->long: %ebx = 0xFFFFFF80
```

---

## Important Note

When using 32-bit destination, upper 32 bits are automatically zeroed:

```assembly
movsbl %al, %ebx    # %ebx = 0xFFFFFF80
                    # %rbx = 0x00000000FFFFFF80
```

---

## Quiz Example

**Question:** If `%rdi = 0xF8F7F6F5F4F3F2F1`, what is `%rdi` after `movswq %di, %rdi`?

**Solution:**
- `%di` = `0xF2F1` (lower 16 bits)
- Sign bit is 1 (negative)
- Sign extend: `%rdi = 0xFFFFFFFFFFFFF2F1`

**Related:** [[x86-64 Registers]], [[Two's Complement]]
