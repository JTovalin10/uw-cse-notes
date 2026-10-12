# The Concurrent Mindset: Edge Cases and Hazards

## Edge Cases, Concurrency Hazards & Failure Modes

Parallel computing introduces major algorithmic and systems-level complexities that do not exist in sequential software.

### The $O(|V|!)$ Scheduling Complexity
- For a general dependency graph $G = (V, E)$, there are up to $O(|V|!)$ possible topological permutations for ordering vertices.
- Finding an optimal scheduling of DAG vertices onto a fixed number of physical processors while minimizing communication latency and memory footprint is an NP-hard problem.
- In practice, runtime schedulers rely on heuristics (such as work stealing) to dynamically allocate tasks.

### Concurrency Hazards in Systems Code
When concurrent tasks access shared state or execution resources, severe bugs can arise:

1. **Data Races**:
   - Occur when two or more instructions in different threads access the same memory location concurrently, at least one access is a write, and there is no synchronization (e.g., locks or atomics) ordering them.
   - Causes undefined behavior in C/C++; mathematically prevented at compile time by Rust's borrow checker.
2. **Race Conditions**:
   - Flaws in program logic where the correctness of output depends on the non-deterministic interleaving or timing of events. Even when all memory accesses are synchronized, high-level race conditions can still violate program invariants.
3. **Deadlocks**:
   - A situation where two or more threads are permanently blocked waiting for locks held by each other, forming a cyclic dependency graph of resources.
4. **False Cacheline Sharing**:
   - Occurs when two threads running on different cores modify independent variables that reside within the same 64-byte CPU cache line.
   - Even though the software logic is independent, the hardware cache coherence protocol (e.g., MESI/MOESI) invalidates and ping-pongs the cache line between core L1/L2 caches, causing dramatic performance degradation.
5. **Memory Management Bugs**:
   - In languages like C, concurrent allocation, deallocation, or pointer passing can easily result in use-after-free, double-free, and dangling pointers across thread boundaries.

## Related

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Pit Stop and Scheduling Traces|Pit Stop and Scheduling Traces]] — Concrete execution traces
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Deep Dive|Deep Dive]] — Dennard scaling, Amdahl, and Rust Send/Sync (beyond lecture)
