# Concurrency, Parallelism, and Rust: Threads and Cores

Hardware execution cores represent physical processing units capable of executing a single instruction stream, whereas threads provide a software-level execution abstraction—a "virtual core"—that decouples program logic from physical hardware boundaries, allowing concurrent workflows to be dynamically scheduled across available hardware resources.

## Topics

- [[Concurrency, Parallelism, and Rust/Threads and Cores/Cores vs Threads|Cores vs Threads]] — Abstraction need, nondeterministic speed, and threads vs coroutines
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Thread Memory Layout and Abstraction|Thread Memory Layout and Abstraction]] — Shared vs private state and the thread lifecycle
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Preemption and Time Quanta|Preemption and Time Quanta]] — Hardware timers and frequency trade-offs
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Programmer View vs Processor View|Programmer View vs Processor View]] — Interleaving traces
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Cache Topology and Scheduler Queues|Cache Topology and Scheduler Queues]] — Thread migration, core-local queues, and work stealing
- [[Concurrency, Parallelism, and Rust/Threads and Cores/False Sharing|False Sharing]] — Invalidation mechanics and cache line padding
- [[Concurrency, Parallelism, and Rust/Threads and Cores/SMT and Out-of-Order Execution|SMT and Out-of-Order Execution]] — Hyperthreading and memory barriers
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Non-Deterministic Interleaving Invariant|Non-Deterministic Interleaving Invariant]] — Formal definition and intuition
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Data races, line bouncing, SMT contention, reordering (beyond lecture)

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Contrast preemptive OS threads with cooperative user-space coroutines and execution stack switching
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Foundational hardware drivers, multicore architectures, and dataflow execution DAGs
- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Functional pipelining and domain decomposition strategies for balancing workload across cores
- [[Operating Systems/Concurrency/Threads/User vs Kernel Threads|User vs Kernel Threads]] — OS-level architectural details of thread management and kernel privilege boundary transitions
- [[Operating Systems/Processes/Process and Thread Fundamentals|Process and Thread Fundamentals]] — Process address space structure and thread context execution invariants
