# CSE333: Malloc and Free

Dynamic memory in C is managed using functions from `<stdlib.h>`. These functions request memory from the heap allocator, which in turn may request pages from the OS.

## Allocation Functions

- **`malloc()`**: `void* malloc(size_t size)`
  - Allocates a block of `size` bytes on the heap.
  - Returns a pointer to the first byte, or `NULL` if allocation fails (e.g., out of memory).
  - Memory is **uninitialized** (contains garbage values from previous use).
- **`calloc()`**: `void* calloc(size_t num, size_t size)`
  - Allocates memory for an array of `num` elements, each `size` bytes.
  - **Zeros out** the allocated memory before returning it — useful when a clean slate is required.

## Deallocation

- **`free()`**: `void free(void* ptr)`
  - Releases the memory block pointed to by `ptr`, returning it to the heap allocator's free list.
  - `ptr` **must** point to the start of a block previously returned by `malloc` or `calloc`. Passing a pointer into the middle of a block is undefined behavior.
  - Calling `free` on the same pointer twice (**double-free**) is a serious error — it corrupts the allocator's internal state and can be exploited as a security vulnerability.
  - After `free(ptr)`, the pointer `ptr` still holds the old address; it becomes a **dangling pointer**. Good practice is to set it to `NULL` immediately after: `ptr = NULL;`.

## Best Practices

- Always check if the return value of `malloc` or `calloc` is `NULL`.
- Use `sizeof()` to calculate sizes: `int* arr = (int*)malloc(10 * sizeof(int));` — this is portable across architectures.
- Ensure every `malloc` has a corresponding `free`. Tracking ownership is critical.

## Related

- [[CSE333/Memory Management/Heap Management|Heap Management]]
- [[CSE333/Memory Management/Memory Bugs and Valgrind|Memory Bugs and Valgrind]]
- [[CSE333/Memory Management/C Memory Model|C Memory Model]]
- [[Memory Allocation|Memory Allocation (CSE351)]]
- [[CSE451/Virtualization/Memory/Memory management|OS Memory Management (CSE451)]]

## Industry Standard Terms

- **`malloc` / `free`** — The standard C dynamic memory API; in C++, replaced by `new` / `delete` for objects, which additionally call constructors and destructors
- **Heap corruption** — A class of memory bug caused by writing out of bounds, double-freeing, or freeing unallocated memory; can be detected with AddressSanitizer (`-fsanitize=address`)
- **Dangling pointer** — A pointer that references freed memory; accessing it is undefined behavior and a common source of security vulnerabilities (use-after-free)
