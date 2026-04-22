# CSE351: Pointers

A **pointer** is a special variable that stores a **memory address**. In a 64-bit architecture like x86-64, pointers are always 8 bytes in size, regardless of the data type they point to.

## Key Pointer Operators

| Operator | Name | Description |
|:--------:|:-----|:------------|
| `&` | **Address-of** | Returns the memory address of a variable. |
| `*` | **Dereference** | Accesses the value stored at the address a pointer holds. |

## Defining and Using Pointers

```c
#include <stdio.h>

int main() {
    int q = 10;

    // Declare pointer and assign address
    int* ptr1 = &q;

    // Dereference to get value
    int p = *ptr1;  // p = 10

    printf("Value of q: %d\n", q);
    printf("Address of q (&q): %p\n", &q);
    printf("Pointer ptr1 holds: %p\n", ptr1);
    printf("Value of p (*ptr1): %d\n", p);

    return 0;
}
```

The type a pointer points to determines:
- How many bytes to read/write when dereferencing.
- How **pointer arithmetic** scales operations.

---

## Pointer Arithmetic

Pointer arithmetic automatically scales operations by the size of the data type being pointed to. It treats memory as a sequence of "elements" rather than just raw bytes.

### Adding an Integer to a Pointer
Calculates the memory address of an element a certain number of places away.
**Formula:** `New Address = Current Address + (Integer * sizeof(Data Type))`

- **`int` Pointer (4 bytes)**: `p1 + 3` starting at `0x1000` becomes `0x1000 + (3 * 4) = 0x100c`.
- **`char` Pointer (1 byte)**: `p1 + 3` starting at `0x1000` becomes `0x1000 + (3 * 1) = 0x1003`.

### Subtracting Two Pointers
Returns the **number of elements** between two addresses.
**Formula:** `Element Difference = (Address2 - Address1) / sizeof(Data Type)`

- **Example**: If `p1` is `0x1000` and `p2` is `0x1030` (48 bytes apart), the difference for `int` pointers is `48 / 4 = 12` elements.

### Connection to Arrays
The subscript operator `ar[i]` is syntactic sugar for pointer arithmetic:
```c
ar[i] == *(ar + i)
```

## Related
- [[CSE351/Memory Fundamentals/Words and Memory|Words and Memory]]
- [[CSE351/Memory Fundamentals/Endianness|Endianness]]
- [[CSE351/Data Structures/Arrays|Arrays]]
- [[CSE351/x86-64 Assembly/x86-64 Memory Operands|x86-64 Memory Operands]]
