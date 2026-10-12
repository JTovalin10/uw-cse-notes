# Decomposition: Domain Partitioning Trace

## Trace 2: Domain Decomposition Partitioning Schemes

Consider processing an 8-row image (Rows 0–7) across **2 workers** ($W_0, W_1$):
- **Rows 0–3 (Uniform Background)**: 1 compute tick per row.
- **Rows 4–7 (Detailed Foreground)**: 3 compute ticks per row.
- Total computation required: $(4 \times 1) + (4 \times 3) = 16\text{ ticks}$.

```
Strategy A: Static Block Allocation
  Worker 0: Assigned Rows 0–3 -> 1 + 1 + 1 + 1 = 4 ticks
  Worker 1: Assigned Rows 4–7 -> 3 + 3 + 3 + 3 = 12 ticks

  Timeline:
    t = 0  to 4:  W0 computes Rows 0–3; W1 computes Rows 4 and part of 5.
    t = 4:        W0 completes all tasks.
    t = 4  to 12: W0 sits completely IDLE (wasted CPU cycles). W1 continues alone.
    t = 12:       W1 completes Row 7. Barrier satisfied.

  Total Elapsed Time: 12 ticks.
  Idle Wasted Time:   8 ticks (W0 idle 66.7% of total runtime).


Strategy B: Static Cyclic Allocation
  Worker 0: Assigned Rows 0, 2, 4, 6 -> 1 + 1 + 3 + 3 = 8 ticks
  Worker 1: Assigned Rows 1, 3, 5, 7 -> 1 + 1 + 3 + 3 = 8 ticks

  Timeline:
    t = 0 to 8:   Both W0 and W1 compute continuously.
    t = 8:        Both W0 and W1 complete their final rows simultaneously.

  Total Elapsed Time: 8 ticks (33% faster than Block Allocation).
  Idle Wasted Time:   0 ticks (Perfect static workload balance).


Strategy C: Dynamic Allocation (Shared Queue of 1-Row Strips)
  Queue contains: [R0, R1, R2, R3, R4, R5, R6, R7]
  Each queue access incurs a small synchronization cost (0.1 ticks).

  Timeline:
    t = 0.0: W0 pulls R0; W1 pulls R1.
    t = 1.1: W0 finishes R0, pulls R2; W1 finishes R1, pulls R3.
    t = 2.2: W0 finishes R2, pulls R4 (cost 3); W1 finishes R3, pulls R5 (cost 3).
    t = 5.3: W0 finishes R4, pulls R6 (cost 3); W1 finishes R5, pulls R7 (cost 3).
    t = 8.4: Both workers finish.

  Total Elapsed Time: 8.4 ticks.
  Analysis: Dynamically balances without prior knowledge of row costs, paying only a minor coordination tax.
```

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Decomposition/Pipeline Execution Trace|Pipeline Execution Trace]] — Functional decomposition with bubbling
- [[Concurrency, Parallelism, and Rust/Decomposition/Scaling Laws|Scaling Laws]] — Amdahl, Gustafson, granularity metric, and baseline invariant
