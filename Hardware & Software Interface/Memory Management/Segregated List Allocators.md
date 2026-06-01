# CSE351: Segregated List Allocators

A **segregated list allocator** maintains a separate free list for each **size class** of blocks, organized as an array of free lists. This avoids the cost of scanning a single large free list for appropriately sized blocks.

## Size Classes

- **Small sizes** typically get their own individual size class (e.g., one class per exact block size).
- **Larger sizes** are grouped into power-of-two size classes (e.g., one class for 64–127 bytes, one for 128–255 bytes, etc.), following a geometric progression to bound the number of lists.

## Allocation

1. Determine the size class for the requested block size.
2. Search the corresponding free list for a large enough block.
3. If none is found in that size class, try the **next larger** size class.
4. If the heap is exhausted, request more memory from the OS (`sbrk`).

## Freeing

1. Mark the block as free.
2. Coalesce with neighboring free blocks if needed (see [[Explicit Allocation Implementation|Explicit Allocation Implementation]]).
3. Insert the block into the appropriate size-class free list.

## Advantages

| Benefit | Explanation |
|:---|:---|
| **Higher throughput** | Searching a size class is O(log n) for power-of-two classes vs. O(n) for a single list |
| **Better utilization** | A First-Fit search within a size class closely approximates a Best-Fit search over the entire heap, because all blocks in the list are approximately the right size |
| **Less metadata overhead** | In the extreme case where each size class holds exactly one block size, the header does not need to store size at all |

In the limit — giving every possible block size its own size class — performance is no worse than Best-Fit search over a single explicit free list, and throughput is significantly better.

---

```mermaid
flowchart LR
    A["malloc(size) request"] --> B["Determine size class"]
    B --> C["Search size class free list"]
    C -->|"Found"| D["Remove block; mark allocated; return"]
    C -->|"Not found"| E["Try next larger size class"]
    E -->|"Found"| D
    E -->|"Exhausted all classes"| F["sbrk: extend heap"]
    F --> D
```

---

## Related

- [[Memory Allocation|Memory Allocation]]
- [[Explicit Allocation Implementation|Explicit Allocation Implementation]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|:---|:---|
| Segregated list allocator | Segregated free list; size-segregated storage |
| Size class | Size class; size bin |
| Power-of-two size classes | Geometric size classes; buddy system size classes |
| Best-Fit approximation | Approximate Best-Fit; segregated fit |
| `jemalloc`, `tcmalloc` | Production allocators that use segregated lists internally |
