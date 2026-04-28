# Processor Scheduling: Policies and Mechanisms

## Low-Level Primer: Policy vs. Mechanism
In Operating System architecture, CPU management is strictly divided:
*   **Policy (Scheduling)**: The high-level decision-making logic that determines *which* thread should run next and for *how long*.
*   **Mechanism (Switching)**: The low-level **[[Context Switch]]** code that saves/restores registers, switches stacks, and updates the **TLB**.

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
    *   **Decision**: Should a running program be temporarily marked as non-runnable and **swapped out** to disk?
    *   **Goal**: Control the degree of multiprogramming and free up physical memory.
3.  **Short-Term Scheduling (CPU Scheduling)**:
    *   **Decision**: Which thread gets the CPU next and for what duration?
    *   **Granular Decisions**: Which I/O operation to dispatch; **Processor Affinity** (considering cache state to avoid unnecessary cache misses on multi-processors).

## Performance Goals and Metrics
### Performance Metrics
*   **Maximize CPU Utilization**: Keep the processor busy 100% of the time.
*   **Maximize Throughput**: Complete the highest number of jobs per time unit.
*   **Minimize Avg. Response Time**: Time from submission to first visual/data response.
*   **Minimize Avg. Waiting Time**: Time spent sitting in the **Ready Queue**.
*   **Minimize Energy**: Measured in **Joules per instruction** (crucial for battery-constrained environments).

### Fairness
*   **Subjectivity**: No single definition of fair (per-user vs. per-thread).
*   **Starvation**: The state where a runnable thread is perpetually bypassed. Schedulers must avoid this.
*   **Intentional Unfairness**: **Priority Systems** favor specific classes of requests but must manage the risk of starvation.

## Preemption vs. Non-Preemption
*   **Non-Preemptive**: A thread holds the CPU until it voluntarily relinquishes it (e.g., I/O block or completion). This applies to I/O operations and memory allocation without swapping.
*   **Preemptive**: The OS can forcibly take the CPU away from a thread.
    *   **Timer Interrupt**: Allows preemption even if the thread does not yield.
    *   **Context Switch Overhead**: Reassignment always costs cycles that do not contribute to job progress.

## Fundamental Laws of Scheduling
*   **Utilization Law**: $U = \text{Throughput} \times \text{Avg. Service Requirement}$.
*   **Little's Law**: $\text{Avg. Number in System} = \text{Throughput} \times \text{Avg. Response Time}$. Better response time implies fewer jobs in the system.
*   **Kleinrock's Conservation Law**: $\sum U_p \times R_p = \text{constant}$. Improving the response time ($R_p$) of one priority class requires degrading it for another.

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
*   **Drawback**: High risk of **Starvation** for long jobs.

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
**Philosophy**: Workloads have **Increasing Residual Life** (the longer it has run, the longer it will likely continue to run). MLFQ aims to minimize response time for interactive jobs while also being fair to long-running compute jobs.

**The 5 Rules of MLFQ**:
1.  **Rule 1**: If Priority(A) > Priority(B), A runs (B doesn't).
2.  **Rule 2**: If Priority(A) = Priority(B), A & B run in Round Robin (RR) using the quantum of that level.
3.  **Rule 3**: When a job enters the system, it is placed at the highest priority (topmost queue).
4.  **Rule 4**: Once a job uses up its time allotment at a given level (regardless of how many times it has given up the CPU), its priority is reduced (it moves down one queue).
5.  **Rule 5**: After some time period *S*, move all the jobs in the system to the topmost queue (**Priority Boost**). This prevents starvation and allows CPU-bound jobs to become interactive again if their behavior changes.

**Mechanism**:
*   Hierarchy of queues with varying priority and quanta.
*   **Quanta Scaling**: Lower priority queues often have **longer quanta** to handle compute-bound tasks efficiently.

![[MLFQ.png]]
[Image: MLFQ hierarchy showing priority-based queue migration.]

### 6. UNIX Scheduling (Classical Implementation)
*   **Structure**: ~170 priority levels across **Real-Time**, **System**, and **Time-Sharing** classes.
*   **Mechanism**: Priority scheduling across queues, **Round Robin** within queues.
*   **Dynamic Adjustment**:
    *   **Increase Priority**: If a process blocks for I/O before its quantum ends.
    *   **Decrease Priority**: If a process consumes its entire quantum (compute-bound).

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

---

## Related Concepts
- [[Threads Overview]]
- [[Starvation]]
- [[Context Switch]]
- [[Thread Levels]]
- [[Process]]
- CPUState
- [[Interrupts]]
