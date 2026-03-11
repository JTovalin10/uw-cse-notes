# Deadlock: Technical Analysis and Formal Reasoning

## Low-Level Primer: The Deadlock State
A **[[Deadlock]]** is a permanent, non-recoverable system state involving a set of **[[Threads]]** or processes. This state occurs when every member of the set is blocked because it is waiting for a resource that is currently held by another member of that same set. This creates a circular dependency chain where progress is mathematically impossible without external kernel-level intervention.

## The Four Necessary Conditions (Coffman Conditions)
For a **Deadlock** to be possible, all four of the following technical conditions must hold simultaneously. Breaking any single condition is the fundamental basis for **Deadlock Prevention**.

1.  **Mutual Exclusion**: At least one resource must be held in a non-sharable mode. Only one **[[Thread]]** can access the resource at any given time; any subsequent requester must wait.
2.  **Hold and Wait**: A **[[Thread]]** must be holding at least one resource while simultaneously waiting to acquire additional resources that are currently held by other threads.
3.  **No Preemption**: Resources cannot be forcibly taken from a **[[Thread]]**. They can only be released voluntarily by the holder after the task is completed.
4.  **Circular Wait**: A closed chain of threads $\{T_1, T_2, \dots, T_n\}$ exists such that $T_1$ is waiting for a resource held by $T_2$, $T_2$ is waiting for $T_3$, and $T_n$ is waiting for $T_1$.

## Resource Allocation Graphs (RAG)
**Resource Allocation Graphs** are a formal method used to visualize the state of threads and reason about the presence of deadlocks.

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
Strategies are broadly classified into three categories, each aiming to eliminate or manage the four conditions:

| Strategy | Methodology | Implementation Details |
| :--- | :--- | :--- |
| **Prevention** | Design the system to ensure at least one Coffman condition cannot hold. | **Hierarchical Locking** (prevents Circular Wait); **Atomic Acquisition** (prevents Hold and Wait). |
| **Avoidance** | Dynamically evaluate every request to ensure the system never enters an "Unsafe State." | Uses a priori knowledge of maximum resource needs. |
| **Detection & Recovery** | Periodically scan for cycles and forcibly break them if found. | **Cycle Detection Algorithms**; Thread termination or resource preemption. |

![[Resource Allocation Deadlock.png]]
[Image: Detailed diagram of resource contention leading to a deadlock.]
### Prevention
Applications must conform to behaviors guaranteed not to deadlock
- eliminating hold and wait
	- each thread obtains all resources at the beginning
	- block until all are available
		- drawbacks
			- you may not know how many lock you need or which you need
			- 
- eliminating circular wait
	- obtain the lock in ascending or descending order (assume each lock is numbered)
	- resources are numbered
	- each thread obtains resources in sequence order
		- why does this work
		- pros
		- cons
### Avoidance
Less severe restrictions on program behavior
- eliminating circular wait
	- each thread states it maximum claim for every resource type
	- system runs the **Banker's Algorithm** at each allocation request
		- can someone make progress (at least 1)
		- banker is very conservative
		- if i were to allocate you that resource, and then everyone were to request their maximum claim for every resource, could I find a way to allocate remaining resources so that everyone finished?
### Detect and Recover
- every once in a while. check ot see if there's a deadlock
	- how
		- identify stuck threads
		- look for cycles
		- dont get spoofed
- if so, elimate it
	- how
		- reboot?
		- choose a victim to restart
## Debugging Deadlocks
in Windows there are four suspects:
1. spinlock
2. Semaphore
3. Mutex (binary semaphore)
4. EResource (Reader/Writer lock)
### What's in our favor
- once the system is deadlock, it doesn't go away. You can then walk through all the locks on the system and all the threads on the system and see what each thread owns and what it is waiting on
- this requires the ability to identify the owner's of a lock. Having their return address when hey racquire the lock also helps
- once you draw a graph. you have a deadlock
- often the harder part is figuring out how to avoid the deadlock
### What didn't work well
- mutex levels. In theory they avoided deadlocks but in practice they were too cumbersome to use, and deadlocks were still possible when mixed with other kinds of locks.
## Graph Reduction and Formal Theorems
**Graph Reduction** is an algorithmic process used to detect if a system state is deadlocked by simulating thread completion.

### The Reduction Process
1.  A graph can be reduced by a **[[Thread]]** if all of its current resource requests can be granted.
2.  If reducible, the thread is assumed to eventually terminate and release all held resources.
3.  The released resources are added to the available pool, potentially enabling further reductions.

### Foundational Theorems
*   **Holt's Theorem**: A set of threads is **not deadlocked** if and only if the Resource Allocation Graph is **completely reducible**.
*   **Havender's Theorem**: Imposing a linear ordering on resource types and requiring requests in that order prevents the **Circular Wait** condition.
*   **Reduction Invariance**: The **order of reductions is irrelevant**. If a graph is reducible, any sequence of valid reductions will result in a completely reduced graph.
