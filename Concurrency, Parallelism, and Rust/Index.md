# Concurrency, Parallelism, and Rust: Index

Course notes covering concurrency primitives, parallel decomposition, memory safety, and systems programming in C and Rust.

---

## Topics

### Foundations & Decomposition
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|Course Introduction — The Concurrent Mindset]] — Hardware drivers, multicore architectures, task vs data parallelism, and dependency dataflow DAGs
  - [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Course Overview and Hardware Drivers|Course Overview and Hardware Drivers]] — Rust, roadmap, and why concurrency and parallelism
  - [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Assembly Line and Scaling Strategies|Assembly Line and Scaling Strategies]] — Task specialization, scale-up, and the pit stop case studies
  - [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Dependency Chains and Dataflow Graphs|Dependency Chains and Dataflow Graphs]] — Dependency graphs and their formalization
  - [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Pit Stop and Scheduling Traces|Pit Stop and Scheduling Traces]] — Concrete execution traces
  - [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Edge Cases and Hazards|Edge Cases and Hazards]] — Scheduling complexity and concurrency hazards (beyond lecture)
  - [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Deep Dive|Deep Dive]] — Dennard scaling, Amdahl, and Rust Send/Sync (beyond lecture)
- [[Concurrency, Parallelism, and Rust/Introduction to Rust|Introduction to Rust]] — Why Rust over C, categories of code, data races, mutable vs immutable references, ownership, and the stronger type system
- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Domain decomposition, functional pipelining, dynamic load balancing, task granularity, and Amdahl's/Gustafson's scaling laws
  - [[Concurrency, Parallelism, and Rust/Decomposition/Concurrency vs Parallelism and the Decomposition Mandate|Concurrency vs Parallelism and the Decomposition Mandate]] — Core distinction and why work must be decomposed
  - [[Concurrency, Parallelism, and Rust/Decomposition/Domain Decomposition|Domain Decomposition]] — Data partitioning with block and cyclic strategies
  - [[Concurrency, Parallelism, and Rust/Decomposition/Dynamic Allocation and Granularity|Dynamic Allocation and Granularity]] — Pull model, overhead, and task granularity
  - [[Concurrency, Parallelism, and Rust/Decomposition/Functional and Hybrid Decomposition|Functional and Hybrid Decomposition]] — Pipelines, bubbling, and hybrids
  - [[Concurrency, Parallelism, and Rust/Decomposition/Pipeline Execution Trace|Pipeline Execution Trace]] — Functional decomposition with bubbling
  - [[Concurrency, Parallelism, and Rust/Decomposition/Domain Partitioning Trace|Domain Partitioning Trace]] — Comparing partitioning schemes
  - [[Concurrency, Parallelism, and Rust/Decomposition/Scaling Laws|Scaling Laws]] — Amdahl, Gustafson, granularity metric, and baseline invariant
  - [[Concurrency, Parallelism, and Rust/Decomposition/Edge Cases and Performance Hazards|Edge Cases and Performance Hazards]] — Performance pitfalls (beyond lecture)
  - [[Concurrency, Parallelism, and Rust/Decomposition/Deep Dive|Deep Dive]] — Work stealing and the roofline model (beyond lecture)
- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hardware processors vs virtual cores, thread abstraction, preemptive scheduling, cache coherence, work stealing, false sharing, and SMT/hyperthreading
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/Cores vs Threads|Cores vs Threads]] — Abstraction need, nondeterministic speed, and threads vs coroutines
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/Thread Memory Layout and Abstraction|Thread Memory Layout and Abstraction]] — Shared vs private state and the thread lifecycle
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/Preemption and Time Quanta|Preemption and Time Quanta]] — Hardware timers and frequency trade-offs
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/Programmer View vs Processor View|Programmer View vs Processor View]] — Interleaving traces
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/Cache Topology and Scheduler Queues|Cache Topology and Scheduler Queues]] — Thread migration, core-local queues, and work stealing
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/False Sharing|False Sharing]] — Invalidation mechanics and cache line padding
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/SMT and Out-of-Order Execution|SMT and Out-of-Order Execution]] — Hyperthreading and memory barriers
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/Non-Deterministic Interleaving Invariant|Non-Deterministic Interleaving Invariant]] — Formal definition and intuition
  - [[Concurrency, Parallelism, and Rust/Threads and Cores/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Data races, line bouncing, SMT contention, reordering (beyond lecture)

### Concurrency Primitives & Control Flow
- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Cooperative multitasking, user-space execution contexts, assembly stack switching (`routine_switch.S`), and CSP rendezvous channels
  - [[Concurrency, Parallelism, and Rust/Coroutines/Limits of OS Threads and the Coroutine Abstraction|Limits of OS Threads and the Coroutine Abstraction]] — Why coroutines, the book-reading analogy, and the design space
  - [[Concurrency, Parallelism, and Rust/Coroutines/Coroutine Memory Layout and Control Block|Coroutine Memory Layout and Control Block]] — Private stacks, struct Routine, and the core API
  - [[Concurrency, Parallelism, and Rust/Coroutines/Assembly Context Switch|Assembly Context Switch]] — routine_switch.S and the x86-64 ABI
  - [[Concurrency, Parallelism, and Rust/Coroutines/Channels and Rendezvous Semantics|Channels and Rendezvous Semantics]] — CSP channels, causal consistency, and unbuffered rendezvous
  - [[Concurrency, Parallelism, and Rust/Coroutines/Channel Queue Mechanics|Channel Queue Mechanics]] — send, receive, and yieldOnto
  - [[Concurrency, Parallelism, and Rust/Coroutines/Latching Return Values and Generators|Latching Return Values and Generators]] — Endless return streams
  - [[Concurrency, Parallelism, and Rust/Coroutines/Channel Flavors and Synchronization Patterns|Channel Flavors and Synchronization Patterns]] — Buffering, pointer ownership, and barriers
  - [[Concurrency, Parallelism, and Rust/Coroutines/Interleaving and Yield Traces|Interleaving and Yield Traces]] — Output permutations and lazy vs eager spawn
  - [[Concurrency, Parallelism, and Rust/Coroutines/Assembly Context Switch Trace|Assembly Context Switch Trace]] — Step-by-step stack pivot
  - [[Concurrency, Parallelism, and Rust/Coroutines/Fibonacci Generator Trace|Fibonacci Generator Trace]] — Infinite producer-consumer stream
  - [[Concurrency, Parallelism, and Rust/Coroutines/Formal State Model|Formal State Model]] — State transition function and invariants
  - [[Concurrency, Parallelism, and Rust/Coroutines/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Starvation, stack overflow, deadlocks, and lifetime hazards (beyond lecture)
  - [[Concurrency, Parallelism, and Rust/Coroutines/Deep Dive|Deep Dive]] — Stackful vs stackless, symmetric vs asymmetric, and switch latency (beyond lecture)
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — x86-64 stack frame layout, stack overflow protection, assembly context switching, and CSP channel mechanics
  - [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Naive Approaches and Motivation|Naive Approaches and Motivation]] — Why coroutines need managed stacks
  - [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Coroutine Stack Frames and Memory Layout|Coroutine Stack Frames and Memory Layout]] — x86-64 layout and control block
  - [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Context Switching and Assembly Trampoline|Context Switching and Assembly Trampoline]] — Scheduler interface, register saving, and the switch
  - [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Unbuffered Channel Rendezvous Trace|Unbuffered Channel Rendezvous Trace]] — Trace of a rendezvous
  - [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Channel Formal Specification|Channel Formal Specification]] — Formal definition and intuition
  - [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Stack overflow and deadlock detection (beyond lecture)
- [[Concurrency, Parallelism, and Rust/Implementing Threads|Implementing Threads]] — Timer-driven preemption with the LAPIC, interrupt handling on x86, critical sections, spinlocks, interrupt-safe spinlocks, and atomic read-modify-write instructions
  - [[Concurrency, Parallelism, and Rust/Synchronization Primitives|Synchronization Primitives]] — Semaphore, mutex, barrier, condition variable, and the InterruptSafeLock used in Homework 3
- [[Concurrency, Parallelism, and Rust/Implementing Synchronization Primitives|Implementing Synchronization Primitives]] — Thread-safe channels with ISLs, atomic block-and-unlock, mutex implementations, semaphores, RwLocks, condition variables, monitors, and common problems
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code|Writing Multithreaded Code]] — Barriers, data races, combinatorial interleavings, mutual exclusion locks, and compiler/hardware memory reordering
  - [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Nondeterminism and Synchronization Paradigms|Nondeterminism and Synchronization Paradigms]] — Preemptive scheduling and coarse vs fine granularity
  - [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Data Races and Interleavings|Data Races and Interleavings]] — Race conditions, combinatorial explosion, and formal conditions
  - [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Barriers|Barriers]] — Coarse-grained synchronization
  - [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Mutual Exclusion Locks|Mutual Exclusion Locks]] — Fine-grained synchronization, hazards, and alternatives
  - [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Memory Reordering and Fences|Memory Reordering and Fences]] — Compiler and hardware reordering
  - [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Bank Account Traces|Bank Account Traces]] — Unsynchronized, mutex, and barrier executions
  - [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Deadlock, double-locking, stragglers, and flag signaling (beyond lecture)
  - [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Deep Dive|Deep Dive]] — x86-64 TSO vs ARM memory models (beyond lecture)
