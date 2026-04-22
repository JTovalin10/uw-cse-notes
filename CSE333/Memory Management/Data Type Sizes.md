# CSE333: Data Type Sizes

In systems programming, understanding the size of data types is critical for memory management and pointer arithmetic.

| Type | Size (typical 64-bit system) |
|---|---|
| `char` | 1 byte |
| `short` | 2 bytes |
| `int` | 4 bytes |
| `long long` | 8 bytes |
| `float` | 4 bytes |
| `double` | 8 bytes |
| Pointer (any type) | 8 bytes |

## Key Concepts
- Sizes are architecture-dependent (e.g., 32-bit vs 64-bit).
- Pointers on a 32-bit system are 4 bytes.
- Use `sizeof()` in C to determine the exact size of a type or variable on the current system.

## Related
- [[CSE333/Memory Management/Malloc|Malloc]]
- [[CSE333/Memory Management/Pointers|Pointers]]
