# CSE351: Segregated List Allocators

A **segregated list allocator** maintains a separate free list for each **size class** of blocks, organized as an array of free lists.

## Size Classes

- Small sizes typically get their own individual size class (e.g., one class per block size).
- Larger sizes are grouped into power-of-two size classes (e.g., one class for 64–127 bytes, one for 128–255 bytes, etc.).

## Allocation

1. Determine the size class for the requested block size.
2. Search the corresponding free list for a large enough block.
3. If none found, try the next larger size class.
4. If the heap is exhausted, request more memory from the OS.

## Freeing

1. Mark the block as free.
2. Coalesce with neighbors if needed.
3. Insert the block into the appropriate size-class free list.

## Advantages

| Benefit | Explanation |
|:---|:---|
| **Higher throughput** | Searching a size class is O(log n) for power-of-two classes |
| **Better utilization** | First-fit search of a segregated list approximates best-fit search of the entire heap |
| **Less metadata overhead** | Fixed-size classes don't need to store the block size in the header |

In the extreme case, giving every possible block size its own size class performs no worse than best-fit search over an explicit free list.

## Related
- [[CSE351/Memory Management/Memory Allocation|Memory Allocation]]
- [[CSE351/Memory Management/Explicit Allocation Implementation|Explicit Allocation Implementation]]
