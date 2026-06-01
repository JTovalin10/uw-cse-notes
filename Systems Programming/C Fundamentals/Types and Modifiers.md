# CSE333: Types and Modifiers

C has a set of **primitive types** with sizes that can vary depending on the architecture (32-bit vs. 64-bit).

## Primitive Types

| C Data Type | 32-bit Size | 64-bit Size | `printf` format |
|-------------|-------------|-------------|-----------------|
| **char** | 1 byte | 1 byte | `%c` |
| **short int** | 2 bytes | 2 bytes | `%hd` |
| **int** | 4 bytes | 4 bytes | `%d` or `%i` |
| **unsigned int** | 4 bytes | 4 bytes | `%u` |
| **long int** | 4 bytes | 8 bytes | `%ld` |
| **long long int** | 8 bytes | 8 bytes | `%lld` |
| **float** | 4 bytes | 4 bytes | `%f` |
| **double** | 8 bytes | 8 bytes | `%lf` |
| **long double** | 12 bytes | 16 bytes | `%Lf` |
| **pointer** | 4 bytes | 8 bytes | `%p` |

## Modifiers

- **signed** / **unsigned**: Determines if the type can represent negative numbers.
- **short** / **long**: Influences the precision and range of the type.

## C99 Extended Integer Types

To solve the ambiguity of type sizes (like `long int`), C99 introduced `<stdint.h>`, which provides types with guaranteed widths:

- `int8_t`, `int16_t`, `int32_t`, `int64_t` (signed)
- `uint8_t`, `uint16_t`, `uint32_t`, `uint64_t` (unsigned)

It is recommended to use these **extended types** in most CSE333 code for clarity and safety. See [[Data Type Sizes|Data Type Sizes]] for a concise size reference table.

## Related

- [[Introduction to C|Introduction to C]]
- [[C Memory Model|C Memory Model]]
- [[Data Type Sizes|Data Type Sizes]]

## Industry Standard Terms

- **`<stdint.h>` fixed-width integers** — Universally used in embedded systems and systems software where portability requires guaranteed bit widths
- **`size_t`** — The canonical unsigned type for sizes and counts; always use it with `sizeof()` and memory allocation functions
