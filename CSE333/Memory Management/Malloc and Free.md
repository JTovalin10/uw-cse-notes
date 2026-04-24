# CSE333: Malloc and Free

Dynamic memory in C is managed using functions from `<stdlib.h>`.

## Allocation Functions
- **malloc()**: `void* malloc(size_t size)`
  - Allocates a block of `size` bytes.
  - Returns a pointer to the first byte, or `NULL` if allocation fails.
  - Memory is **uninitialized** (contains garbage).
- **calloc()**: `void* calloc(size_t num, size_t size)`
  - Allocates memory for an array of `num` elements, each `size` bytes.
  - **Zeros out** the allocated memory.

## Deallocation
- **free()**: `void free(void* ptr)`
  - Releases the memory block pointed to by `ptr`.
  - `ptr` **must** point to the start of a block previously returned by `malloc` or `calloc`.
  - Calling `free` on the same pointer twice (**double-free**) is an error.
  - After `free(ptr)`, the pointer `ptr` is not changed; it becomes a **dangling pointer**. Good practice is to set it to `NULL` immediately after.

## Best Practices
- Always check if the return value is `NULL`.
- Use `sizeof()` to calculate sizes: `int* arr = (int*)malloc(10 * sizeof(int));`.
- Ensure every `malloc` has a corresponding `free`.

# Related
- [[Heap Management]]
- [[Memory Bugs and Valgrind]]
- [[CSE351/Memory Management/Memory Allocation|Memory Allocation (351)]]
- [[CSE451/Memory Management/Memory management|OS Memory Management (451)]]
