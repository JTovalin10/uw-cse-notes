# Concurrency, Parallelism, and Rust: Coroutines

A coroutine is a cooperative, user-space execution context that can pause and resume its execution at explicit yield points without operating system kernel intervention, enabling lightweight concurrency and structured inter-task data transfer on top of a single physical execution thread.

## Topics

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

## Related

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Concurrency drivers, task parallelism, and dataflow dependency graphs
- [[Hardware & Software Interface/CSE351 Index|CSE351: The Hardware/Software Interface]] — x86-64 stack frame layout, `%rsp` and `%rip` register manipulation, and calling conventions
- [[Systems Programming/CSE333 Index|CSE333: Systems Programming]] — POSIX threads (`pthreads`), mutexes, C memory management, and function pointers
- [[Operating Systems/CSE451 Index|CSE451: Operating Systems]] — Kernel thread schedulers, preemptive multitasking, and OS context switching vs user fibers
- [[Distributed Systems/Index|CSE452: Distributed Systems]] — CSP channel communication, message passing primitives, and causal consistency ordering
