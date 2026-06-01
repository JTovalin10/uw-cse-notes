# Course: Memory Hierarchy and Coherence

In multi-core systems, the memory hierarchy must not only be fast and large but also **Coherent**, ensuring that all cores see a consistent view of data.

## Cache Coherence
The problem: Core 1 reads $X=0$. Core 2 writes $X=1$. Core 1 still has $X=0$ in its cache.

### Snooping Protocols
Caches "snoop" on a shared bus to watch for memory operations from other cores.
- **MSI Protocol**:
    - **Modified**: This cache has the only valid copy and has modified it.
    - **Shared**: Multiple caches may have valid, unmodified copies.
    - **Invalid**: This cache line is not valid.
- **MESI Protocol**: Adds **Exclusive** state (valid, unmodified, only one copy) to reduce bus traffic on the first write.

### Directory-Based Protocols
Used for larger systems where a shared bus is a bottleneck. A "Directory" tracks which cores have copies of which blocks.

## Multi-Porting and Bandwidth
Wide-issue processors (e.g., 4-8 wide) need more than one memory access per cycle.
- **Multi-porting**: Physically adding more ports to the cache SRAM. Expensive ($O(N^2)$ area).
- **Replication**: Creating multiple copies of the cache. Easy for reads, but writes must go to all copies.
- **Banking**: Splitting the cache into independent banks. Works well if addresses are distributed, but stalls on bank conflicts.

## Advanced Cache Optimization
- **Non-blocking Caches**: Allow the CPU to continue executing other instructions while a cache miss is being handled (**Hit Under Miss**, **Miss Under Miss**).
- **Prefetching**: Hardware or software predicts future accesses and loads them into the cache early.

## Related
- [[Memory Hierarchy and Caches|CSE469: Memory Hierarchy and Caches]]
- [[Dynamic Scheduling and OoO|Dynamic Scheduling and OoO]]
