# Memory Allocation

**Related:** [[CSE484/Memory Exploits/Memory Layout]], [[CSE351/Memory Management/Virtual Memory]], [[Struct Alignment]]

---

## Heap Fragmentation

Poor memory utilization caused by **fragmentation** - parts of heap not storing program data.

### Internal Fragmentation

**Definition:** Wasted space inside allocated blocks not part of payload.

**Sources:**
- Heap data structures (headers, footers)
- Alignment padding
- Metadata overhead

**Key Formula:** Internal Fragmentation = Block Size - Payload

### External Fragmentation

**Definition:** Unused space between allocated blocks.

- Does **not** include free space past last allocated block
- Can prevent allocations despite sufficient total free memory

---

## Allocation Strategies

### First Fit
- Search from beginning
- Return first large enough block
- Fast but causes fragmentation at heap start

### Next Fit
- Search from last search position
- Wraps around at heap end
- Distributes allocations more evenly

### Best Fit
- Search entire heap
- Minimize external fragmentation
- Better utilization, slower search

**Trade-off:** Speed vs. Utilization

---

## Block Allocation Process

1. **Compute block size:** payload + metadata + alignment
2. **Search for free block** using chosen strategy
3. **Split block** if larger than necessary (if remainder ≥ minimum)
4. **Mark as allocated** and return payload address

---

## Alignment Requirements

1. **Payload address:** Multiple of alignment size
2. **Total block size:** Multiple of alignment size

---

## Minimum Block Size

Accommodates larger requirements between allocated and free blocks.

**Example with 16-byte alignment:**
- Headers only: 16 bytes minimum
- With boundary tags: 32 bytes minimum

---

## Coalescing

Combining neighboring free blocks into larger free blocks.

### Why Needed?
Simply freeing creates unusable fragmented space:
```
[Free 24B][Free 24B][Free 24B]
```
Three 24B blocks can't satisfy 40B request!

### Coalescing Scenarios

| Case | Previous | Next | Action |
|------|----------|------|--------|
| 1 | Allocated | Allocated | No coalescing |
| 2 | Allocated | Free | Forward coalescing |
| 3 | Free | Allocated | Backward coalescing |
| 4 | Free | Free | Bidirectional |

---

## Boundary Tags (Headers + Footers)

**Problem:** No way to find previous block for backward coalescing

**Solution:** Add footers (copy of header at end of each block)

**Benefits:**
- Enables backward coalescing
- Allows reverse heap traversal
- Bidirectional navigation

---

## Explicit Free Lists

Uses doubly-linked list to traverse **only free blocks**.

### Implementation
- Add `next` and `prev` pointers in free blocks only
- Pointers stored in payload space
- Skip allocated blocks during search

### Advantages
- **Speed:** Only examine free blocks
- **Space efficiency:** Reuse payload for pointers

**Related:** [[CSE333/Memory Management/Pointers]], [[CSE484/Memory Exploits/Memory Layout]]
