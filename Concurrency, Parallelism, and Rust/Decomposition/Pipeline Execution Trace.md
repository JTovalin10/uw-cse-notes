# Decomposition: Pipeline Execution Trace

## Concrete Walkthrough & Execution Traces

To observe how partitioning, granularity, and pipeline scheduling dictate runtime performance, consider the following concrete execution traces.

### Trace 1: Functional Decomposition Pipeline Execution & Bubbling

Consider a 4-stage pipeline processing 5 discrete data items ($D_0, D_1, D_2, D_3, D_4$) across discrete clock ticks ($t$):
- **Stage 1 (Worker 0)**: `Read` (nominal cost: 1 tick)
- **Stage 2 (Worker 1)**: `Sum` (nominal cost: 1 tick)
- **Stage 3 (Worker 2)**: `Divide` (nominal cost: 1 tick; complex item cost: 2 ticks)
- **Stage 4 (Worker 3)**: `Write` (nominal cost: 1 tick)

Suppose item $D_1$ contains a computationally complex input that causes Stage 3 (`Divide`) to require **2 clock ticks** instead of 1.

```
Initial State (t = 0):
  Pipeline Stages: Empty
  Data Queue: [D0, D1, D2, D3, D4]
  Channels: All empty

Execution Trace:
  t = 0 -> 1: Ramp-up Phase
    Worker 0 (Read):   Processes D0
    Worker 1 (Sum):    Idle (Starved)
    Worker 2 (Divide): Idle (Starved)
    Worker 3 (Write):  Idle (Starved)

  t = 1 -> 2:
    Worker 0 (Read):   Processes D1
    Worker 1 (Sum):    Processes D0
    Worker 2 (Divide): Idle (Starved)
    Worker 3 (Write):  Idle (Starved)

  t = 2 -> 3:
    Worker 0 (Read):   Processes D2
    Worker 1 (Sum):    Processes D1
    Worker 2 (Divide): Processes D0
    Worker 3 (Write):  Idle (Starved)

  t = 3 -> 4: Steady State (Nominal)
    Worker 0 (Read):   Processes D3
    Worker 1 (Sum):    Processes D2
    Worker 2 (Divide): Processes D1 (Begins Tick 1 of 2)
    Worker 3 (Write):  Processes D0 -> Output D0 complete!

  t = 4 -> 5: Pipeline Stall & Bubble Injected
    Worker 2 (Divide): Still busy with D1 (Tick 2 of 2)  <-- Slowest Worker Bottleneck
    Worker 1 (Sum):    Finished D2, but Channel 2 is full (Backpressure Stall!)
    Worker 0 (Read):   Finished D3, Channel 1 is full (Backpressure Stall!)
    Worker 3 (Write):  Idle (No input from Worker 2 -> Bubble / Straggler Idle Cycle!)

  t = 5 -> 6: Recovery
    Worker 2 (Divide): Finishes D1, passes to Worker 3; dequeues D2
    Worker 1 (Sum):    Processes D3
    Worker 0 (Read):   Processes D4
    Worker 3 (Write):  Processes D1 -> Output D1 complete!

  t = 6 -> 7: Drain Phase
    Worker 0 (Read):   Done (No more input)
    Worker 1 (Sum):    Processes D4
    Worker 2 (Divide): Processes D3
    Worker 3 (Write):  Processes D2 -> Output D2 complete!

  t = 7 -> 8:
    Worker 2 (Divide): Processes D4
    Worker 3 (Write):  Processes D3 -> Output D3 complete!

  t = 8 -> 9:
    Worker 3 (Write):  Processes D4 -> Output D4 complete!

Final State (t = 9):
  All 5 items fully processed and written.
  Total Execution Time: 9 ticks (extended by 1 tick due to the bubble at t=4).
```

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Decomposition/Functional and Hybrid Decomposition|Functional and Hybrid Decomposition]] — Pipelines, bubbling, and hybrids
- [[Concurrency, Parallelism, and Rust/Decomposition/Domain Partitioning Trace|Domain Partitioning Trace]] — Comparing partitioning schemes
