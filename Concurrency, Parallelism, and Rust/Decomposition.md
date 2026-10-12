# Concurrency, Parallelism, and Rust: Decomposition

Decomposition is the foundational architectural process of breaking a computational problem into concurrent subproblems to expose parallel execution across multiple physical processing units while managing partitioning, synchronization, and communication overhead.

## Topics

- [[Concurrency, Parallelism, and Rust/Decomposition/Concurrency vs Parallelism and the Decomposition Mandate|Concurrency vs Parallelism and the Decomposition Mandate]] — Core distinction and why work must be decomposed
- [[Concurrency, Parallelism, and Rust/Decomposition/Domain Decomposition|Domain Decomposition]] — Data partitioning with block and cyclic strategies
- [[Concurrency, Parallelism, and Rust/Decomposition/Dynamic Allocation and Granularity|Dynamic Allocation and Granularity]] — Pull model, overhead, and task granularity
- [[Concurrency, Parallelism, and Rust/Decomposition/Functional and Hybrid Decomposition|Functional and Hybrid Decomposition]] — Pipelines, bubbling, and hybrids
- [[Concurrency, Parallelism, and Rust/Decomposition/Pipeline Execution Trace|Pipeline Execution Trace]] — Functional decomposition with bubbling
- [[Concurrency, Parallelism, and Rust/Decomposition/Domain Partitioning Trace|Domain Partitioning Trace]] — Comparing partitioning schemes
- [[Concurrency, Parallelism, and Rust/Decomposition/Scaling Laws|Scaling Laws]] — Amdahl, Gustafson, granularity metric, and baseline invariant
- [[Concurrency, Parallelism, and Rust/Decomposition/Edge Cases and Performance Hazards|Edge Cases and Performance Hazards]] — Performance pitfalls (beyond lecture)
- [[Concurrency, Parallelism, and Rust/Decomposition/Deep Dive|Deep Dive]] — Work stealing and the roofline model (beyond lecture)

## Related

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Foundational dependency graphs, DAG dataflow models, and multicore hardware trends
- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Cooperative user-space multitasking, stack management, and single-threaded concurrency
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — Channel communication primitives, bounded message passing, and context switching
- [[Data Structures and Parallelism/Parallelism/Amdahl's Law|Amdahl's Law]] — Theoretical speedup bounds and mathematical derivations for parallel algorithms
- [[Data Structures and Parallelism/Parallelism/Work And Span|Work and Span]] — Formal asymptotic analysis of parallel execution DAGs and critical path length
- [[Data Structures and Parallelism/Parallelism/Fork-Join|Fork-Join Parallelism]] — Divide-and-conquer domain decomposition and parallel prefix computation
- [[Hardware & Software Interface/Cache/Spatial Locality|Spatial Locality]] — Memory layouts, cache line utilization, and contiguous block distribution benefits
- [[Hardware & Software Interface/Cache/Cache Locality|Cache Locality]] — Temporal/spatial locality trade-offs in matrix partitioning and stencil computations
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Bounded Buffer Problem|Bounded Buffer Problem]] — Channel synchronization, pipeline buffer queues, and backpressure
- [[Introduction to Data Management/Query Execution/Pipelined Execution|Pipelined Execution]] — Functional pipelining and iterator models in relational query processing engines
- [[Database Internals/Parallel/ParallelExecutionComponents/Speedup and Scaleup|Speedup and Scaleup]] — Strong scaling vs. weak scaling definitions in parallel database query execution
