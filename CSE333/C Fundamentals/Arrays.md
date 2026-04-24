# CSE 333: Arrays

**Arrays** in C are contiguous chunks of memory. They are not objects, do not know their own length, and do not support bounds checking.

## Definition and Initialization
- **Syntax**: `type name[size]`
- **Contiguous Memory**: Allocates `size * sizeof(type)` bytes.
- **Garbage Values**: Initially, array values are uninitialized ("garbage").
- **Initialization**: Can only be used at the time of definition.
  - `int primes[6] = {2, 3, 5, 7, 11, 13};`
  - If no size is supplied, it is inferred from the initializer.

## Array Names vs. Pointers
An array name evaluates to the address of the start of the array.
- It acts like a **constant pointer** to the first element; it cannot be reassigned.
- **Promotion**: When passed to a function, an array is "promoted" to a pointer to its first element.

## Multi-dimensional Arrays
Stored in **row-major order** as a single contiguous chunk of memory.
- **Syntax**: `type name[rows][cols]`
- Normally only useful if sizes are known at compile-time.

## Arrays as Parameters
Because arrays do not know their size, it is a standard idiom to pass the size as a separate parameter.
- **Incorrect**: `int* copyArray(int src[], int size)` returning a local array (allocated on the stack and disappears).
- **Correct (Output Parameter)**: Pass a pointer to a buffer allocated by the caller.

```c
void copyArray(int src[], int dst[], int size) {
    for (int i = 0; i < size; i++) {
        dst[i] = src[i];
    }
}
```

Related: [[Pointers]], [[Memory Management/Stack]], [[C Fundamentals/Introduction to C]]
