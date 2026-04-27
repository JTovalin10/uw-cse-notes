# Thread-Local Allocation Buffers (TLABs)

**Thread-Local Allocation Buffers (TLABs)** are an optimization technique used in high-performance, multi-threaded memory allocators (e.g., JVM's HotSpot, Go runtime, Jemalloc) to minimize synchronization overhead during heap allocation.

## The Core Problem: Lock Contention
In a multi-threaded process, the **Heap** is a shared resource. If every thread attempts to allocate memory by requesting it from a global allocator, they must acquire a **global lock** to prevent race conditions (e.g., two threads being given the same memory address). In systems with high allocation rates, this lock becomes a major bottleneck, killing scalability.

## The TLAB Solution
Instead of allocating individual objects from the global heap, each thread is pre-assigned a larger, private chunk of memory called a **TLAB**.

### Allocation Mechanism
1. **Pointer Bumping**: Within its private TLAB, a thread allocates memory by simply moving a "top" pointer forward by the object size. This is a single instruction and requires **no locks or atomic operations**.
2. **Refill**: Once a thread's TLAB is exhausted, it goes back to the global allocator to request a new TLAB chunk. This operation *does* require a lock, but it happens much less frequently (e.g., once every 1000 allocations).

## Key Characteristics
- **Thread Safety**: Since a TLAB is only accessible by its owner thread, internal allocations are inherently thread-safe.
- **Efficiency**: TLAB allocation is as fast as stack allocation (pointer increment).
- **Sizing**: TLABs are typically sized dynamically based on the thread's allocation behavior. If a TLAB is too small, the thread will contend on the global lock too often; if too large, it may cause fragmentation or excessive memory usage.

## Trade-offs
- **Fragmentation**: If a thread dies or stops allocating, the remaining space in its current TLAB may be wasted unless the allocator has a mechanism to reclaim it.
- **Large Objects**: Very large objects that exceed the TLAB size are usually allocated directly from the global heap or a specialized "Large Object Space" to avoid wasting TLAB space.

---
**See Also**: [[CSE451/Memory Management/Concepts/Slab Allocation|Slab Allocation]], [[Heap Management]]
