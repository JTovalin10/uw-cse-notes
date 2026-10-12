# Concurrency, Parallelism, and Rust: Writing Multithreaded Code

Writing correct multithreaded programs requires coordinating concurrent execution across preemptive OS scheduling intervals, eliminating data races through coarse- or fine-grained synchronization primitives, and enforcing memory consistency across compiler and CPU instruction reordering.

## Topics

- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Nondeterminism and Synchronization Paradigms|Nondeterminism and Synchronization Paradigms]] — Preemptive scheduling and coarse vs fine granularity
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Data Races and Interleavings|Data Races and Interleavings]] — Race conditions, combinatorial explosion, and formal conditions
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Barriers|Barriers]] — Coarse-grained synchronization
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Mutual Exclusion Locks|Mutual Exclusion Locks]] — Fine-grained synchronization, hazards, and alternatives
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Memory Reordering and Fences|Memory Reordering and Fences]] — Compiler and hardware reordering
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Bank Account Traces|Bank Account Traces]] — Unsynchronized, mutex, and barrier executions
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Deadlock, double-locking, stragglers, and flag signaling (beyond lecture)
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Deep Dive|Deep Dive]] — x86-64 TSO vs ARM memory models (beyond lecture)

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hardware processors vs virtual cores, thread abstraction, preemptive scheduling, and cache coherence
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Task vs data parallelism, Amdahl's law, and dependency dataflow DAGs
- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Cooperative multitasking vs preemptive threads and CSP rendezvous channels
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — Assembly context switching and channel queue mechanics
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Locks/Locks|Operating Systems: Locks]] — Hardware atomic instructions (`test_and_set`, `compare_and_swap`) and OS sleep locks
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Race Conditions/Race Condition|Operating Systems: Race Conditions]] — Operating system race conditions and scheduling interleavings
- [[Operating Systems/Concurrency/Problems/Deadlocks|Operating Systems: Deadlocks]] — Coffman deadlock conditions, resource allocation graphs, and avoidance
