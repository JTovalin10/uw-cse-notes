# CSE351: Cache Associativity

Cache associativity determines where a specific block of memory can be placed within the cache.

## Direct-Mapped Cache
A **direct-mapped cache** uses a 1-to-1 mapping where each memory address maps to exactly one specific cache line.
- **Mechanism**: The target line is determined solely by the index bits; only that one line's tag needs to be compared.
- **Pros**: Simple and fast hardware implementation.
- **Cons**: Prone to conflict misses, as two addresses sharing the same index will constantly evict each other even if other cache lines are free.

## Fully Associative Cache
In a **fully associative cache**, a memory block can be placed in any cache line.
- **Mechanism**: The cache must compare the tag against all lines simultaneously (using parallel comparators).
- **Pros**: Eliminates conflict misses and provides maximum placement flexibility.
- **Cons**: Requires extensive hardware (parallel comparators), typically limiting its use to small caches like TLBs.

## N-Way Set Associative Cache
An **N-way set associative cache** is a middle ground where each memory address maps to one specific set, which contains N cache lines (ways).
- **Mechanism**: The cache checks all N ways within the matched set to find the data.
- **Pros**: Reduces conflict misses compared to direct-mapped caches without requiring hardware comparators for every single line in the cache.

## Related
- [[CSE351/Cache/Locality|Locality]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory]]
- [[CSE351/Memory Management/Translation Lookaside Buffer (TLB 351)|TLB]]
