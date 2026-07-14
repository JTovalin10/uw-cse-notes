# CSE451: Deadlocks

## The Deadlock State

A **[[Operating Systems/Concurrency/Problems/Deadlocks|Deadlock]]** is a permanent, non-recoverable system state involving a set of **[[Thread|Threads]]** or processes. This state occurs when every member of the set is blocked because it is waiting for a resource that is currently held by another member of that same set. This creates a circular dependency chain where progress is mathematically impossible without external kernel-level intervention. Unlike **[[Operating Systems/Concurrency/Problems/Starvation|Starvation]]**, where the system as a whole keeps making progress but one thread is repeatedly passed over, a deadlock means *no* thread in the set can ever proceed again on its own.

## The Four Necessary Conditions (Coffman Conditions)

For a **Deadlock** to be possible, all four of the following technical conditions must hold simultaneously. Breaking any single condition is the fundamental basis for **Deadlock Prevention**.

1.  **Mutual Exclusion**: At least one resource must be held in a non-sharable mode. Only one **[[Thread|Thread]]** can access the resource at any given time; any subsequent requester must wait. This is the same **[[Operating Systems/Concurrency/Synchronization/Mechanics/Mutual Exclusion|Mutual Exclusion]]** property that synchronization primitives are designed to provide, which is why deadlocks are an inherent risk whenever locks are used.
2.  **Hold and Wait**: A **[[Thread|Thread]]** must be holding at least one resource while simultaneously waiting to acquire additional resources that are currently held by other threads.
3.  **No Preemption**: Resources cannot be forcibly taken from a **[[Thread|Thread]]**. They can only be released voluntarily by the holder after the task is completed.
4.  **Circular Wait**: A closed chain of threads $\{T_1, T_2, \dots, T_n\}$ exists such that $T_1$ is waiting for a resource held by $T_2$, $T_2$ is waiting for $T_3$, and $T_n$ is waiting for $T_1$.

## Resource Allocation Graphs (RAG)

**Resource Allocation Graphs** are a formal method used to visualize the state of threads and reason about the presence of deadlocks. A deadlock exists precisely when the graph contains a cycle (under certain conditions on resource instance counts, discussed below).

*   **Vertices ($V$)**:
    *   **Threads ($T$)**: Represented by circles.
    *   **Resource Types ($R$)**: Represented by squares. (Dots inside represent instances).
*   **Edges ($E$)**:
    *   **Request Edge ($T_i \to R_j$)**: Indicates thread $T_i$ has requested $R_j$ and is blocked.
    *   **Assignment Edge ($R_j \to T_i$)**: Indicates $R_j$ has been successfully allocated to $T_i$.

![[Resource Graphs.png]]
[Image: Resource Allocation Graph showing nodes for threads and resources with directed edges representing requests and assignments.]

![[Deadlock.png]]
[Image: A cycle in a Resource Allocation Graph indicating a deadlock.]

## Methodologies for Handling Deadlock

Strategies are broadly classified into three categories, each aiming to eliminate or manage the four Coffman conditions. They differ chiefly in *when* they act: prevention acts at design time, avoidance acts at every request, and detection/recovery acts only after the fact.

