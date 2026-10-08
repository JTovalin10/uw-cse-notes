# Concurrency, Parallelism, and Rust: Course Introduction — The Concurrent Mindset

This note introduces the foundational principles of concurrent and parallel execution, the hardware forces driving modern multicore architecture, and the formal dependency models used to decompose computation.

---

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

---

## Architecture & Core Mechanics: Decomposing Work

Taking advantage of multiple execution units requires decomposing monolithic work into smaller, concurrent tasks.

### The Assembly Line: Task Specialization
The historical model for parallel decomposition originates with Henry Ford's manufacturing assembly line:
- **Monolithic Execution**: In craft production, a single worker constructs an entire automobile from start to finish sequentially.
- **Specialized Division of Labor**: Ford decomposed production into discrete, specialized jobs where each worker executes only one specific task.
- **Dependency Ordering**: Specialization works because tasks have inherent causal prerequisites ($A \rightarrow B$). For instance, a tire cannot be mounted until the wheel is manufactured.

### Scaling Strategies: Scale-Up vs. Specialization
When coordinating $N$ workers (or threads), two primary organizational strategies emerge:

1. **Scale-Up (Data Parallelism)**:
   - Multiple workers perform the same task across divided chunks of data or resources.
   - Increases coordination and synchronization overhead as workers compete for shared resources.
2. **Specialization (Task Parallelism)**:
   - Workers perform different, dedicated sub-tasks along an assembly pipeline.
   - In theory, $N$ dedicated workers can reduce production time towards $1/N$, provided each worker's task is balanced and communication overhead is bounded.
   - Requires each worker to know only their immediate operational interface, reducing cognitive and information overhead.

#### Real-World Case Studies: NASCAR vs. Formula 1 Pit Stops
Pit stops illustrate the direct relationship between worker count, specialization, and synchronization:
- **NASCAR Pit Stop (~10 seconds)**:
  - Small crew size (~6–7 workers).
  - Workers carry multiple responsibilities (e.g., one tire changer running around the car to change multiple tires sequentially).
  - Requires dynamic movement and coordination across shared zones.
- **Formula 1 Pit Stop (~2 seconds)**:
  - Highly specialized, large crew (~20+ workers).
  - Extreme task specialization where each person performs exactly one atomic action in place:
    - 2 jack operators (Front Jack and Rear Jack).
    - 3 crew members per wheel $\times$ 4 wheels = 12 wheel technicians (nut gunner, tire remover, tire placer).
    - Dedicated spotters and release controllers.
  - Minimizes cross-talk and latency by executing independent tasks in parallel.

### Dependency Chains & Dataflow Graphs
The sequence of tasks in an F1 pit stop defines a strict **dependency chain**:

![[F1 Dependency Chain.png]]

Key constraints governing this dependency chain:
1. **Front and Rear Jacks Up**: The vehicle must be lifted off the ground before any wheel can be removed.
2. **Four Parallel Wheel Swaps**: Once elevated, all four corners of the car are serviced simultaneously and independently:
   $$\text{Loosen Nut} \longrightarrow \text{Remove Old Tire} \longrightarrow \text{Fit New Tire} \longrightarrow \text{Tighten Nut}$$
3. **Barrier Synchronization**: All 4 wheel assemblies must finish before the car can be lowered. If 3 wheels finish in 1.8 seconds but 1 wheel takes 3.0 seconds, the car remains lifted.
4. **Lower Jacks & Release**: Once all wheels are verified, both jacks lower the vehicle, and the release signal is given to the driver.

#### Workload Balancing & Bubbling
- When parallelizing tasks, unequal workload distribution creates **bubbling** (pipeline stalls or thread idling).
- Downstream tasks are forced to block waiting for the slowest upstream task on the critical path. Balancing task duration across workers is essential to avoid wasted core cycles.

#### Formalizing Concurrency: The Dependency Graph
A dependency chain formalizes into a **Dependency Graph** (also called a **Dataflow Graph**), which is a Directed Acyclic Graph (DAG) $G = (V, E)$:
- **Vertices ($V$)**: Represent discrete computational tasks or operations.
- **Directed Edges ($E$)**: Represent causal dependency constraints ($u \rightarrow v$ means task $u$ must finish before task $v$ can start).

![[F1 Dependency Graph.png]]

Below is the architectural representation of the F1 pit stop dataflow graph:

![[Dataflow graph.png]]

---

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

---

## Edge Cases, Concurrency Hazards & Failure Modes

Parallel computing introduces major algorithmic and systems-level complexities that do not exist in sequential software.

### The $O(|V|!)$ Scheduling Complexity
- For a general dependency graph $G = (V, E)$, there are up to $O(|V|!)$ possible topological permutations for ordering vertices.
- Finding an optimal scheduling of DAG vertices onto a fixed number of physical processors while minimizing communication latency and memory footprint is an NP-hard problem.
- In practice, runtime schedulers rely on heuristics (such as work stealing) to dynamically allocate tasks.

### Concurrency Hazards in Systems Code
When concurrent tasks access shared state or execution resources, severe bugs can arise:

