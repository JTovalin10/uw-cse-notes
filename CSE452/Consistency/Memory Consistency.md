# CSE452: Memory Consistency Model

A **Memory Consistency Model** (MCM) specifies the rules for how memory operations (reads and writes) to a shared memory system appear to different processors or nodes. It is a **contract** between the hardware/system builder and the software programmer.

---

## Architectural Models
In Distributed Systems, "memory" is often a distributed key-value store or a replicated state machine. How we architect this affects consistency.

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
- **Complexity**: Cross-shard operations (like moving money between two users on different shards) require complex **Distributed Transactions** (e.g., Two-Phase Commit) to maintain consistency.
![[CSE452/Screenshots/Replicated store with Caching and Sharding.png]]

### 4. Geo-Replication
Replicating data across different geographic regions (e.g., Seattle, Tokyo, London).
- **Latency & Speed of Light**: It takes ~100ms for a packet to cross the Pacific. Geo-replication allows users to read from a local data center at <10ms.
- **Follow-the-Sun**: Shifting traffic and primary roles to regions currently in their peak daytime hours.
- **Conflict Resolution**: Since updates can happen simultaneously in different regions, systems must use **Conflict-free Replicated Data Types (CRDTs)** or **Last-Write-Wins (LWW)** to resolve state when regions sync.
![[CSE452/Screenshots/GeoReplication.png]]

---

## Hardware Models

### The Motivation: Out-of-Order Execution
Modern processors and compilers reorder instructions to improve performance. While this is invisible to a single-threaded program, it can lead to surprising results (anomalies) in concurrent systems. This fundamental behavior is why we need hardware-level consistency contracts.

### Total Store Order (TSO)
The model used by **x86-64** processors. It is a "Strong" hardware model compared to ARM.
- **The Store Buffer**: CPUs use a local buffer to hold writes so the processor can continue working while the write propagates to the cache/bus.
- **Read-Before-Write**: A processor is allowed to execute a **Read** before an earlier **Write** *only if* they are to different addresses.
- **Self-Consistency**: A processor always sees its own writes immediately (by checking its own store buffer), but other processors see them later.
- **Invariant**: Writes from a single core always appear to all other cores in the same order.

### Release Consistency (Acquire/Release)
A common model in high-level concurrent programming (C++, Java, Rust).
- **Acquire (on Reads)**: "I need to see everything that happened before the corresponding Release." It prevents subsequent reads/writes from being moved *before* the acquire.
- **Release (on Writes)**: "Everything I did before this is now visible to anyone who performs an Acquire." It prevents preceding reads/writes from being moved *after* the release.
- **Efficiency**: Allows the CPU to reorder operations aggressively *between* synchronization points.

---

## Consistency Levels
1. **Strong Consistency**: The system behaves as if there is only a single copy of data. Every read returns the result of the most recent write.
2. **Weak Consistency**: Allows memory operations to be reordered for performance, provided they don't violate local program dependencies.
3. **Eventual Consistency**: A specific form of weak consistency where, if no new updates are made, eventually all accesses will return the last updated value.

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

## Related
- [[CSE452/Consistency/Linearizability and Sequential Consistency|Linearizability and Sequential Consistency]]
- [[CSE351/Memory and Data/x86-64 Programming|x86-64 Programming]]
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks|Locks]]
