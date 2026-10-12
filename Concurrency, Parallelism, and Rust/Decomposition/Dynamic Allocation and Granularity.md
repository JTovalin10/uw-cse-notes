# Decomposition: Dynamic Allocation and Granularity

## 3. Dynamic Allocation & Load Balancing

In real-world systems, workers rarely finish at identical rates due to:
- **Workload Irregularity**: Computational complexity varies per data item (e.g., Mandelbrot set rendering where complex edge pixels take thousands of iterations while background pixels take one).
- **System Jitter**: OS thread preemption, page faults, and CPU thermal throttling cause identical threads to run at different speeds.
- **The Straggler Effect**: In parallel execution, the slowest worker dictates the total runtime. If three workers finish in 2 seconds and one finishes in 10 seconds, the CPU cores of the three fast workers sit idle, wasting hardware cycles.

### The Dynamic Pull Model
To avoid idle CPU cores, work is assigned at runtime:
1. The dataset is divided into a collection of task strips or chunks.
2. Tasks are placed into a shared task pool or work queue.
3. As soon as a worker becomes available, it pulls the next available task strip from the queue.

### The Overhead of Dynamic Allocation
While dynamic allocation prevents idle workers, coordination introduces non-negligible cost: **time spent communicating and synchronizing is time not spent working**.
- Synchronizing access to the shared task queue requires atomic operations, mutex locks, or message passing.
- Inter-core cache invalidations occur as workers read and write to shared queue metadata.

---

## 4. Decomposition Granularity

The efficiency of dynamic load balancing is governed by its **granularity** ($G$), defined as the ratio of computation time to communication overhead:

$$G = \frac{T_{\text{computation}}}{T_{\text{communication}}}$$

![[Overhead of Dynamic Allocation.png]]

- **Coarse-Grained Decomposition ($G$ is Large)**:
  - The problem is partitioned into a few large tasks.
  - **Advantage**: Very low communication and synchronization overhead. Workers spend nearly all their time computing. Simpler to implement.
  - **Disadvantage**: Poor load balancing. If one worker receives an unexpectedly heavy task or encounters system jitter, other workers exhaust their work and idle with nothing left to balance.
- **Fine-Grained Decomposition ($G$ is Small)**:
  - The problem is partitioned into many small, bite-sized tasks.
  - **Advantage**: Excellent, responsive load balancing. Idle workers can continuously pick up new subtasks, keeping all cores saturated.
  - **Disadvantage**: High synchronization overhead. The cumulative time spent coordinating who executes what begins to rival or exceed the actual computational work, degrading net speedup.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Dynamic Allocation** | Dynamic Task Scheduling / Shared Work Queue / Work-Stealing |
| **Granularity ($G$)** | Compute-to-Communication Ratio / Task Grain Size |
| **Slowest Worker Bottleneck** | Straggler Effect / Tail Latency Bottleneck |

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Decomposition/Domain Decomposition|Domain Decomposition]] — Data partitioning with block and cyclic strategies
- [[Concurrency, Parallelism, and Rust/Decomposition/Functional and Hybrid Decomposition|Functional and Hybrid Decomposition]] — Pipelines, bubbling, and hybrids
