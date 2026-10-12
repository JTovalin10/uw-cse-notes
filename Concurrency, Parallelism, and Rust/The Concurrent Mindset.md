# Concurrency, Parallelism, and Rust: Course Introduction — The Concurrent Mindset

This note introduces the foundational principles of concurrent and parallel execution, the hardware forces driving modern multicore architecture, and the formal dependency models used to decompose computation.

## Topics

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Course Overview and Hardware Drivers|Course Overview and Hardware Drivers]] — Rust, roadmap, and why concurrency and parallelism
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Assembly Line and Scaling Strategies|Assembly Line and Scaling Strategies]] — Task specialization, scale-up, and the pit stop case studies
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Dependency Chains and Dataflow Graphs|Dependency Chains and Dataflow Graphs]] — Dependency graphs and their formalization
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Pit Stop and Scheduling Traces|Pit Stop and Scheduling Traces]] — Concrete execution traces
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Edge Cases and Hazards|Edge Cases and Hazards]] — Scheduling complexity and concurrency hazards (beyond lecture)
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Deep Dive|Deep Dive]] — Dennard scaling, Amdahl, and Rust Send/Sync (beyond lecture)

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Domain and functional decomposition strategies, dynamic load balancing, task granularity, and scaling laws
- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Cooperative user-space multitasking, stack management, and assembly context switching
- [[CSE351 Index|CSE351: The Hardware/Software Interface]] — Physical memory hierarchies, caches, and multi-core processor architectures
- [[CSE333 Index|CSE333: Systems Programming]] — POSIX threads (`pthreads`), mutexes, and lower-level synchronization in C
- [[Concurrency Intro|CSE333: Concurrency Intro]] — Foundational POSIX threads and race conditions in C
- [[CSE451 Index|CSE451: Operating Systems]] — Kernel thread scheduling, context switching, and OS synchronization primitives
- [[Race Condition|CSE451: Race Conditions]] — Critical sections, mutual exclusion, and low-level synchronization anomalies
- [[Distributed Systems/Index|CSE452: Distributed Systems]] — Distributed concurrency, happens-before relations, and consensus protocols
- [[Logical Clocks|CSE452: Logical Clocks]] — Causal ordering and the formal happens-before relationship