1. **Data Races**:
   - Occur when two or more instructions in different threads access the same memory location concurrently, at least one access is a write, and there is no synchronization (e.g., locks or atomics) ordering them.
   - Causes undefined behavior in C/C++; mathematically prevented at compile time by Rust's borrow checker.
2. **Race Conditions**:
   - Flaws in program logic where the correctness of output depends on the non-deterministic interleaving or timing of events. Even when all memory accesses are synchronized, high-level race conditions can still violate program invariants.
3. **Deadlocks**:
   - A situation where two or more threads are permanently blocked waiting for locks held by each other, forming a cyclic dependency graph of resources.
4. **False Cacheline Sharing**:
   - Occurs when two threads running on different cores modify independent variables that reside within the same 64-byte CPU cache line.
   - Even though the software logic is independent, the hardware cache coherence protocol (e.g., MESI/MOESI) invalidates and ping-pongs the cache line between core L1/L2 caches, causing dramatic performance degradation.
5. **Memory Management Bugs**:
   - In languages like C, concurrent allocation, deallocation, or pointer passing can easily result in use-after-free, double-free, and dangling pointers across thread boundaries.

---

## Formal Analysis / Protocol Specification

### Formal Definition
Let $E$ be a set of execution events in a system, and let $\rightarrow^*$ denote the reflexive transitive closure of the causal precedence (happens-before / dependency) relation:

$$\text{Concurrent}(x, y) \iff \neg(x \rightarrow^* y) \land \neg(y \rightarrow^* x)$$

Two events $x, y \in E$ are concurrent if and only if there is no directed path from $x$ to $y$ and no directed path from $y$ to $x$ within the task dependency graph $G = (V, E)$.

### Simplified Explanation
If task $X$ doesn't need to wait for task $Y$, and task $Y$ doesn't need to wait for task $X$, they are concurrent and can safely be run at the exact same time.

---

## Deep Dive

### Dennard Scaling Breakdown & Amdahl's Law
The historical inflection point highlighted in microprocessor trend charts occurred around 2005 with the collapse of **Dennard scaling**:
- Under Dennard scaling, as transistors shrunk, their power density remained constant because operating voltage scaled down proportionally with gate dimensions. This allowed clock frequencies to ramp from MHz to GHz without exceeding thermal limits.
- Below 90nm, leakage current and quantum tunneling prevented further supply voltage reductions, causing chip power consumption to explode with frequency (the "Power Wall").
- This shifted processor architecture to chip multiprocessing (CMP). According to **Amdahl's Law**, the theoretical speedup $S$ of a program on $N$ cores is strictly limited by its strictly sequential fraction $s$:
  $$S(N) = \frac{1}{s + \frac{1 - s}{N}}$$
  If just 5% of a program cannot be parallelized ($s = 0.05$), the maximum theoretical speedup on an infinite number of cores is bounded at $20\times$.

### Rust's Compile-Time Concurrency Primitives: `Send` and `Sync`
Rust codifies thread-safe concurrency directly into its type system via two core marker traits:
- **`Send`**: Indicates that ownership of the type can be transferred across thread boundaries safely.
- **`Sync`**: Indicates that it is safe for multiple threads to access references to the type (`&T`) concurrently.
- The language formalizes the invariant: `T: Sync \iff &T: Send`. If a type contains non-thread-safe internal mutability without synchronization (such as `Rc<T>`), the compiler marks it as `!Send` and `!Sync`, preventing data races before the code ever compiles.

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Dependency Graph / Dataflow Graph** | Task Directed Acyclic Graph (DAG) / Computation Graph |
| **Bubbling** | Pipeline Stall / Pipeline Bubble / Core Idling |
| **Specialization** | Task Parallelism / Functional Decomposition |
| **Scale-Up** | Data Parallelism / Horizontal Scaling |
| **Concurrent vs. Parallel** | Interleaved Logical Structure vs. Simultaneous Physical Execution |
| **Race Condition vs. Data Race** | High-Level Semantic Race vs. Low-Level Memory Unsynchronized Access |

---

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Domain and functional decomposition strategies, dynamic load balancing, task granularity, and scaling laws
- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Cooperative user-space multitasking, stack management, and assembly context switching
- [[CSE351 Index|CSE351: The Hardware/Software Interface]] — Physical memory hierarchies, caches, and multi-core processor architectures
- [[CSE333 Index|CSE333: Systems Programming]] — POSIX threads (`pthreads`), mutexes, and lower-level synchronization in C
- [[Concurrency Intro|CSE333: Concurrency Intro]] — Foundational POSIX threads and race conditions in C
- [[CSE451 Index|CSE451: Operating Systems]] — Kernel thread scheduling, context switching, and OS synchronization primitives
- [[Race Condition|CSE451: Race Conditions]] — Critical sections, mutual exclusion, and low-level synchronization anomalies
- [[Distributed Systems/Index|CSE452: Distributed Systems]] — Distributed concurrency, happens-before relations, and consensus protocols
- [[Logical Clocks|CSE452: Logical Clocks]] — Causal ordering and the formal happens-before relationship