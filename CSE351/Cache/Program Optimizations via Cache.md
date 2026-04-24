# CSE351: Program Optimizations via Cache

## Strategies

Cache performance can be improved by:
- Adjusting memory access patterns to reduce miss rate (requires knowledge of cache parameters)
- Choosing cache-friendly algorithms
- Applying loop transformations

## Cache Images

A **cache image** is an aligned chunk of memory exactly the same size as the cache ($C$ bytes). Any such aligned region is guaranteed to fit entirely in the cache at once.

Key insight: two addresses with the **same offset within their respective cache images** map to the **same cache location**. This means:
- Contiguous blocks in memory map to contiguous cache sets.
- If $B = C/K$ is the number of blocks the cache can hold, an aligned $C$-byte chunk all fits in the cache simultaneously.

Cache images help you quickly predict where in the cache a given address will land, which is useful for diagnosing conflict misses.

## Optimization Guidelines

| Goal | Technique |
|:---|:---|
| Temporal locality | Keep the working set small; reuse data before eviction |
| Spatial locality | Access memory in small strides; prefer arrays over linked lists |
| Nested loops | Focus optimizations on the innermost loop body |
| 2D arrays | Use **cache blocking** (tiling) so sub-matrices fit in the cache |

## Data Structure Choices

| Layout | Cache Behavior |
|:---|:---|
| Array | Contiguous in memory; excellent spatial locality |
| Linked list | Non-contiguous; pointer-chasing causes many cache misses |

Note: optimal cache performance is platform-specific since it depends on cache size, block size, and associativity.

## Related
- [[CSE351/Cache/Cache Locality|Locality]]
- [[CSE351/Cache/Cache Organization|Cache Organization]]
- [[CSE351/Data Structures/Arrays|Arrays]]
