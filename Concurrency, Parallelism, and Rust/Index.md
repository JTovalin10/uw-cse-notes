# Concurrency, Parallelism, and Rust: Index

Course notes covering concurrency primitives, parallel decomposition, memory safety, and systems programming in C and Rust.

---

## Topics

### Foundations & Decomposition
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|Course Introduction — The Concurrent Mindset]] — Hardware drivers, multicore architectures, task vs data parallelism, and dependency dataflow DAGs
- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Domain decomposition, functional pipelining, dynamic load balancing, task granularity, and Amdahl's/Gustafson's scaling laws
- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hardware processors vs virtual cores, thread abstraction, preemptive scheduling, cache coherence, work stealing, false sharing, and SMT/hyperthreading

### Concurrency Primitives & Control Flow
- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Cooperative multitasking, user-space execution contexts, assembly stack switching (`routine_switch.S`), and CSP rendezvous channels
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — x86-64 stack frame layout, stack overflow protection, assembly context switching, and CSP channel mechanics
