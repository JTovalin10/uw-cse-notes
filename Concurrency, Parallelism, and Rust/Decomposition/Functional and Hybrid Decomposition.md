# Decomposition: Functional and Hybrid Decomposition

## 5. Functional Decomposition (Pipeline Parallelism)

Rather than dividing the data, **Functional Decomposition** divides the algorithmic steps of a program:

![[Functional Decomposition.png]]

- **Division of Labor**: Each worker specializes in one dedicated algorithmic stage (e.g., Worker 0 performs `read`, Worker 1 performs `sum`, Worker 2 performs `divide`, Worker 3 performs `write`).
- **Dataflow Architecture**: Intermediate results flow sequentially between adjacent workers through communication queues or channels (as explored in [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Channels]]).
- **Latency vs. Throughput**:
  - Functional pipelining **does not reduce the latency** of an individual data element (in fact, inter-thread synchronization slightly increases individual latency).
  - Pipelining **maximizes system throughput**: once the pipeline fills, an output is produced at every clock cycle corresponding to the execution time of one stage.

### Pipeline Scheduling & Stalls (Bubbling)
- **Pipeline Schedules**: A schedule dictates which worker executes which task at what time, with the goal of keeping all pipeline stages full simultaneously.
- **The Bottleneck Principle**: In an assembly pipeline, **system throughput is strictly bounded by the slowest stage**:
  $$\text{Maximum Throughput} = \frac{1}{\max_{i}(T_i)}$$
- **Pipeline Stalls (Bubbles)**: If stage $k$ takes longer to execute than adjacent stages, it creates upstream backpressure (upstream workers block waiting for output buffers to drain) and starves downstream stages (downstream workers idle waiting for input). These idle gaps in the execution timeline are known as **pipeline bubbles**.

---

## 6. Hybrid Decomposition

Real-world high-performance systems frequently combine domain and functional decomposition:
- An outer **functional decomposition** pipeline divides high-level stages (e.g., Video Ingestion $\longrightarrow$ Frame Decoding $\longrightarrow$ Computer Vision Analysis $\longrightarrow$ Output Encoding).
- Compute-intensive internal stages (such as Computer Vision Analysis) apply **domain decomposition** internally, distributing image frames or pixel blocks across a thread pool of worker cores.
- **Trade-off**: Hybrid models maximize overall concurrency and hardware saturation, but introduce layered communication hierarchies, buffer management complexity, and multi-tier synchronization overhead.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Functional Decomposition** | Task Parallelism / Pipeline Parallelism |
| **Bubbling / Stalls** | Pipeline Bubble / Core Idling / Pipeline Stall |

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Decomposition/Dynamic Allocation and Granularity|Dynamic Allocation and Granularity]] — Pull model, overhead, and task granularity
- [[Concurrency, Parallelism, and Rust/Decomposition/Pipeline Execution Trace|Pipeline Execution Trace]] — Functional decomposition with bubbling
