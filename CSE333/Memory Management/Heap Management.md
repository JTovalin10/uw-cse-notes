# CSE 333: Heap Management

The **Heap** is a large pool of memory used for data that needs to persist across multiple function calls or whose size is unknown at compile-time.

## Dynamic Allocation
Programmers explicitly request and release blocks of memory on the heap.
- **Manual Management**: Unlike Java, C has no garbage collector. The programmer is responsible for releasing memory.
- **Persistence**: Dynamically allocated memory lives until it is explicitly freed or the process exits.

## Why Use the Heap?
1. **Lifetime**: When data needs to outlive the function that created it.
2. **Size**: When the size of the data is determined at runtime (e.g., reading a file of unknown length).
3. **Capacity**: The heap is much larger than the stack.

Related: [[Malloc and Free]], [[Memory Bugs and Valgrind]]