| Strategy | Methodology | Implementation Details |
| :--- | :--- | :--- |
| **Prevention** | Design the system to ensure at least one Coffman condition *cannot* hold. | Hierarchical Locking (No Circular Wait), Atomic Acquisition (No Hold and Wait). |
| **Avoidance** | Dynamically evaluate every request to ensure the system never enters an "Unsafe State." | Uses *a priori* knowledge of maximum resource needs (Banker's Algorithm). |
| **Detection & Recovery** | Periodically scan for cycles and forcibly break them if found. | Cycle Detection Algorithms; Thread termination or resource preemption. |

### 1. Deadlock Prevention

The goal is to invalidate at least one of the four necessary conditions before the system ever runs, so a deadlock structurally cannot arise.

*   **Eliminating "Hold and Wait"**:
    *   **Strategy**: Require threads to request all resources at once at the beginning. If any are unavailable, the thread must block until *all* can be granted simultaneously.
    *   **Pros**: Simple and effective at preventing deadlocks.
    *   **Cons**: Low resource utilization (a thread might hold a resource for hours but only use it for seconds); starvation risk (see **[[Operating Systems/Concurrency/Problems/Starvation|Starvation]]**); "Future-blindness" (a thread may not know what it needs until it's running).
*   **Eliminating "Circular Wait"**:
    *   **Strategy (Havender's Theorem)**: Impose a strict linear ordering on all resource types (e.g., $R_1 < R_2 < R_3$). A thread holding $R_i$ can only request $R_j$ if $R_j > R_i$.
    *   **Pros**: Proven effective and used in real systems (e.g., Linux kernel lock ordering).
    *   **Cons**: Difficult to maintain in large systems as new resources are added; requires global coordination.
*   **Eliminating "Mutual Exclusion"**: Generally impossible for non-sharable resources (like a printer or a hardware register), but can be mitigated by **Spooling** or using **Wait-Free** data structures.

### 2. Deadlock Avoidance

Unlike prevention (which is static and enforced structurally regardless of the actual request pattern), avoidance uses dynamic, runtime information about the current and future state of the system to decide whether a specific request is safe to grant.

*   **The Banker's Algorithm**:
    *   **The Concept**: Before granting a request, the OS simulates the allocation. It asks: "If I grant this, and everyone then requests their maximum claim, is there *at least one* sequence of execution where everyone finishes?"
    *   **Safe vs. Unsafe State**:
        *   **Safe**: There exists a sequence of thread completions that doesn't lead to deadlock.
        *   **Unsafe**: There is a *possibility* of deadlock. The OS will block the request to stay in the Safe state.
    *   **Drawback**: Extremely conservative; requires threads to declare their maximum resource needs in advance (rarely known in general-purpose computing).

### 3. Detection and Recovery

Rather than paying the up-front cost of prevention or avoidance, this strategy allows the system to enter a deadlock and instead provides a mechanism to detect and fix it after the fact — trading correctness guarantees for lower overhead in the common case where deadlocks are rare.

*   **Detection**: Periodically run a **Cycle Detection Algorithm** on the Resource Allocation Graph.
    *   **Identifying Stuck Threads**: If a thread is blocked for an unusually long time, it becomes a "suspect."
*   **Recovery**:
    *   **Process Termination**: Kill all deadlocked processes (brute force) or kill one at a time until the cycle is broken.
    *   **Resource Preemption**: Forcibly take a resource from one thread and give it to another. This requires **Checkpointing** and **Rollback** capabilities.

## Debugging Deadlocks in the Real World

Once a system enters a deadlocked state, its state is stable (nothing in the deadlocked set can change on its own), which is what makes forensic analysis possible after the fact. In modern operating systems (like Windows or Linux), the primary culprits are usually:

1.  **[[Operating Systems/Concurrency/Synchronization/Mechanics/Critical Sections/Critical SectionsComponents/Spinlock|Spinlocks]]**: Used in kernel-mode for short-duration locks.
2.  **[[Operating Systems/Concurrency/Synchronization/Mechanics/Critical Sections/Critical SectionsComponents/Semaphores|Semaphores]]**: Used for synchronization and signaling.
3.  **Mutexes**: Binary semaphores with owner tracking.
4.  **Reader/Writer Locks** (e.g., EResource in Windows): Allow multiple readers but exclusive writers.

### Analysis Techniques

*   **Post-Mortem Analysis**: Once a system deadlocks, the state remains stable. A debugger can walk through every lock and thread to see who owns what and who is waiting on what.
*   **Metadata Tracking**: High-quality lock implementations record the **Return Address** of the thread that acquired the lock. This makes it easy to trace *where* in the code the lock was taken.
*   **Visualization**: Drawing the Resource Allocation Graph (RAG) is often the final step to proving a deadlock exists.

## Graph Reduction and Formal Theorems

**Graph Reduction** is an algorithmic process used to detect if a system state is deadlocked by simulating thread completion. This formalizes the intuitive "cycle in the RAG" check from earlier into a rigorous, mechanical procedure.

### The Reduction Process

1.  A graph can be reduced by a **Thread** if all of its current resource requests can be granted.
2.  If reducible, the thread is assumed to eventually terminate and release all held resources.
3.  The released resources are added to the available pool, potentially enabling further reductions.

### Foundational Theorems

*   **Holt's Theorem**: A set of threads is **not deadlocked** if and only if the Resource Allocation Graph is **completely reducible**.
*   **Reduction Invariance**: The **order of reductions is irrelevant**. If a graph is reducible, any sequence of valid reductions will result in a completely reduced graph.

## Deep Dive

In distributed systems, deadlock handling shifts from graph-based detection to simpler prevention strategies because maintaining a global, consistent Resource Allocation Graph across machines is expensive and slow. **[[Distributed Systems/Sharding/2PCComponents/Locking and Deadlock|CSE452: 2PC Locking and Deadlock]]** covers **abort-on-conflict** ("no-wait") as a practical prevention strategy used in Two-Phase Commit: rather than letting a transaction block and wait for a lock (risking a cross-machine circular wait that would be very costly to detect), a participant that cannot immediately acquire a needed lock simply aborts the transaction and lets the coordinator retry later. This sacrifices some throughput under contention (and introduces a new failure mode, **livelock**, where transactions repeatedly abort each other) in exchange for never needing a distributed cycle-detection protocol.

## Formal Definition

For a deadlock to hold on a set of threads $\{T_1, \dots, T_n\}$ and resources $\{R_1, \dots, R_n\}$, all four Coffman conditions hold simultaneously, and there exists a circular wait such that:

$$T_1 \to R_1 \to T_2 \to R_2 \to \dots \to T_n \to R_n \to T_1$$

where $T_i \to R_i$ denotes a **Request Edge** (waiting) and $R_i \to T_{i+1}$ denotes an **Assignment Edge** (held). By **Holt's Theorem**, this set of threads is deadlocked if and only if the Resource Allocation Graph is *not* completely reducible — i.e., no sequence of thread completions can reduce the graph to have zero edges.

## Simplified Explanation

Two people each hold half of a pair of scissors and each refuses to let go until they get the other half. Neither one will ever finish cutting, and neither will voluntarily give up what they're holding — so they'll be stuck like that forever unless someone from outside forcibly takes a piece away.

## Industry Standard Terms

| CSE451 Term | Industry / Standard Term |
| :--- | :--- |
| **Coffman Conditions** | Deadlock conditions |
| **Resource Allocation Graph (RAG)** | Wait-for graph / dependency graph |
| **Banker's Algorithm** | Safety algorithm / resource allocation avoidance |
| **Holt's Theorem** | Graph reducibility theorem |
| **Hierarchical Locking** | Lock ordering / lock leveling |
| **Detection & Recovery** | Deadlock detection with rollback |

## Related Concepts

- [[Concurrency And Locks|CSE332: Concurrency and Locks]]
- [[Operating Systems/Concurrency/Synchronization]]
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Mutual Exclusion]]
- [[Binary Semaphore]]
- [[Counting Semaphore]]
- [[Condition Variables]]
- [[Bounded Buffer Problem]]
- [[Operating Systems/Concurrency/Problems/Starvation|Starvation]]
- [[Systems Programming/Concurrency/Threads]]
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Race Conditions/Race Condition|Race Conditions]]
- [[Distributed Systems/Sharding/2PCComponents/Locking and Deadlock|CSE452: 2PC Locking and Deadlock]]
