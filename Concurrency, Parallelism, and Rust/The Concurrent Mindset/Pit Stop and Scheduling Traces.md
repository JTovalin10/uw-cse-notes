# The Concurrent Mindset: Pit Stop and Scheduling Traces

## Concrete Walkthrough & Execution Trace

To see how a dependency graph dictates execution, consider scheduling tasks onto physical execution units (threads or workers).

### Concrete Pit Stop Execution Trace

```
Initial State:
  Vehicle: Stationary in pit box
  Front Jack: Down
  Rear Jack: Down
  Tires FL, FR, RL, RR: Worn
  Elapsed Time: t = 0.0s

Execution Trace:
  t = 0.0s: Car stops in box.
  t = 0.1s: Front Jack UP and Rear Jack UP engage concurrently.
  t = 0.5s: Car fully elevated. Both Jack events complete.
  t = 0.6s: Four wheel stations begin Phase 2 concurrently:
            Worker FL: Loosen nut
            Worker FR: Loosen nut
            Worker RL: Loosen nut
            Worker RR: Loosen nut
  t = 1.0s: All nuts loosened. Old tires demounted concurrently.
  t = 1.4s: New tires placed onto hubs concurrently.
  t = 1.8s: Wheel nuts torqued:
            FL: Done (t = 1.8s)
            FR: Done (t = 1.8s)
            RL: Done (t = 1.9s)
            RR: Stall on cross-threaded nut (t = 2.4s)  <-- Bubble / Straggler
  t = 2.4s: All 4 wheel completions satisfy Barrier Synchronization.
  t = 2.5s: Front Jack DOWN and Rear Jack DOWN execute concurrently.
  t = 2.8s: Car contacts pavement; both jacks clear.
  t = 2.9s: Release controller signals green light; driver departs.

Final State:
  Vehicle: Moving down pit lane with 4 fresh tires.
  Elapsed Time: t = 2.9s (bounded by straggler task at RR wheel).
```

### Scheduling Dependency Graphs

![[Dependency GRaph 1.png]]
![[Depedency graph 2.png]]

A dataflow graph permits any execution order that respects the topological constraints of the DAG:
- **Sequential Schedule**: Executes tasks one at a time along any valid topological ordering. Safe, but yields no parallel speedup ($T_{\text{seq}} = \sum \text{cost}(v)$).
- **Parallel Schedule**: Executes independent vertices simultaneously across available threads. The minimum achievable runtime is bounded by the **critical path** (the longest weighted path from source to sink).

## Related

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Dependency Chains and Dataflow Graphs|Dependency Chains and Dataflow Graphs]] — Dependency graphs and their formalization
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Edge Cases and Hazards|Edge Cases and Hazards]] — Scheduling complexity and concurrency hazards (beyond lecture)
