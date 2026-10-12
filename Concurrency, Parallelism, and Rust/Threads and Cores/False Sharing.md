# Threads and Cores: False Sharing

## False Sharing
**False Sharing** occurs when two distinct threads executing on separate physical cores modify independent variables that reside within the **same hardware cache line** (typically 64 bytes).

```
Cache Line (64 Bytes)
+----------------------------------+----------------------------------+
| Variable A (Modified by Core 0)  | Variable B (Modified by Core 1)  |
+----------------------------------+----------------------------------+
```

### Invalidation Mechanics
1. **Core 0** writes to `Variable A`. The MESI cache coherence protocol marks the entire 64-byte cache line in **Core 1's** L1 cache as **Invalid**.
2. **Core 1** attempts to write to `Variable B`. Because the line is Invalid, Core 1 suffers a cache miss, stalls execution, and broadcasts an invalidation request to Core 0.
3. The cache line continuously bounces back and forth between Core 0 and Core 1 ("cache line bouncing"), degrading performance by orders of magnitude even though no logical data race exists.

### Mitigation: Cache Line Padding
Developers eliminate false sharing by padding data structures to ensure independent variables occupy separate cache lines:

```cpp
// C++17 Standard Cache Line Alignment
#include <new>

struct alignas(std::hardware_destructive_interference_size) ThreadWorker {
    uint64_t counter; // Isolated to its own 64-byte cache line
};
```

```rust
// Rust Cache Line Alignment Attribute
#[repr(align(64))]
struct ThreadWorker {
    counter: u64,
}
```

## Industry Standard Terms

| Course Term | Industry / Standard Term | Real-World Context / Production Equivalent |
| :--- | :--- | :--- |
| **Cache Line Padding** | Cache Line Alignment / Structure Padding | C++17 `hardware_destructive_interference_size`, Rust `#[repr(align(64))]` |

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Cache Topology and Scheduler Queues|Cache Topology and Scheduler Queues]] — Thread migration, core-local queues, and work stealing
- [[Concurrency, Parallelism, and Rust/Threads and Cores/SMT and Out-of-Order Execution|SMT and Out-of-Order Execution]] — Hyperthreading and memory barriers
