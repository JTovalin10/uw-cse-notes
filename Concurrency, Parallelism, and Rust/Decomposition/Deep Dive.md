# Decomposition: Deep Dive

## Deep Dive

### Work-Stealing Scheduling: The Modern Dynamic Solution

To resolve the tension between fine-grained load balancing and communication overhead, modern parallel runtimes (such as Cilk, Go's runtime, and Rust's `rayon`) employ **work-stealing schedulers**:
- Instead of a single centralized work queue, each worker thread maintains its own private, lock-free double-ended queue (deque).
- **LIFO Local Execution**: When a worker generates new subtasks, it pushes them onto the **bottom** of its own deque. The worker pops tasks from the bottom, maximizing [[Hardware & Software Interface/Cache/Spatial Locality|temporal and spatial cache locality]] since recently pushed tasks are hot in cache.
- **FIFO Remote Stealing**: When a worker runs out of tasks, it randomly selects a peer worker and steals a task from the **top** of the victim's deque. Because older tasks at the top represent larger chunks of work (higher up in the recursive divide-and-conquer tree), steals transfer coarse-grained tasks, minimizing steal frequency and lock contention.

### Hardware Roofline Model & Arithmetic Intensity

The decomposition granularity $G = \frac{T_{\text{computation}}}{T_{\text{communication}}}$ maps directly to the hardware **Roofline Model**, which characterises algorithm throughput by **arithmetic intensity** (floating-point operations per byte transferred from memory):
- Domain decomposition on stencil algorithms (like image blurring) is frequently **memory-bandwidth bound** rather than compute-bound.
- When multiple cores contend for memory bus bandwidth while reading neighbor overlap regions, speedup saturates well before reaching Amdahl's theoretical limit. Structuring partitions to fit completely within CPU L1/L2 caches (cache blocking) is vital to preventing memory bus starvation.

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Decomposition/Edge Cases and Performance Hazards|Edge Cases and Performance Hazards]] — Performance pitfalls (beyond lecture)
