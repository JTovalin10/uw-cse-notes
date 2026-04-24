# CSE 333: Pointers

**Pointers** are variables that store memory addresses. They point to locations within the process's **virtual address space**.

## Definition and Dereferencing
- **Address-of operator (`&`)**: `&foo` produces the virtual address of `foo`.
- **Dereference operator (`*`)**: Accesses the memory referred to by a pointer.

```c
int x = 351;
int* p;    // p is a pointer to an int
p = &x;    // p now contains the address of x
*p = 333;  // changes the value of x to 333
```

## Pointer Arithmetic
Pointers are **typed**, which tells the compiler the size of the data being pointed to. 
- **Arithmetic Scaling**: Pointer arithmetic (e.g., `p + 1`) is automatically scaled by `sizeof(*p)`.
- **Generic Pointers (`void*`)**: A placeholder pointer that has no associated type. Arithmetic is **not** allowed on `void*` because its size is unknown.
- **Valid Operations**:
  - Add/subtract an integer and a pointer.
  - Subtract two pointers (only within the same stack frame or malloc block).
  - Compare pointers (`<`, `==`, etc.), including comparisons against `NULL`.

## Function Pointers
A function name is essentially the address of the function's code. **Function Pointers** allow storing and passing these addresses.
- **Syntax**: `returnType (*name)(type1, ..., typeN)`
- **Usage**: Used for callbacks or generic algorithms like `map()`.

```c
int negate(int num) { return -num; }
int (*op)(int n) = negate;
int result = op(5); // calls negate(5)
```

## Endianness
**Endianness** determines the order in which multi-byte data is stored in memory.
- **Big-endian**: Least significant byte has the **highest** address.
- **Little-endian**: Least significant byte has the **lowest** address (standard on x86-64).

Related: Arrays, [[Memory Management/Stack]], [[Memory Management/Heap Management]], [[CSE351/Memory Fundamentals/Pointers|CSE351: Pointers]]
