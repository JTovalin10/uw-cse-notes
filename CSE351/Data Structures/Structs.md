# CSE351: Structs

A **struct** (structure) in C is a user-defined data type that allows grouping related variables of different types into a single unit.

## Definition and Declaration

```c
struct struct_tag {
    type_1 field_1;
    ...
    type_N field_N;
};

struct struct_tag my_struct_var; // Instance
```

### Typedef Pattern
Using `typedef` allows for cleaner declarations by creating an alias for the struct type:

```c
typedef struct {
    int x;
    int y;
} Point;

Point pt1; // No need to use 'struct' keyword
```

## Field Access
Fields within a struct are accessed using the dot (`.`) operator for instances or the arrow (`->`) operator for pointers:

```c
pt.x       // Instance access
ptr->y     // Pointer access
(*ptr).y   // Equivalent to ptr->y
```

---

## Struct Alignment and Padding

To optimize memory access, compilers follow **alignment rules**. An object of size $K$ bytes is **aligned** if its memory address is a multiple of $K$.

### Layout Rules
1. **Field Ordering**: Fields follow the order of their definition in the struct.
2. **Internal Padding**: The compiler inserts unused bytes between fields to ensure each field starts at an aligned address.
3. **External Padding**: The compiler adds padding at the end of the struct so that the total size is a multiple of the largest field's alignment ($K_{max}$). This ensures alignment when structs are used in arrays.

### Example: Alignment and Fragmentation
```c
struct example {
    short s;  // 2 bytes, offset 0
    int i;    // 4 bytes, needs 4-byte alignment -> offset 4 (2B padding)
    char c;   // 1 byte, offset 8
} instance;   // K_max = 4. Current size 9, pad to multiple of 4 -> 12 bytes total.
```

**Internal Fragmentation**: Unused space between fields (e.g., the 2 bytes after `short s`).
**External Fragmentation**: Unused space at the end of the struct (e.g., the 3 bytes after `char c`).

## Related
- [[CSE351/Data Structures/Arrays|Arrays]]
- [[CSE351/Memory Fundamentals/Pointers|Pointers]]
- [[CSE351/Memory Management/Memory Allocation|Memory Allocation]]
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout]]
