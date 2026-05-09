# CSE452: Memory Consistency

A **Memory Consistency Model** (MCM) specifies the rules for how memory operations (reads and writes) to a shared memory system appear to different processors or nodes. It is a **contract** between the hardware/system builder and the software programmer. At the hardware level it governs CPU instruction reordering; at the distributed level it governs replica update propagation. See [[CSE452/Consistency/Definitions/Memory Consistency Model|Memory Consistency Model (definition)]] for the concise glossary entry.

---

---

## Architectural Models

In Distributed Systems, "memory" is often a distributed key-value store or a replicated state machine. How we architect this affects consistency. These architectural patterns are the implementation substrate that the various [[CSE452/Consistency/Consistency|consistency models]] are built on top of.

### 1. Central Store
The simplest theoretical model where a single, central node holds the authoritative state for all participating nodes.
- **Mechanics**: Every read and write request from any node in the system must travel to this central point.
- **Pros**: Perfectly **Strong Consistency** is easy to maintain because there is only one copy of data.
- **Cons**: 
    - **Performance Bottleneck**: The central node's CPU and Network Interface become a massive point of contention as the number of clients grows.
    - **Single Point of Failure**: If the central node crashes, the entire "memory" of the system is lost or inaccessible.
![[CSE452/Screenshots/Central Store.png]]

### 2. Replicated Store
Data is copied across multiple physical nodes to improve read throughput and provide fault tolerance.
- **Mechanics**: Writes must be propagated to multiple replicas (either synchronously or asynchronously).
- **Synchronous Replication**: Wait for all (or a majority) of replicas to ACK before responding to the client. Provides **Strong Consistency** but high write latency.
- **Asynchronous Replication**: Respond after writing to one node, then propagate in the background. Provides low latency but results in **Weak/Eventual Consistency** (stale reads).
![[CSE452/Screenshots/Replicated Store.png]]

### 3. Caching and Sharding
This model combines local optimization with global scalability.

#### Caching (Local Optimization)
Nodes keep local copies of frequently accessed data to avoid network round-trips.
- **Cache Coherence**: The system must decide how to handle updates. 
    - **Write-Through**: Write to local cache and the underlying store simultaneously.
    - **Write-Back**: Write to local cache and only update the store later (faster, but riskier).
- **Invalidation Protocols**: When data changes at the source, all cached copies must be "invalidated" (marked as dirty) to prevent stale reads.
![[CSE452/Screenshots/replicated store with caching.png]]

#### Sharding (Horizontal Scaling)
The data is partitioned (sharded) across different nodes based on a key (e.g., UserID).
- **Scalability**: Allows the system to handle more data than any single node could store.
- **Complexity**: Cross-shard operations (like moving money between two users on different shards) require complex **Distributed Transactions** (e.g., Two-Phase Commit) to maintain consistency across shards. See [[CSE452/Consistency/Distributed Cache Coherence#Sharding (Partition-Based)|Distributed Cache Coherence: Sharding]] for how partition-based coherence eliminates the duplication problem entirely.
![[CSE452/Screenshots/Replicated store with Caching and Sharding.png]]

### 4. Geo-Replication
Replicating data across different geographic regions (e.g., Seattle, Tokyo, London).
- **Latency & Speed of Light**: It takes ~100ms for a packet to cross the Pacific. Geo-replication allows users to read from a local data center at <10ms.
- **Follow-the-Sun**: Shifting traffic and primary roles to regions currently in their peak daytime hours.
- **Conflict Resolution**: Since updates can happen simultaneously in different regions, systems must use **Conflict-free Replicated Data Types (CRDTs)** or **Last-Write-Wins (LWW)** to resolve state when regions sync. This is a practical application of [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual Consistency]]: regions diverge during the inter-sync window and converge once replication catches up.
- **CAP implication**: Geo-replicated systems almost always choose [[CSE452/Consistency/Definitions/CAP Theorem|AP]] — they accept stale reads locally to avoid the untenable latency of cross-continental consensus on every write. See [[CSE452/Consistency/CAP Theorem and Partitions|CAP Theorem and Partitions]] for the trade-off analysis.
![[CSE452/Screenshots/GeoReplication.png]]

---

---

## Hardware Models

### The Motivation: Out-of-Order Execution

Modern processors and compilers reorder instructions to improve performance. While this is invisible to a single-threaded program, it can lead to surprising results (anomalies) in concurrent systems. Two threads running on different cores may observe the same sequence of memory writes in different orders if no synchronization mechanism is used. This is exactly the same class of problem as distributed replication — except the "network" is the CPU cache hierarchy instead of an ethernet cable. This fundamental behavior is why we need hardware-level consistency contracts, and it is the conceptual foundation for understanding the weaker distributed models like [[CSE452/Consistency/Definitions/FIFO Consistency|FIFO Consistency]] and [[CSE452/Consistency/Definitions/Processor Consistency|Processor Consistency]].

### Total Store Order (TSO)

The model used by **x86-64** processors. It is a "strong" hardware model compared to ARM's weaker default.
- **The Store Buffer**: CPUs use a local write buffer to hold stores so the processor can continue executing while the write propagates to the shared cache/bus. This is the hardware analog of asynchronous replication.
- **Read-Before-Write**: A processor is allowed to execute a **Read** before an earlier **Write** *only if* they target different addresses. A read to the same address is forwarded directly from the store buffer (self-consistency).
- **Self-Consistency**: A processor always sees its own writes immediately (by checking its own store buffer first), but other processors see them only after the write drains from the buffer to the shared cache.
- **Invariant**: Writes from a single core always appear to all other cores in the same order. This per-processor ordering guarantee is what the [[CSE452/Consistency/Definitions/Processor Consistency|Processor Consistency]] distributed model is modeled after.
- **Hardware Fence (MFENCE/SFENCE)**: To enforce global ordering across all cores, software must insert explicit memory fence instructions, which drain the store buffer before any subsequent read proceeds.

### Release Consistency (Acquire/Release)

A common synchronization discipline in high-level concurrent programming (C++, Java, Rust atomics).
- **Acquire (on Reads)**: "I need to see everything that happened before the corresponding Release." It prevents subsequent reads/writes from being moved *before* the acquire in program order.
- **Release (on Writes)**: "Everything I did before this is now visible to anyone who performs an Acquire." It prevents preceding reads/writes from being moved *after* the release.
- **Efficiency**: Allows the CPU to reorder operations aggressively *between* synchronization points, only inserting barriers at the acquire/release boundaries.
- **Distributed analogy**: This is structurally similar to [[CSE452/Consistency/Definitions/Causal Consistency|Causal Consistency]] — it enforces ordering only along the edges of the happens-before graph (the acquire/release pairs), not globally.

---

---

## Consistency Levels

1. **Strong Consistency**: The system behaves as if there is only a single copy of data. Every read returns the result of the most recent write. In hardware terms, this requires all stores to be globally visible before the next load; in distributed terms, this requires [[CSE452/Consistency/Definitions/Linearizability|Linearizability]].
2. **Weak Consistency**: Allows memory operations to be reordered for performance, provided they don't violate local program dependencies. Weak consistency in hardware maps to the relaxed models used on ARM processors.
3. **Eventual Consistency**: A specific form of weak consistency where, if no new updates are made, eventually all accesses will return the last updated value. See [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual Consistency]] for the distributed-system definition.

