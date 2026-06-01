# CSE333: Arrays

**Arrays** in C are contiguous chunks of memory. They are not objects, do not know their own length, and do not support bounds checking.

## Definition and Initialization

- **Syntax**: `type name[size]`
- **Contiguous Memory**: Allocates `size * sizeof(type)` bytes in a single block.
- **Garbage Values**: Initially, array values are uninitialized ("garbage") unless statically allocated.
- **Initialization**: Can only be used at the time of definition.
  - `int primes[6] = {2, 3, 5, 7, 11, 13};`
  - If no size is supplied, it is inferred from the initializer: `int primes[] = {2, 3, 5};`

## Array Names vs. Pointers

An array name evaluates to the address of the start of the array, making it interchangeable with a pointer in many contexts.

- It acts like a **constant pointer** to the first element; it cannot be reassigned to point elsewhere.
- **Promotion**: When passed to a function, an array "decays" to a pointer to its first element (`type*`). The size information is lost, which is why a separate size parameter is necessary.

## Multi-dimensional Arrays

Multi-dimensional arrays are stored in **row-major order** as a single contiguous chunk of memory. The elements of row 0 come first, followed by row 1, and so on.

- **Syntax**: `type name[rows][cols]`
- Normally only useful if sizes are known at compile-time.

## Arrays as Parameters

Because arrays do not know their own size, it is a standard C idiom to pass the size as a separate parameter.

- **Incorrect**: Returning a local array allocated on the stack — the stack frame is reclaimed when the function returns, leaving a dangling pointer.
- **Correct (Output Parameter)**: Pass a pointer to a buffer allocated by the caller so the caller controls the lifetime.

```c
void copyArray(int src[], int dst[], int size) {
    for (int i = 0; i < size; i++) {
        dst[i] = src[i];
    }
}
```

## Related

- [[Systems Programming/C Fundamentals/Pointers|Pointers]]
- [[Systems Programming/Memory Management/Stack|Stack]]
- [[Introduction to C|Introduction to C]]
- [[Types and Modifiers|Types and Modifiers]]

## Industry Standard Terms

- **Array decay** — The implicit conversion of an array name to a pointer to its first element when passed to a function
- **Row-major order** — The standard memory layout for multi-dimensional arrays in C; Fortran uses column-major order
- **Buffer** — A generic term for an array used to hold data temporarily during I/O or processing
