# Temporal Locality

**Temporal Locality** is the tendency for a program to access the same memory location multiple times within a short period of time.

## Principle
If a memory location is referenced once, there is a high probability that it will be referenced again in the near future.

## In Cache Systems
Caching exploits temporal locality by keeping recently accessed data in the cache. When the same address is requested again soon after, it results in a cache hit, avoiding the need to fetch the data from slower main memory or disk.

## Examples
- **Loops**: In a `for` or `while` loop, the same instructions are executed repeatedly, and variables used for counting or as accumulators are accessed in every iteration.
- **Database Buffering**: When a database loads a block into its buffer pool, it expects that queries will likely need data from that same block again soon.

## Related
- [[CSE351/Cache/Cache Locality|Cache Locality]]
- [[CSE351/Cache/Spatial Locality|Spatial Locality]]
- [[CSE344/Database Design/Disk Storage|Disk Storage (Database context)]]
