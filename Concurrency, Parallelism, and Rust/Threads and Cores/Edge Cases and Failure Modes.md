# Threads and Cores: Edge Cases and Failure Modes

## Edge Cases, Failure Modes & Mitigations

### 1. Data Races on Non-Atomic Shared Variables
- **Failure Mode**: Multiple threads concurrently read and write to shared memory without synchronization, producing corrupted state or lost updates.
- **Mitigation**: Enforce mutual exclusion using mutexes, locks, or atomic primitives (`std::sync::atomic`).

### 2. Severe Cache Line Bouncing (False Sharing)
- **Failure Mode**: High throughput algorithms experience drastic performance degradation despite perfect task independence due to false sharing on shared 64-byte cache lines.
- **Mitigation**: Apply structure padding (`repr(align(64))` or `hardware_destructive_interference_size`) to separate active worker fields.

### 3. SMT Execution Unit Contention
- **Failure Mode**: Compute-heavy parallel workloads scale poorly when scheduled across hyperthreaded logical cores on the same physical CPU.
- **Mitigation**: Bind latency-critical threads to dedicated physical cores using CPU affinity masks (`pthread_setaffinity_np`).

### 4. Memory Reordering Violations Across Cores
- **Failure Mode**: One core observes memory writes from another core in an unexpected order, causing lock-free data structures to read stale or uninitialized pointers.
- **Mitigation**: Insert memory barrier instructions or use atomic memory orderings (`Acquire`, `Release`, `SeqCst`).

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Non-Deterministic Interleaving Invariant|Non-Deterministic Interleaving Invariant]] — Formal definition and intuition
