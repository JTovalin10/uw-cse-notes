# CSE351: Handling Writes

## Write-Hit Policies

A **write-hit** occurs when the data being written is already in the cache.

- **Write-through**: Immediately write to the next memory level (another cache level or main memory) on every write. Simple, but generates more memory traffic.
- **Write-back**: Defer writing to the next level until the cache line is evicted. Each line has a **dirty bit** that tracks whether it has been modified; on eviction, dirty lines are written back.

## Write-Miss Policies

A **write-miss** occurs when the block being written is not currently in the cache.

- **No-write-allocate** (write-around): Write directly to the next memory level without loading the block into the cache.
- **Write-allocate** (fetch-on-write): Load the block into the cache first, then apply the write.

## Common Policy Combinations

| Combination | Typical Use |
|:---|:---|
| **Write-back + write-allocate** | Most common; minimizes memory traffic |
| **Write-through + no-write-allocate** | L2 cache in multi-core systems, so other cores can access updates through a shared L3 |

## Related
- [[CSE351/Cache/Cache Organization|Cache Organization]]
- [[CSE351/Cache/Cache Associativity|Cache Associativity]]
- [[CSE351/Cache/Program Optimizations via Cache|Program Optimizations via Cache]]
