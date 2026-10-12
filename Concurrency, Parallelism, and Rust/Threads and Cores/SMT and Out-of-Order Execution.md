# Threads and Cores: SMT and Out-of-Order Execution

## Hyperthreading / Simultaneous Multithreading (SMT)
**Hyperthreading** (Intel term) or **Simultaneous Multithreading (SMT)** is a hardware microarchitectural technique where a single physical CPU core presents multiple **hardware threads** (logical cores) to the operating system.

![[hardware cores.png]]

- **Hardware Resource Sharing**: Hardware threads duplicate architectural register sets (PC, RSP, GPRs) but **share execution pipelines (ALUs, FPUs, vector units) and L1/L2 caches** within the physical core.
- **Performance Characteristics**:
  - An 8-core CPU with 2-way SMT presents 16 logical cores to the OS.
  - SMT improves throughput when one hardware thread stalls on a cache miss, allowing the secondary hardware thread to utilize idle ALU execution units.
  - If both hardware threads execute heavy compute workloads (e.g., floating-point matrix multiplication), they contend for the same physical execution units, yielding lower performance than two dedicated physical cores.
- **Cache Line Padding Ineffectiveness on SMT**: Because hardware threads on the same physical core share the exact same L1 cache, cache lines do not move between distinct physical caches. Thus, cache line padding resolves multi-core inter-cache invalidation but does not alleviate SMT execution unit contention.

## Out-of-Order Execution & Memory Barriers
Modern CPU cores and optimizing compilers dynamically reorder instructions to maximize Instruction-Level Parallelism (ILP):
- **Compiler Reordering**: The compiler rearranges assembly instructions to optimize register allocation and pipeline depth.
- **Hardware Reordering**: Out-of-order execution engines reorder memory reads and writes in store buffers to prevent pipeline stalls.
- **Memory Barriers (Fences)**: Special CPU instructions (e.g., `MFENCE`, `LFENCE`, `SFENCE` on x86) that force the compiler and physical CPU pipeline to flush store buffers and prevent instruction reordering across the barrier boundary.

## Industry Standard Terms

| Course Term | Industry / Standard Term | Real-World Context / Production Equivalent |
| :--- | :--- | :--- |
| **Hardware Threads** | Simultaneous Multithreading (SMT) / Hyper-Threading | Intel Hyper-Threading Technology, AMD SMT |
| **Barrier** | Memory Fence / Memory Barrier | x86 `MFENCE` instruction, C++ `std::atomic_thread_fence` |

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Threads and Cores/False Sharing|False Sharing]] — Invalidation mechanics and cache line padding
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Non-Deterministic Interleaving Invariant|Non-Deterministic Interleaving Invariant]] — Formal definition and intuition
