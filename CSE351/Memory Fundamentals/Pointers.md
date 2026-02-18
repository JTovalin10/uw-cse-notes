# Pointers

Pointers are special variables that store a **memory address**. The size of a pointer depends on the system's architecture (8 bytes on 64-bit), not the type of data it points to.

**Related:** [[Words and Memory]], [[Endianness]], [[Pointer Arithmetic]]

---

## Key Pointer Operators

| Operator | Name | Description |
|:--------:|:-----|:------------|
| `&` | Address-of | Returns the memory address of a variable |
| `*` | Dereference | Accesses the value at the address a pointer holds |

---

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

---

## Pointer Types

The type a pointer points to determines:
- How many bytes to read/write when dereferencing
- How [[Pointer Arithmetic]] scales operations

```c
int* ip;    // Points to int (4 bytes)
char* cp;   // Points to char (1 byte)
long* lp;   // Points to long (8 bytes)
```

**Related:** [[Arrays]], [[The Stack]], [[CSE484/Memory Exploits/Memory Layout]]
