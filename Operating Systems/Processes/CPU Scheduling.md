# CPU Scheduling

## 1. Scheduling Metrics
To evaluate a scheduler, we measure:
- **Turnaround Time**: Time from process submission to completion. ($T_{finish} - T_{arrival}$). Best for batch jobs.
- **Response Time**: Time from submission to the *first* time the process is scheduled. ($T_{first\_run} - T_{arrival}$). Critical for interactive apps.
- **Throughput**: Number of processes completed per unit of time.
- **CPU Utilization**: Percentage of time the CPU is busy.

---

## 2. Scheduling Algorithms

### Basic Policies
- **FIFO / FCFS**: First-In, First-Out. Simple but suffers from the **Convoy Effect** (short jobs stuck behind a long one).
- **SJF (Shortest Job First)**: Optimal for turnaround time. Impossible to implement perfectly because the kernel cannot predict the future CPU burst length.
- **Round Robin (RR)**: Runs each process for a **Scheduling Quantum** (time slice) and then moves it to the back of the queue. Great for response time but bad for turnaround.

### Multi-Level Feedback Queue (MLFQ)
The standard for modern interactive OSs (like Linux/macOS).
- **Heuristic**: If a process uses its entire time slice, it's likely CPU-bound $\to$ lower its priority. If it gives up the CPU early (for I/O), it's likely interactive $\to$ keep/raise priority.
- **Priority Boosting**: Periodically move all processes to the top queue to avoid **Starvation** of CPU-bound tasks.

---

## 3. Linux Completely Fair Scheduler (CFS)
CFS is the default Linux scheduler. It aims to divide CPU time equally among all processes.

### Virtual Runtime (vruntime)
- Instead of fixed time slices, CFS tracks the **vruntime** of each process (actual runtime normalized by weight).
- The scheduler always picks the process with the **minimum vruntime** to run next.

### Data Structure: Red-Black Tree
- CFS stores runnable processes in a **Red-Black Tree** indexed by `vruntime`.
- **Why?**: Finding the minimum is $O(1)$ (leftmost node), and insertions/deletions are $O(\log N)$, which scales better than a linked list for systems with thousands of threads.

### Nice Values
- Ranges from -20 (highest priority) to +19 (lowest priority). 
- A lower nice value increases a process's **weight**, causing its `vruntime` to increase more slowly, thus receiving more physical CPU time.

---

## 4. Multiprocessor & Cloud Considerations

- **CPU Affinity**: The tendency of a scheduler to keep a process on the same CPU to keep its cache "hot."
- **Work Stealing**: An idle CPU "steals" tasks from the runqueue of a busy CPU to balance the load.
- **NUMA (Non-Uniform Memory Access)**: In multi-socket systems, memory access to local RAM is faster than remote RAM. The scheduler should be **NUMA-aware**, placing threads near the memory they access.

## Related
- [[Process and Thread Fundamentals|Process & Thread State]]
