# Bitwise Operations

Bitwise operators manipulate individual bits of integral data types (`char`, `int`, `long`).

**Related:** [[Binary and Hexadecimal]], [[Two's Complement]], [[Bit Shifting]]

---

## Bitwise Operators

### AND (`&`)
Sets result bit to `1` only if **both** input bits are `1`.

**Use Case:** Masking/isolating specific bits

```c
  01010101  (85)
& 00110011  (51)
----------
  00010001  (17)
```

### OR (`|`)
Sets result bit to `1` if **at least one** input bit is `1`.

**Use Case:** Setting/turning on specific bits

```c
  01010101  (85)
| 00110011  (51)
----------
  01110111  (119)
```

### XOR (`^`) - Exclusive OR
Sets result bit to `1` if bits are **different**.

**Use Case:** Toggling/flipping specific bits

```c
  01010101  (85)
^ 00110011  (51)
----------
  01100110  (102)
```

### NOT (`~`) - Complement
Inverts all bits.

```c
~ 01010101  (85)
----------
  10101010  (-86 in two's complement)
```

---

## Logical vs Bitwise Operators

| Bitwise | Logical | Difference |
|---------|---------|------------|
| `&` | `&&` | Bitwise operates on each bit; logical treats whole value as true/false |
| `\|` | `\|\|` | Same as above |
| `~` | `!` | Bitwise inverts bits; logical returns 0 or 1 |

### Logical Operators
- **`&&`**: True (`1`) if both operands are non-zero
- **`||`**: True (`1`) if at least one operand is non-zero
- **`!`**: Returns `1` if operand is `0`, else returns `0`

```c
int result = (5 && 0);  // result is 0 (false)
int result = (5 || 0);  // result is 1 (true)
int result = !0;        // result is 1 (true)
```

**Related:** [[Condition Codes]]
