# CSE452: Memory Consistency Model

A **Memory Consistency Model** (MCM) specifies the rules for how memory operations (reads and writes) to a shared memory system appear to different processors or nodes. It is a **contract** between the hardware/system builder and the software programmer.

## The Problem: Out-of-Order Execution
Modern processors and compilers reorder instructions to improve performance. While this is invisible to a single-threaded program, it can lead to surprising results (anomalies) in concurrent systems.

---

## Architectural Models

### Central Store
The simplest model: a single source of truth for all nodes.
![[CSE452/Screenshots/Central Store.png]]

### Replicated Store
Data is copied across multiple nodes to improve availability and read performance.
![[CSE452/Screenshots/Replicated Store.png]]

### Caching and Sharding
- **Caching**: Nodes keep local copies of frequently accessed data.
  ![[CSE452/Screenshots/replicated store with caching.png]]
- **Sharding**: Data is partitioned across different nodes to improve write throughput.
  ![[CSE452/Screenshots/Replicated store with Caching and Sharding.png]]

### Geo-Replication
Replicating data across different geographic regions (e.g., Seattle, Tokyo).
![[CSE452/Screenshots/GeoReplication.png]]

---

## Consistency Levels


### 1. Strong Consistency
The system behaves as if there is only a single copy of data. Every read returns the result of the most recent write.
- **What this means**: If Processor A writes `x = 1`, any processor reading `x` immediately after (in real-time) *must* see `1`.
- **Implementation**: Requires heavy synchronization (e.g., bus locking, cache coherence protocols like MESI).

### 2. Weak Consistency
Allows memory operations to be reordered for performance, provided they don't violate local program dependencies.
- **Example**: A processor might execute a read before a preceding write if they are to different addresses.
- **Why?**: Hiding memory latency. Waiting for a write to propagate to all caches is slow; the processor would rather continue with unrelated work.

### 3. Eventual Consistency
A specific form of weak consistency where, if no new updates are made to an object, eventually all accesses will return the last updated value.
- **Temporary Anomalies**: During the "window of inconsistency," different nodes might see different values. For example, in a Geo-Replicated system, a user in Seattle might see a post that a user in Tokyo cannot see yet due to light-speed propagation delays.

---

## Hardware Models

### Total Store Order (TSO)
The model used by **x86-64** processors. 
- Writes from a single processor are seen by all other processors in the same order they were issued.
- However, a processor might see its own writes before others do (due to local store buffers).
- **Invariant**: Reads cannot be reordered with other reads; writes cannot be reordered with other writes. But a **Read can be reordered before an earlier Write** to a different location.

### Release Consistency (Acquire/Release)
A common model in C++11 and higher-level languages.
- **Acquire**: A read operation that prevents following memory operations from being moved before it.
- **Release**: A write operation that prevents preceding memory operations from being moved after it.
- Used to implement [[CSE451/Concurrency/Synchronization/Mechanics/Locks|Locks]]: `lock()` is an Acquire, `unlock()` is a Release.

---

## Memory Barriers (Fences)
A **Memory Barrier** is a hardware instruction that enforces ordering constraints on memory operations.
- `MFENCE` (Memory Fence): Ensures all load and store instructions preceding the fence are globally visible before any instructions following the fence.
- **Use Case**: Necessary when implementing low-level synchronization primitives like spinlocks or dekker's algorithm.

---

## Trade-offs

| Factor | Strong Consistency | Weak Consistency |
| :--- | :--- | :--- |
| **Performance** | Low (High coordination cost) | High (Hides latency) |
| **Availability** | Lower (Requires consensus) | Higher (Always responds) |
| **Programmability** | **Easy**: Reason like a single-threaded program. | **Hard**: Programmer must manually insert fences and reason about data races. |

> [!NOTE]
> **Why is Weak Consistency "Harder"?**
> Without strong consistency, the "happens-before" relationship is not guaranteed by the system. A programmer might write code that works on their local machine but fails on a multi-core server because the hardware reordered a flag write before a data write, causing a race condition.

---

## Related
- [[CSE452/Consistency/Linearizability and Sequential Consistency|Linearizability and Sequential Consistency]] — the distributed version of these concepts
- [[CSE351/Memory and Data/x86-64 Programming|x86-64 Programming]] — the instruction set architecture where TSO is defined
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks|Locks]] — how software uses these models to ensure safety
- [[CSE484/Side Channel Attacks/Spectre|Spectre]] — how out-of-order execution can be exploited for security attacks
