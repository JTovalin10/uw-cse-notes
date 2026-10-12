# Decomposition: Edge Cases and Performance Hazards

## Edge Cases, Failure Modes & Performance Hazards

1. **The Straggler Problem & Worker Imbalance**:
   - In domain decomposition with barrier synchronization, the completion time of a parallel phase is bounded by $\max_i(T_{\text{worker } i})$. A single slow worker holding a long-running subproblem forces all other workers to stall at the barrier.
   - *Mitigation*: Dynamically distribute work using fine-grained task strips or apply work-stealing schedulers.
2. **Shared Task Queue Contention**:
   - In dynamic allocation, if thousands of fine-grained tasks are managed by a single centralized work queue guarded by a mutual exclusion lock, worker threads spend more time contending for the lock than computing.
   - *Mitigation*: Use per-worker local task queues with work-stealing (workers push and pop locally, only acquiring locks when stealing from other queues).
3. **Cache Invalidation & False Sharing**:
   - In cyclic domain decomposition, if workers are assigned adjacent items that fall within the same 64-byte hardware cache line, the CPU cache coherence protocol (e.g., MESI) continuously invalidates and ping-pongs the cache line between core caches, destroying performance.
   - *Mitigation*: Ensure minimum partition chunk sizes are aligned with or exceed cache line boundaries (typically 64 bytes).
4. **Pipeline Backpressure & Buffer Starvation**:
   - In functional decomposition, if queues between stages are unbounded, an upstream worker running faster than a downstream worker will flood system memory with unconsumed intermediate data. Conversely, if queues are bounded, upstream workers block as soon as buffers fill.
   - *Mitigation*: Implement bounded channels with tuned capacities and scale worker counts for the bottleneck stage (e.g., allocating multiple workers to stage 3 via internal domain decomposition).
5. **Granularity Collapse**:
   - If tasks are made too fine-grained, thread creation and dispatch overhead dominate computation ($G \ll 1$), resulting in negative speedup (the parallel program runs significantly slower than the serial version).

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Decomposition/Scaling Laws|Scaling Laws]] — Amdahl, Gustafson, granularity metric, and baseline invariant
- [[Concurrency, Parallelism, and Rust/Decomposition/Deep Dive|Deep Dive]] — Work stealing and the roofline model (beyond lecture)
