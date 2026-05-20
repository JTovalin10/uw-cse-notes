# CSE333: Data Type Sizes

In systems programming, understanding the size of data types is critical for [[CSE333/Memory Management/Malloc and Free|memory allocation]], [[CSE333/C Fundamentals/Pointers|pointer arithmetic]], and ensuring correct behavior across architectures.

## Size Reference Table (Typical 64-bit System)

| Type | Size |
|------|------|
| `char` | 1 byte |
| `short` | 2 bytes |
| `int` | 4 bytes |
| `long long` | 8 bytes |
| `float` | 4 bytes |
| `double` | 8 bytes |
| Pointer (any type) | 8 bytes |

For a more complete table including 32-bit sizes and `printf` format specifiers, see [[CSE333/C Fundamentals/Types and Modifiers|Types and Modifiers]].

## Key Concepts

- Sizes are **architecture-dependent**. On a 32-bit system, a pointer is 4 bytes; on 64-bit it is 8 bytes.
- Use **`sizeof()`** in C to determine the exact size of a type or variable on the current system at compile-time. For example: `malloc(10 * sizeof(int))` is portable across architectures.
- The `long` type is particularly tricky: it is 4 bytes on Windows 64-bit but 8 bytes on Linux/macOS 64-bit. Use `int64_t` from `<stdint.h>` for guaranteed 64-bit integers.

## Related

- [[CSE333/Memory Management/Malloc and Free|Malloc and Free]]
- [[CSE333/C Fundamentals/Pointers|Pointers]]
- [[CSE333/C Fundamentals/Types and Modifiers|Types and Modifiers]]

## Industry Standard Terms

- **`sizeof()` operator** — A compile-time operator, not a function; the compiler replaces it with a constant before code generation
- **ABI (Application Binary Interface)** — Defines the sizes of types, struct layout rules, and calling conventions for a given platform; mismatches between ABIs cause binary incompatibilities
