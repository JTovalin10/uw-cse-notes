# Database Internals: Query Executor

The query executor is the component of the [[Database Internals/DBMS Architecture and Deployments/Subsystems/Query Pipeline|Query Processing Pipeline]] that takes a physical query plan and actually runs it, producing tuples that are returned to the user.

## Push vs. Pull Execution

Two execution models exist for driving how tuples flow between operators:

- **Pull-based (Volcano/Iterator model)**: The parent operator drives execution by calling `next()` on its child. The child answers "here is a tuple." Execution is demand-driven — no tuple is produced until the consumer asks for it.
- **Push-based**: The child operator drives execution by sending tuples to the parent as soon as they are available, without waiting to be asked. Many modern databases (especially distributed ones) implement push-based execution because it reduces network round-trips in pipelined execution — a producer node does not wait for the consumer to poll it.

## Iterator Interface

Every operator implements the **iterator interface** (also called the Volcano model). This uniform API allows any operator to be composed with any other operator:

| Method | Description |
|--------|-------------|
| `open()` | Initializes operator state; sets parameters like selection predicates |
| `next()` | Returns one tuple; recursively calls `next()` on child operators |
| `close()` | Cleans up operator state and releases resources |

Each operator holds a reference to its child operator and calls `child.open()`, `child.next()`, and `child.close()` through the same interface, enabling arbitrary operator trees.

![[Query Execution.png]]

The power of this model is **pipelining**: operators execute concurrently in a pipeline. A `SELECT` operator above a `JOIN` operator does not wait for the join to finish before processing tuples — it processes each tuple as soon as the join emits it, keeping memory usage bounded.

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|---|---|
| Pull-based (iterator model) | Volcano model / iterator model |
| Push-based | Push model / producer-driven execution |
| Iterator interface | Operator interface / volcano interface |
| `open()` / `next()` / `close()` | `init()` / `next()` / `done()` (varies by system) |

## Related

- [[Database Internals/DBMS Architecture and Deployments/Subsystems/Query Pipeline|Query Processing Pipeline]] — the four stages that produce a physical plan for the executor to run
- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture]] — how the executor fits into the two-subsystem DBMS model
- [[Database Internals/Parallel/Parallel Query Execution|Parallel Query Execution]] — how the iterator model extends to distributed, parallel execution
