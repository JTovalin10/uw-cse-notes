Pointers are special variables that store a **memory address**. The size of a pointer depends on the system's architecture (e.g., 8 bytes on a 64-bit machine), not the type of data it points to.

[[Memory and Addresses]]
[[Data in Memory]]

***

### Key Pointer Operators 🧠

| Operator | Name | Description |
| :---: | :--- | :--- |
| `&` | Address-of | Returns the memory address of a variable. |
| `*` | Dereference | Accesses the value at the address a pointer holds. |

***

### Defining and Using Pointers in C

The following example shows how to declare, initialize, and dereference a pointer.

```c
#include <stdio.h>

int main() {
    int q = 10; // Initialize an integer variable.

    // 1. Declare a pointer 'ptr1' that can point to an integer.
    // 2. Use the address-of operator '&' to get q's memory address.
    // 3. Assign that address to the pointer.
    int* ptr1 = &q; 

    // Use the dereference operator '*' to access the value
    // stored at the address ptr1 is holding. This returns 10.
    int p = *ptr1;

    // --- Let's print the values to see what's happening ---
    printf("Value of q:\t\t\t%d\n", q);
    printf("Address of q (&q):\t\t%p\n", &q);
    printf("Pointer ptr1 holds the address:\t%p\n", ptr1);
    printf("Value of p (*ptr1):\t\t%d\n", p);

    return 0;
}