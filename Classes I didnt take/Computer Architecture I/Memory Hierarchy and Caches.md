# Course: Memory Hierarchy and Caches

Memory systems are organized into a hierarchy to exploit the **Principle of Locality**, providing the illusion of a memory that is as fast as the smallest level (L1 Cache) and as large as the largest level (Main Memory/Disk).

## Principle of Locality
- **Temporal Locality**: If an item is referenced, it will tend to be referenced again soon (e.g., loops, induction variables).
- **Spatial Locality**: If an item is referenced, items whose addresses are close by will tend to be referenced soon (e.g., array traversal, sequential code).

## Cache Organization & Lookup
A cache is divided into **Blocks** (or Lines). The size of a block is typically 32-64 bytes.

### Address Breakdown Calculation
For a 64-bit address and a cache with $S$ sets, $B$ bytes per block, and $W$ associativity:
- **Offset Bits**: $\log_2(B)$
- **Index Bits**: $\log_2(S)$
- **Tag Bits**: $64 - (\text{Index} + \text{Offset})$

**Example**: 4KB Direct-Mapped Cache with 32-byte blocks.
- Blocks = 4KB / 32B = 128.
- Offset = $\log_2(32) = 5$ bits.
- Index = $\log_2(128) = 7$ bits.
- Tag = $64 - (7 + 5) = 52$ bits.

### Mapping Strategies
- **Direct Mapped**: Each memory address maps to exactly one set ($W=1$). Simple, fast hit time, but high conflict misses.
- **N-way Set Associative**: $N$ blocks per set. Balance between hit time and miss rate.
- **Fully Associative**: Only one set containing all blocks. Lowest miss rate, but slow and expensive (requires parallel tag comparison).

## Write Policies
How the cache handles data modifications.

1.  **Write-Through**: Every write goes to both the cache and the next level of memory.
    - *Pro*: Simple, data is always consistent.
    - *Con*: Slow; requires a "Write Buffer" to avoid stalling on every write.
2.  **Write-Back**: Write only to the cache. Update main memory only when the block is evicted.
    - *Pro*: Faster; multiple writes to the same block only result in one write to memory.
    - *Con*: Complex; requires a **Dirty Bit** to track modified blocks.

**Handling Write Misses**:
- **Write-Allocate**: Fetch the block into the cache on a write miss (usually used with Write-Back).
- **No-Write-Allocate**: Write directly to the next level without loading into cache (usually used with Write-Through).

## The 3 C's (+1) of Cache Misses
1. **Compulsory**: First access to a block. Reduce by increasing block size (exploits spatial locality).
2. **Capacity**: Cache is full. Reduce by increasing cache size.
3. **Conflict**: Multiple blocks compete for the same set. Reduce by increasing associativity.
4. **(Coherency)**: Misses caused by other processors modifying data (in multi-core systems).

## Multilevel Caches
- **L1 Cache**: Small, very fast, integrated with the CPU pipeline. Split into L1I (instructions) and L1D (data).
- **L2/L3 Cache**: Larger, slower, shared among cores. Goal is to reduce the "Miss Penalty" of L1.

## Related
- [[Processor Performance|Processor Performance]]
- [[Operating Systems/Memory/Virtual Memory|CSE451: Virtual Memory]]
