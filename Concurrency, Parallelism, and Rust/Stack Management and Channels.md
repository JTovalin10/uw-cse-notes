# Concurrency, Parallelism, and Rust: Stack Management and Channels

User-space coroutines require dedicated execution stacks, low-level CPU context switching, and structured communication primitives to coordinate concurrent execution without OS kernel intervention or shared mutable state hazards.

## Topics

- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Naive Approaches and Motivation|Naive Approaches and Motivation]] — Why coroutines need managed stacks
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Coroutine Stack Frames and Memory Layout|Coroutine Stack Frames and Memory Layout]] — x86-64 layout and control block
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Context Switching and Assembly Trampoline|Context Switching and Assembly Trampoline]] — Scheduler interface, register saving, and the switch
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Unbuffered Channel Rendezvous Trace|Unbuffered Channel Rendezvous Trace]] — Trace of a rendezvous
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Channel Formal Specification|Channel Formal Specification]] — Formal definition and intuition
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Stack overflow and deadlock detection (beyond lecture)

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Primary navigation hub covering user-space coroutines, state machines, and assembly switching
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Foundations of task vs data parallelism, hardware microarchitecture, and dataflow DAGs
- [[Operating Systems/Concurrency/Threads/Thread Levels/User vs Kernel Threads|User vs Kernel Threads]] — Comparison between 1:1 OS kernel thread scheduling and M:N / 1:N user-space coroutines
- [[Systems Programming/Memory Management/Stack|Stack Memory Management]] — Deep dive into virtual address space, x86-64 stack alignment, and calling conventions
