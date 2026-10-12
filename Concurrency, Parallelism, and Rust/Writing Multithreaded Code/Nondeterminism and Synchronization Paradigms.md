# Writing Multithreaded Code: Nondeterminism and Synchronization Paradigms

## Writing Multithreaded Code: Motivation & Overview

In modern multicore systems, multithreaded software leverages hardware parallelism to execute distinct instruction streams simultaneously across shared virtual address spaces. However, shared-memory concurrency introduces fundamental nondeterminism into execution ordering.

### The Source of Nondeterminism: Preemptive Scheduling
Modern operating systems manage concurrent threads using **Preemptive Scheduling**. 
- The OS scheduler preempts running threads based on hardware timer interrupts and allotted execution intervals (**Time Quantum**).
- Preemption can occur at arbitrary assembly instruction boundaries rather than clean source-code statement boundaries.
- Because thread scheduling depends on external physical factors—such as hardware interrupts, cache misses, OS scheduler decisions, and core clock fluctuations—the exact sequence in which instructions execute across multiple threads is nondeterministic.

### Fundamental Limitations of Naive Approaches
Naive approaches to coordinating concurrent work invariably fail in production:
- **Unsynchronized Shared State**: Attempting to share mutable variables without explicit synchronization results in race conditions, corrupted data structures, and silent data loss.
- **Timing Assumptions (Sleep-Based Coordination)**: Introducing arbitrary delays (`sleep()`) to allow another thread to finish assumes deterministic timing that real-world hardware and OS schedulers do not guarantee.
- **Single-Threaded Mental Models**: Compilers and modern out-of-order processors assume single-threaded execution semantics when optimizing code, aggressively reordering or eliminating memory reads and writes unless explicitly constrained by synchronization boundaries.

### Synchronization Paradigms: Coarse-Grained vs. Fine-Grained
To eliminate nondeterministic defects, multithreaded systems employ two distinct granularities of synchronization:
1. **Coarse-Grained Synchronization (Barriers)**: Coordinates groups of threads at macroscopic phase boundaries, halting all participating threads until the entire cohort completes a computational stage.
2. **Fine-Grained Synchronization (Mutual Exclusion Locks)**: Protects individual localized memory regions or data structures (**Critical Sections**), permitting arbitrary thread interleavings outside the critical section while guaranteeing exclusive access within it.

## Related

- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code|Writing Multithreaded Code]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Data Races and Interleavings|Data Races and Interleavings]] — Race conditions, combinatorial explosion, and formal conditions
