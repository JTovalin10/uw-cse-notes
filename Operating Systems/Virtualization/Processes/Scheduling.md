# CSE451: Processor Scheduling: Policies and Mechanisms

## Low-Level Primer: Policy vs. Mechanism
In Operating System architecture, CPU management is strictly divided:
*   **Policy (Scheduling)**: The high-level decision-making logic that determines *which* thread should run next and for *how long*.
*   **Mechanism (Switching)**: The low-level **[[CPU State#Context Switch|Context Switch]]** code that saves/restores registers, switches stacks, and updates the **Translation Lookaside Buffer (TLB)**.

This separation matters because it lets the OS change scheduling policy (e.g., swap in a different algorithm) without touching the underlying mechanism that actually performs the switch — and vice versa, the mechanism can be optimized (e.g., faster register save/restore) without affecting scheduling decisions.

## Classes of Schedulers
Schedulers are optimized for specific workload characteristics:

| Class | Optimization Goal | Technical Examples |
| :--- | :--- | :--- |
| **Batch** | **Throughput** / **Utilization**. | Nightly bank audits, Hadoop/MapReduce jobs. |
| **Interactive** | **Response Time**. | Shell servers (`attu.cs`), desktop environments. |
| **Real-Time** | **Deadlines**. | Embedded flight controllers, medical devices. |
| **Parallel** | **Speedup**. | 1000-processor machines for large simulations. |

## Levels of Scheduling Decisions
1.  **Long-Term Scheduling (Admission)**:
    *   **Decision**: Should a new job be initiated or held in the job pool?
    *   **Context**: Typical of batch systems. High memory/time requirements may trigger a "hold" decision to prevent overloading.
2.  **Medium-Term Scheduling (Swapping)**:
    *   **Decision**: Should a running program be temporarily marked as non-runnable and **swapped out** to disk? See [[swap space|Swap Space]] for the mechanics of how evicted pages are stored and retrieved.
    *   **Goal**: Control the degree of multiprogramming and free up physical memory.
3.  **Short-Term Scheduling (CPU Scheduling)**:
    *   **Decision**: Which thread gets the CPU next and for what duration?
    *   **Granular Decisions**: Which I/O operation to dispatch; **Processor Affinity** (considering cache state to avoid unnecessary cache misses on multi-processors).

These three levels operate at very different timescales — long-term decisions happen rarely (each time a new job arrives), medium-term decisions happen occasionally (under memory pressure), and short-term decisions happen constantly (every time slice or blocking event), which is why short-term scheduling is what people usually mean by "the scheduler."

## Performance Goals and Metrics
### Performance Metrics
*   **Maximize CPU Utilization**: Keep the processor busy 100% of the time.
*   **Maximize Throughput**: Complete the highest number of jobs per time unit.
*   **Minimize Avg. Response Time**: Time from submission to first visual/data response.
*   **Minimize Avg. Waiting Time**: Time spent sitting in the **Ready Queue** (see [[Process State#Common States|Process State: Ready]] and [[State Queues|State Queues]]).
*   **Minimize Energy**: Measured in **Joules per instruction** (crucial for battery-constrained environments).

### Fairness
*   **Subjectivity**: No single definition of fair (per-user vs. per-thread).
*   **Starvation**: The state where a runnable thread is perpetually bypassed. Schedulers must avoid this.
*   **Intentional Unfairness**: **Priority Systems** favor specific classes of requests but must manage the risk of starvation.

Many of these goals are directly in tension with each other — for example, maximizing throughput (favoring short jobs) can come at the cost of fairness (starving long jobs), which is exactly the trade-off explored in the algorithms below.

## Preemption vs. Non-Preemption
*   **Non-Preemptive**: A thread holds the CPU until it voluntarily relinquishes it (e.g., I/O block or completion). This applies to I/O operations and memory allocation without swapping.
*   **Preemptive**: The OS can forcibly take the CPU away from a thread.
    *   **Timer Interrupt**: Allows preemption even if the thread does not yield — the timer fires a hardware **[[Operating Systems/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupt]]** that transfers control back to the OS regardless of what the running thread was doing.
    *   **Context Switch Overhead**: Reassignment always costs cycles that do not contribute to job progress (see [[CPU State#The Cost|Context Switch: The Cost]]).

Whether a scheduler is preemptive or non-preemptive fundamentally shapes which algorithms are even possible — for instance, Round Robin below requires preemption (via a timer interrupt) to forcibly reclaim the CPU once a thread's quantum expires.

---

## Scheduling Algorithms

### 1. First-Come, First-Served (FCFS / FIFO)
*   **Mechanism**: A simple queue where threads are processed in order of arrival.
*   **Pros**: Simple, no starvation.
*   **Drawbacks**:
    *   **Convoy Effect**: Short jobs stuck behind long jobs, leading to lousy average response times.
    *   **Poor Utilization**: CPU-intensive jobs prevent I/O-intensive jobs from running, leaving the I/O subsystem idle.

### 2. Shortest Processing Time (SPT / SJF)
*   **Mechanism**: Choose the job with the smallest service requirement.
*   **Optimality**: Provably optimal for minimizing **Average Response Time**.
*   **Types**:
    *   **SJF**: Non-preemptive.
    *   **SRPT**: Preemptive; handles new arrivals with shorter remaining time.
*   **The Prediction Problem**: Since the OS cannot know future burst times, it uses **Exponential Smoothing** to guess based on history.
*   **Drawback**: High risk of **Starvation** for long jobs — this is the direct trade-off from the Fairness discussion above: SJF optimizes response time at the expense of fairness to long jobs.

### 3. Round Robin (RR)
*   **Mechanism**: Each request gets a **Time Slice (Quantum)**. The queue is a circular FIFO.
*   **Quantum ($q$) Size Problem**:
    *   **Too Small**: High **Context Switch Overhead**.
    *   **Too Large**: Response time degrades; behaves like **FCFS**.
    *   **No Correct Answer**: Selection is a trade-off between switching cost and responsiveness.
*   **Edge Case**: If all jobs are the same length, RR results in the worst possible average response time as all jobs finish at the end.

### 4. Priority Scheduling
*   **Mechanism**: Highest priority runs next. Implemented via multiple queues.
*   **Priority Inversion**: A high-priority thread is blocked by a low-priority thread holding a resource, while a medium-priority thread hogs the CPU.

### 5. Multi-Level Feedback Queues (MLFQ)
**Philosophy**: Workloads have **Increasing Residual Life** (the longer it has run, the longer it will likely continue to run). MLFQ aims to minimize response time for interactive jobs while also being fair to long-running compute jobs — it essentially tries to approximate SJF's low response time without needing to know job lengths in advance, by inferring "shortness" from observed behavior instead.

**The 5 Rules of MLFQ**:
1.  **Rule 1**: If Priority(A) > Priority(B), A runs (B doesn't).
2.  **Rule 2**: If Priority(A) = Priority(B), A & B run in Round Robin (RR) using the quantum of that level.
3.  **Rule 3**: When a job enters the system, it is placed at the highest priority (topmost queue).
4.  **Rule 4**: Once a job uses up its time allotment at a given level (regardless of how many times it has given up the CPU), its priority is reduced (it moves down one queue).
5.  **Rule 5**: After some time period *S*, move all the jobs in the system to the topmost queue (**Priority Boost**). This prevents starvation and allows CPU-bound jobs to become interactive again if their behavior changes.

**Mechanism**:
*   Hierarchy of queues with varying priority and quanta.
*   **Quanta Scaling**: Lower priority queues often have **longer quanta** to handle compute-bound tasks efficiently — since a job that has already proven itself to be long-running is unlikely to be interactive, so giving it a longer quantum reduces context-switch overhead without hurting responsiveness for other jobs.

![[MLFQ.png]]
[Image: MLFQ hierarchy showing priority-based queue migration.]

### 6. UNIX Scheduling (Classical Implementation)
*   **Structure**: ~170 priority levels across **Real-Time**, **System**, and **Time-Sharing** classes.
*   **Mechanism**: Priority scheduling across queues, **Round Robin** within queues.
*   **Dynamic Adjustment**:
    *   **Increase Priority**: If a process blocks for I/O before its quantum ends.
    *   **Decrease Priority**: If a process consumes its entire quantum (compute-bound).

This dynamic adjustment is conceptually the same feedback idea as MLFQ above — reward I/O-bound (likely interactive) behavior with higher priority, and penalize CPU-bound behavior by lowering it.

### 7. Completely Fair Scheduler (CFS) - Modern Linux Standard
*   **Philosophy**: Give each process a fair share of the CPU time by simulating an "Ideal Multi-tasking Processor."
*   **Mechanism**:
    *   **vruntime (Virtual Runtime)**: Tracks how much CPU time a process has received. Processes with the lowest `vruntime` are prioritized.
    *   **Red-Black Tree**: Instead of a traditional queue, CFS uses a Red-Black Tree (a self-balancing binary search tree) to store runnable processes, indexed by `vruntime`. This allows $O(\log N)$ time for both insertion and retrieval of the minimum element.
*   **Niceness**: "Nice" values (ranging from -20 to 19) act as weight multipliers, affecting how fast `vruntime` accumulates. Higher priority (lower nice value) makes `vruntime` grow slower, granting more CPU time.

---

## Scheduling in the Multi-Core Era

Scheduling becomes significantly more complex when multiple CPUs are available.

### 1. Processor Affinity
*   **Concept**: Keep a thread on the same processor to maximize **Cache Warmth**.
*   **Soft Affinity**: The OS attempts to keep a thread on the same CPU but may move it to balance load.
*   **Hard Affinity**: A thread is strictly pinned to a specific CPU or set of CPUs (e.g., via `sched_setaffinity` in Linux).

### 2. Load Balancing
*   **Push Migration**: A specific task (often a kernel thread) periodically checks the load on each processor and "pushes" threads from overloaded CPUs to idle ones.
*   **Pull Migration**: An idle processor "pulls" a waiting task from a busy processor's queue.

### 3. Hyperthreading (SMT)
*   Two logical CPUs share the same physical execution core. The scheduler must be aware of this to avoid placing two compute-heavy threads on the same physical core, which would lead to resource contention.

## Formal Definition

The following laws formalize the performance goals discussed above:

*   **Utilization Law**: $U = \text{Throughput} \times \text{Avg. Service Requirement}$.
*   **Little's Law**: $\text{Avg. Number in System} = \text{Throughput} \times \text{Avg. Response Time}$. Better response time implies fewer jobs in the system.
*   **Kleinrock's Conservation Law**: $\sum U_p \times R_p = \text{constant}$. Improving the response time ($R_p$) of one priority class requires degrading it for another.

## Simplified Explanation

*   **Utilization Law**: how busy the CPU is equals how many jobs come through times how long each one needs.
*   **Little's Law**: if jobs move through the system faster (better response time), fewer of them are sitting around waiting at any given moment — a crowded system is a slow system.
*   **Kleinrock's Conservation Law**: there's no free lunch in scheduling. If you make one class of jobs faster, some other class necessarily gets slower — the "unfairness budget" across all priority classes is a fixed pie, and favoring one always means taking from another.

## Related Concepts
- [[Process|Process]]
- [[CPU State|CPU State]]
- [[CPU State#Context Switch|Context Switch]]
- [[Process State|Process State]]
- [[State Queues|State Queues]]
- [[Process vs Thread|Process vs Thread]]
- [[swap space|Swap Space]]
- [[Operating Systems/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupts]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Quantum | Time slice |
| Priority Boost | Aging |
| Push/Pull Migration | Load balancing (SMP scheduler) |
| CFS | Linux default scheduler (`sched_fair` class) |
