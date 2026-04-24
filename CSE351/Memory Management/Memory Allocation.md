# CSE351: Memory Allocation

## Ways to Store Program Data

| Type | Size Known At | Lifetime |
|:---|:---|:---|
| **Static / global** | Compile time | Entire program; a portion is read-only (string literals) |
| **Stack-allocated** | Compile time (mostly) | Deallocated automatically when the function returns |
| **Dynamic (heap)** | Runtime | Controlled entirely by the programmer |

## Dynamic Memory Allocation

Programmers use **dynamic memory allocators** to acquire heap memory at runtime — for data whose size or lifetime is only known when the program runs. The heap segment grows as needed; when it runs out, the allocator requests more from the OS via `sbrk` (Unix).

Two kinds of allocators:
- **Implicit** (garbage-collected): the programmer only allocates; the runtime frees (e.g., `new` in Java).
- **Explicit**: the programmer both allocates and frees (e.g., `malloc` / `free` in C).

## malloc / free API

```c
#include <stdlib.h>

void* malloc(size_t size);  // allocate `size` uninitialized bytes
void  free(void* p);        // release block previously returned by malloc
```

- `malloc` returns a pointer to the start of the block, or `NULL` on failure or if `size == 0`. Blocks are typically aligned to 8 or 16 bytes.
- `free` must receive the exact pointer originally returned by `malloc`. Calling `free` on an already-freed block is undefined behavior (can introduce vulnerabilities). `free(NULL)` is a no-op.

### Best Practices

```c
int* ptr = (int*) malloc(n * sizeof(int));  // sizeof makes code portable
free(ptr);
ptr = NULL;  // set to NULL after freeing to prevent double-free
```

### Allocator Interface Constraints

Applications must:
- Never access memory outside a currently allocated block.
- Only call `free` with a pointer previously returned by `malloc`.

Allocators must:
- Respond immediately to every `malloc` call.
- Only allocate blocks from currently free memory.
- Align blocks to satisfy all alignment requirements.
- Never move allocated blocks.

### Common Bug: Pointer Drift

```c
int* p = (int*) malloc(N * sizeof(int));
for (int i = 0; i < N; i++) {
    *p = i;
    p++;         // p no longer points to the original block
}
free(p);         // ERROR: freeing wrong address
```

---

## Heap Fragmentation

Poor memory utilization caused by **fragmentation** — parts of the heap not storing useful payload.

### Internal Fragmentation

Wasted space **inside** allocated blocks: `Block Size − Payload`. Sources include headers/footers, alignment padding, and policy decisions that return an oversized block.

### External Fragmentation

Unused space **between** allocated blocks. Occurs when allocation/free patterns leave holes such that there is enough aggregate free memory to satisfy a request, but no single free block is large enough.

---

## Allocation Strategies

| Strategy | Behavior | Trade-off |
|:---|:---|:---|
| **First Fit** | Search from the beginning; return the first large-enough block | Fast; tends to fragment the start of the heap |
| **Next Fit** | Search from where the last search ended; wrap around | More even distribution; worse fragmentation |
| **Best Fit** | Search the entire heap; return the block with fewest bytes left over | Better utilization; slower |

---

## Block Allocation Process

1. Compute required block size: payload + metadata + alignment padding.
2. Search for a free block using the chosen strategy.
3. **Split** the block if it is significantly larger than needed (remainder must be ≥ minimum block size).
4. Mark the block as allocated and return the payload address.

---

## Alignment Requirements

1. The payload address must be a multiple of the alignment size.
2. The total block size must be a multiple of the alignment size.

### Minimum Block Size

Minimum size must accommodate the larger of the allocated and free block requirements.

Example with 16-byte alignment:
- Headers only: 16 bytes minimum
- With boundary tags (header + footer): 32 bytes minimum

---

## Coalescing

**Coalescing** combines neighboring free blocks into a single larger block to prevent **false fragmentation** — where many small adjacent free blocks cannot individually satisfy larger requests.

| Case | Previous Block | Next Block | Action |
|:---|:---|:---|:---|
| 1 | Allocated | Allocated | No coalescing |
| 2 | Allocated | Free | Forward coalescing |
| 3 | Free | Allocated | Backward coalescing |
| 4 | Free | Free | Bidirectional coalescing |

---

## Boundary Tags (Headers + Footers)

**Problem**: No efficient way to find the preceding block for backward coalescing.

**Solution**: Add a **footer** (copy of the header) at the end of every block. This enables reverse heap traversal and bidirectional coalescing.

---

## Free List Structures

### Implicit Free List
Traverse the entire heap using pointer arithmetic to find free blocks. Saves memory but finding a free block is O(n).

### Explicit Free List
A doubly-linked list threading **only** the free blocks. Pointers are stored in the payload area (since free blocks aren't storing payload). Faster search but requires more minimum block size.

For full implementation details — header format, splitting, coalescing code, insertion policies, block size requirements — see [[CSE351/Memory Management/Explicit Allocation Implementation|Explicit Allocation Implementation]].

### Segregated Free Lists
Multiple free lists, one per size class, for better throughput and utilization. See [[CSE351/Memory Management/Segregated List Allocators|Segregated List Allocators]].

---

## Related
- [[CSE351/Memory Management/Explicit Allocation Implementation|Explicit Allocation Implementation]]
- [[CSE351/Memory Management/Segregated List Allocators|Segregated List Allocators]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory (351)]]
- [[CSE351/Data Structures/Structs|Structs (including Alignment)]]
- [[CSE333/Memory Management/Malloc and Free|Malloc and Free (333)]]
- [[CSE333/Memory Management/Heap Management|Heap Management (333)]]
- [[CSE451/Memory Management/Memory management|OS Memory Management (451)]]
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout (484)]]
