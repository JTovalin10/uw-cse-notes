# The Concurrent Mindset: Course Overview and Hardware Drivers

## Concurrency & Parallelism: Motivation & Hardware Drivers

Modern computer systems face a fundamental performance paradigm shift. Writing efficient, robust software requires mastering concurrency and parallelism alongside modern memory-safe systems languages like Rust.

### What is Rust?
**Rust**: A modern systems programming language designed for bare-metal performance, type safety, and fearless concurrency.
- **Zero-Cost Abstractions**: Delivers execution speeds on par with C and C++.
- **Compile-Time Memory Safety**: Eliminates entire classes of memory errors (use-after-free, double-free, dangling pointers) without relying on a garbage collector (GC).
- **Fearless Concurrency**: Enforces thread safety, data-race prevention, and ownership transfer at compile time through the type system.

### Course Roadmap
The curriculum is organized into three progressive pedagogical phases:
1. **Weeks 1–3: Concurrency and Parallelism in C**:
   - Low-level concurrency primitives using C and POSIX threads (`pthreads`).
   - Direct exposure to low-level synchronization mechanics, race conditions, and implementation details to develop deep mechanical empathy for the problems Rust solves.
2. **Weeks 4–5: Introduction to Rust**:
   - The Rust ownership model, borrowing rules, lifetimes, and type system.
3. **Weeks 6–10: Concurrency, Parallelism & Rust**:
   - Applying Rust's ownership invariants and concurrency primitives (`Arc`, `Mutex`, channels, atomics) to construct high-throughput, bug-free parallel systems.

### Why Concurrency?
**Concurrency** is the composition of independently executing computations. It is primarily about **program structure**:
- **Resource Efficiency**: Overlaps latency-heavy operations (such as disk reads, network transfers, and user input) with useful computation so the CPU does not idle while waiting on slow I/O.
- **Ergonomic Decomposition**: Provides a natural mental model for decoupling asynchronous subsystems, event loops, background workers, and responsive user interfaces.
- **Conceptual Bridge to Parallelism**: Decomposing problems into concurrent, non-overlapping tasks is the prerequisite for running them simultaneously across physical processors.

### Why Parallelism?
**Parallelism** is the simultaneous physical execution of multiple computations on multiple processing units. It is primarily about **execution speed**:

![[42 Years of Microprocessor Trend Data.png]]

For decades, software performance improved automatically with each hardware generation due to Moore's Law and Dennard scaling. However, physical constraints have fundamentally altered processor design:
- **The Power Wall & End of Frequency Scaling**: Processors can no longer significantly increase clock frequencies without dissipating unsustainable amounts of heat. Single-core speeds have largely plateaued.
- **Horizontal Scaling via Multicore**: To continue delivering performance gains, chip manufacturers stopped making individual cores faster and instead packed more physical cores onto a single silicon die.
- **The Programmer's Mandate**: Software will no longer automatically speed up on newer hardware unless it is explicitly architected to execute concurrently and run in parallel across multiple cores.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Concurrent vs. Parallel** | Interleaved Logical Structure vs. Simultaneous Physical Execution |
| **Race Condition vs. Data Race** | High-Level Semantic Race vs. Low-Level Memory Unsynchronized Access |

## Related

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Assembly Line and Scaling Strategies|Assembly Line and Scaling Strategies]] — Task specialization, scale-up, and the pit stop case studies