These map directly onto the strength hierarchy described in [[CSE452/Consistency/Consistency|Consistency]]:
$$\text{Strong} \rightarrow \text{Linearizable} \quad \text{Weak} \rightarrow \text{Sequential/Causal/FIFO} \quad \text{Eventual} \rightarrow \text{Eventual}$$

---

## Trade-offs

| Factor | Strong Consistency | Weak Consistency |
| :--- | :--- | :--- |
| **Performance** | Low (High coordination cost) | High (Hides latency) |
| **Availability** | Lower (Requires consensus) | Higher (Always responds) |
| **Programmability** | **Easy**: Reason like a single-threaded program. | **Hard**: Programmer must manually insert fences and reason about data races. |

---

# Examples

## C++ Snippets for Memory Barriers
Using `<atomic>` to enforce memory ordering:

### Example 1: Using Explicit Fences
```cpp
#include <atomic>
#include <thread>
#include <cassert>

std::atomic<int> data(0);
std::atomic<int> ready(0);

void producer() {
    // Non-atomic store (data)
    data.store(42, std::memory_order_relaxed); 
    
    // Release fence ensures 'data' store is visible BEFORE 'ready' store
    std::atomic_thread_fence(std::memory_order_release); 
    
    ready.store(1, std::memory_order_relaxed);
}

void consumer() {
    // Wait until ready is 1
    while (ready.load(std::memory_order_relaxed) == 0);
    
    // Acquire fence ensures subsequent loads see what was visible at release
    std::atomic_thread_fence(std::memory_order_acquire);
    
    // Guaranteed to be 42
    assert(data.load(std::memory_order_relaxed) == 42);
}
```

### Example 2: Using Acquire/Release Semantics
Alternatively, using **Acquire/Release semantics** directly on the atomic operations:

```cpp
void producer_v2() {
    data.store(42, std::memory_order_relaxed);
    // Store with release semantics
    ready.store(1, std::memory_order_release); 
}

void consumer_v2() {
    // Load with acquire semantics
    while (ready.load(std::memory_order_acquire) == 0);
    assert(data.load(std::memory_order_relaxed) == 42);
}
```

---

---

## Related
- [[CSE452/Consistency/Linearizability and Sequential Consistency|Linearizability and Sequential Consistency]] — the distributed-level strong consistency models built on these hardware foundations
- [[CSE452/Consistency/Distributed Cache Coherence|Distributed Cache Coherence]] — how cache coherence extends from single-node to distributed systems
- [[CSE452/Consistency/CAP Theorem and Partitions|CAP Theorem and Partitions]] — the theoretical limits governing consistency vs. availability trade-offs
- [[CSE351/Memory and Data/x86-64 Programming|x86-64 Programming]] — x86-64 instruction set and TSO in practice
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks|Locks]] — OS-level synchronization primitives that rely on hardware memory ordering
