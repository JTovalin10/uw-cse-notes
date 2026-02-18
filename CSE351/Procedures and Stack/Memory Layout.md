# Memory Layout

**Related:** [[The Stack]], [[CSE451/Virtual Memory/Virtual Memory]], [[Memory Allocation]]

---

## Memory Segments (High to Low Addresses)

| Segment | Purpose | Growth |
|---------|---------|--------|
| **Stack** | Local variables, function calls | Downward |
| **Heap** | Dynamic allocation (`malloc`) | Upward |
| **Static/Global** | Global variables, static data | Fixed |
| **Literals** | String literals, constants | Fixed |
| **Code/Text** | Program instructions | Fixed |

---

## The Stack

- **Location:** Highest usable addresses
- **Contents:** Local variables, procedure context
- **Growth:** Downward (toward lower addresses)
- **Management:** Automatic (by function calls/returns)

### Why Downward Growth?
- Convention from early systems
- Allows heap and stack to grow toward each other
- Maximizes available memory for both

---

## Address Ranges Example

```
0x7fff0b570788  (Stack)      ← Highest
0x12a8010       (Heap)
0x601038        (Static/Global)
0x400670        (Code)
0x400547        (Code)       ← Lowest
```

**Memory addresses ordered:** Code < Static < Heap < Stack

**Related:** [[CSE351/Procedures and Stack/Stack Pointer]], [[Stack Frames]], [[Memory Allocation]]
