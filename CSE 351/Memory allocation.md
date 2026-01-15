
## Table of Contents

1. [Heap Fragmentation](#heap-fragmentation)
2. [Allocation Strategies](#allocation-strategies)
3. [Block Allocation Process](#block-allocation-process)
4. [Memory Alignment and Minimum Block Size](#memory-alignment-and-minimum-block-size)
5. [Block Deallocation and Coalescing](#block-deallocation-and-coalescing)
6. [Explicit Free Lists](#explicit-free-lists)

---

## Heap Fragmentation

Poor memory utilization in the heap is caused by **fragmentation** - parts of the heap not currently used to store program data. Like structs, there are two types of fragmentation.

### Internal Fragmentation

**Definition**: "Wasted" space inside allocated heap blocks that is not part of the payload.

#### Sources

- **Heap data structures**: Allocator bookkeeping information (headers, footers)
- **Alignment padding**: Space added to meet alignment requirements
- **Metadata overhead**: Required for allocator to manage blocks

#### Key Concept: Payload vs. Block Size

- **Payload**: The requested space (size parameter in `malloc(size)`)
- **Block Size**: Always greater than payload due to metadata and alignment
- **Internal Fragmentation** = Block Size - Payload

### External Fragmentation

**Definition**: Unused space between allocated blocks (holes in the heap).

#### Important Notes

- Does **not** include free space past the end of the last allocated block
- Caused by specific patterns of allocation and deallocation requests
- Can prevent allocation requests despite sufficient aggregate free memory

#### Example Problem

```
Heap State: [Allocated][16B Free][Allocated][24B Free][Allocated][32B Free Space]
```

- Total free space: 40 bytes external fragmentation + 32 bytes at end = 72 bytes
- Request for 48 bytes: **Cannot be fulfilled** despite having 72 bytes free
- Only 40 bytes of external fragmentation (the 32 bytes at end don't count)

---

## Allocation Strategies

Three basic strategies for finding suitable free blocks during allocation:

### First Fit

- **Method**: Search from beginning of heap
- **Selection**: Return first free block large enough
- **Advantages**: Fast for small heaps
- **Disadvantages**: Can cause fragmentation at beginning of heap

### Next Fit

- **Method**: Search starting from where last search finished
- **Selection**: Return first free block large enough (wraps around at heap end)
- **Advantages**: Distributes allocations more evenly
- **Disadvantages**: Can lose track of large free blocks

### Best Fit

- **Method**: Search entire heap
- **Selection**: Return free block that minimizes external fragmentation
- **Tie-breaking**: Use lowest address or other consistent rule
- **Advantages**: Better memory utilization
- **Disadvantages**: Slower search time

### Performance Trade-offs

**Speed vs. Utilization**: Faster strategies tend to have worse fragmentation, and vice versa.

### Example Comparison

```
Heap: [B1][Free 16B][B3][Free 8B][B5][Free 24B]
Request: malloc(8)
Last allocation: B5
```

- **First Fit**: Allocates in 16B space after B1
- **Next Fit**: Allocates in 24B space after B5
- **Best Fit**: Allocates in 8B space after B3 (perfect fit)

---

## Block Allocation Process

### Step-by-Step Allocation

1. **Compute Block Size**
    
    - Add payload + metadata + alignment padding
    - Ensure meets minimum block size
2. **Search for Free Block**
    
    - Use chosen allocation strategy
    - If not found, return NULL
3. **Handle Block Splitting**
    
    - If chosen block > necessary size, split excess
    - Convert excess into new free block
    - Only split if remaining space ≥ minimum block size
4. **Allocate and Return**
    
    - Mark block as allocated
    - Return address of payload start

### Block Splitting Example

```
Request: malloc(24) with 8-byte headers, 16-byte alignment
Necessary block size: 32 bytes (24 payload + 8 header)
Found free block: 48 bytes

Split: [32B Allocated][16B Free]
```

---

## Memory Alignment and Minimum Block Size

### Alignment Requirements

#### Two Alignment Rules

1. **Payload address** must be multiple of alignment size
2. **Total block size** must be multiple of alignment size

### Minimum Block Size Calculation

The minimum block size accommodates the larger requirements between allocated and free blocks.

#### Example: Implicit Free List

- **Alignment**: 16 bytes
- **Headers**: 8 bytes each
- **Minimum block size**: 16 bytes (fits header + 8-byte payload)

#### Example: With Boundary Tags

- **Alignment**: 16 bytes
- **Boundary tags**: 8 bytes each (header + footer = 16 bytes)
- **Minimum block size**: 32 bytes (16 bytes metadata + padding to alignment)

### Splitting Constraints

**Rule**: Only split if remaining space ≥ minimum block size

#### Example: malloc(1) with 16-byte minimum

```
Free block: 48 bytes
Computed need: 16 bytes (minimum, not 9 bytes)
Result: [16B Allocated][32B Free]
Header: 16|1 (size 16, allocated)
```

---

## Block Deallocation and Coalescing

### Simple Deallocation Problem

**Issue**: Simply flipping the allocated flag can create unusable fragmented free space.

```
Before: [Free 24B][Allocated 24B][Free 24B]
After free(): [Free 24B][Free 24B][Free 24B]
Problem: Three 24B blocks can't satisfy a 40B request!
```

### Coalescing Solution

**Coalescing**: Combining neighboring free blocks into single, larger free block.

#### Forward Coalescing

- Use current block's size to find next block's header
- Check if next block is free
- If free, combine by adding sizes

### Boundary Tags (Headers + Footers)

**Problem**: No way to find previous block for backward coalescing

**Solution**: Add footers (copy of header at end of each block)

#### Boundary Tag Benefits

- Enables backward coalescing
- Allows reverse heap traversal
- Provides bidirectional navigation

### Coalescing Scenarios

Four cases when freeing a block:

|Case|Previous Block|Next Block|Action|
|---|---|---|---|
|1|Allocated|Allocated|No coalescing|
|2|Allocated|Free|Forward coalescing|
|3|Free|Allocated|Backward coalescing|
|4|Free|Free|Bidirectional coalescing|

### Memory Access Example: Case 3 (Backward Coalescing)

Required memory accesses:

1. **Read** current block's header (get size)
2. **Read** following block's header (check if allocated)
3. **Read** preceding block's footer (check if free, get size)
4. **Write** preceding block's header (update with coalesced size)
5. **Write** current block's footer (update with coalesced size)

**Total**: 3 reads + 2 writes = 5 memory accesses

#### Key Insight

Previous metadata becomes "random data" within the coalesced block and doesn't need to be erased.

---

## Explicit Free Lists

### Concept

**Explicit free list**: Uses doubly-linked list to traverse only free blocks instead of all blocks.

### Implementation

- Add `next` and `prev` pointers **only** in free blocks
- Pointers stored in space previously used by payload
- Only check free blocks during allocation (faster search)

### Advantages

- **Speed**: Skip allocated blocks during search
- **Space efficiency**: Reuse payload space for pointers
- **Targeted search**: Only examine blocks that could satisfy request

### Complexity Considerations

- **Pointer manipulation**: More complex than implicit lists
- **Two types of neighbors**:
    - **Linked list neighbors**: next/prev pointers
    - **Physical neighbors**: preceding/following in memory
- **Coalescing complexity**: Must update both physical and logical structures

### Structure Comparison

#### Implicit Free List

```
[Header][Payload/Free Space][Footer] → Next block physically
```

#### Explicit Free List

```
[Header][Next*][Prev*][Free Space][Footer] → Next free block logically
                                           → Next block physically
```

### Key Relationships

- **Physical neighbors**: Used for coalescing operations
- **Logical neighbors**: Used for free block search and allocation
- **Maintenance**: Must update both relationships during allocation/deallocation

---

## Summary

### Key Concepts

1. **Fragmentation** reduces memory utilization through internal and external waste
2. **Allocation strategies** trade speed for memory efficiency
3. **Alignment and minimum block size** ensure proper memory access and allocator functionality
4. **Coalescing** prevents external fragmentation by combining adjacent free blocks
5. **Explicit free lists** optimize allocation speed by tracking only available blocks

### Performance Considerations

- **Internal fragmentation**: Minimized by efficient metadata design
- **External fragmentation**: Reduced by coalescing and smart allocation strategies
- **Search time**: Improved by explicit free lists and appropriate allocation strategies
- **Memory overhead**: Balanced between metadata size and functionality