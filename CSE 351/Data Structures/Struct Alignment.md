# Struct Alignment and Padding

**Related:** [[Structs]], [[Memory Layout]], [[Memory Allocation]]

---

## Alignment Rule

An object of size `K` bytes is **aligned** if its address is a multiple of `K`.

---

## Struct Layout Rules

1. **Field ordering** follows definition order
2. **Padding inserted** between fields for alignment
3. **Internal fragmentation** = unused space between fields
4. **External fragmentation** = padding at end of struct

---

## Internal Fragmentation Example

```c
struct ex1 {
    short s;  // 2B
    int i;    // 4B (needs 4-byte alignment)
} instance1;
```

Layout: `[s  ][__][i   ]` (2 bytes padding)

```c
struct ex2 {
    char c;       // 1B
    int i_ar[3];  // 12B (array alignment = element size = 4B)
} instance2;
```

Layout: `[c][___][i_ar      ]` (3 bytes padding)

---

## External Fragmentation

Overall struct size must be multiple of **largest field alignment** (`K_max`).

This ensures proper alignment in arrays of structs.

---

## Complete Example

```c
struct frag {
    char c;         // K=1, offset 0
    int i[3];       // K=4, offset 4 (3B internal padding)
    struct frag *p; // K=8, offset 16 (0B padding)
    short s;        // K=2, offset 24
} f;
```

- `K_max = 8` (from pointer)
- Current end: offset 26
- Need multiple of 8 → add 6 bytes external padding
- **Total size: 32 bytes**

---

## Memory Layout Visualization

```
 4B    6B     6B      8B     4B    4B
[i  ][s   ][______][c    ][f  ][____]
      ^internal     ^external
      fragmentation fragmentation
```

---

## Calculation Practice

```c
struct q1 {
    int i;      // 4B at offset 0
    short s[3]; // 6B at offset 4
    char* c;    // 8B at offset 16 (6B internal padding)
    float f;    // 4B at offset 24
};
```

- `K_max = 8`, pad to 32 bytes (4B external)
- **Total: 32 bytes**

**Related:** [[Memory Allocation]], [[Arrays]]
