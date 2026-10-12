# The Concurrent Mindset: Dependency Chains and Dataflow Graphs

## Dependency Chains & Dataflow Graphs
The sequence of tasks in an F1 pit stop defines a strict **dependency chain**:

![[F1 Dependency Chain.png]]

Key constraints governing this dependency chain:
1. **Front and Rear Jacks Up**: The vehicle must be lifted off the ground before any wheel can be removed.
2. **Four Parallel Wheel Swaps**: Once elevated, all four corners of the car are serviced simultaneously and independently:
   $$\text{Loosen Nut} \longrightarrow \text{Remove Old Tire} \longrightarrow \text{Fit New Tire} \longrightarrow \text{Tighten Nut}$$
3. **Barrier Synchronization**: All 4 wheel assemblies must finish before the car can be lowered. If 3 wheels finish in 1.8 seconds but 1 wheel takes 3.0 seconds, the car remains lifted.
4. **Lower Jacks & Release**: Once all wheels are verified, both jacks lower the vehicle, and the release signal is given to the driver.

### Workload Balancing & Bubbling
- When parallelizing tasks, unequal workload distribution creates **bubbling** (pipeline stalls or thread idling).
- Downstream tasks are forced to block waiting for the slowest upstream task on the critical path. Balancing task duration across workers is essential to avoid wasted core cycles.

### Formalizing Concurrency: The Dependency Graph
A dependency chain formalizes into a **Dependency Graph** (also called a **Dataflow Graph**), which is a Directed Acyclic Graph (DAG) $G = (V, E)$:
- **Vertices ($V$)**: Represent discrete computational tasks or operations.
- **Directed Edges ($E$)**: Represent causal dependency constraints ($u \rightarrow v$ means task $u$ must finish before task $v$ can start).

![[F1 Dependency Graph.png]]

Below is the architectural representation of the F1 pit stop dataflow graph:

![[Dataflow graph.png]]

## Formal Analysis / Protocol Specification

### Formal Definition
Let $E$ be a set of execution events in a system, and let $\rightarrow^*$ denote the reflexive transitive closure of the causal precedence (happens-before / dependency) relation:

$$\text{Concurrent}(x, y) \iff \neg(x \rightarrow^* y) \land \neg(y \rightarrow^* x)$$

Two events $x, y \in E$ are concurrent if and only if there is no directed path from $x$ to $y$ and no directed path from $y$ to $x$ within the task dependency graph $G = (V, E)$.

### Simplified Explanation
If task $X$ doesn't need to wait for task $Y$, and task $Y$ doesn't need to wait for task $X$, they are concurrent and can safely be run at the exact same time.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Dependency Graph / Dataflow Graph** | Task Directed Acyclic Graph (DAG) / Computation Graph |
| **Bubbling** | Pipeline Stall / Pipeline Bubble / Core Idling |

## Related

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Assembly Line and Scaling Strategies|Assembly Line and Scaling Strategies]] — Task specialization, scale-up, and the pit stop case studies
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Pit Stop and Scheduling Traces|Pit Stop and Scheduling Traces]] — Concrete execution traces
