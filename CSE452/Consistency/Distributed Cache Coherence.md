# CSE452: Distributed Cache Coherence

**Cache Transparency Invariant**: A correct caching layer must behave as if the cache does not exist. From the program's perspective, correctness is unchanged — the cache only affects performance (latency), not the result. Not knowing a cache is present is fine; the program may only run slower.

---

## Single-Core (Single Node)

```
CPU1 → L1 → L2 → L3 (shared) → RAM (shared) → Disk (shared)
```

In a single-core system, there is only ever one reader and one writer of cached data. This makes cache coherence trivial: since only one agent touches the cache, all writes and reads are totally ordered by default.

Two write policies handle propagating changes down the memory hierarchy:
- **Write-through**: Every write to the cache is immediately propagated to the next level (RAM). Guarantees that RAM always reflects the most recent value, at the cost of high bus traffic.
- **Write-back**: Writes are held in the cache and only flushed to RAM when the cache line is evicted. A **dirty bit** marks lines that have been modified. Much more efficient for write-heavy workloads, but RAM may be stale at any instant.

See: [[CSE351/Cache/Handling Writes|CSE351: Write-Hit and Write-Miss Policies]] for the detailed mechanics and common policy combinations.

---

## Multi-Core (Single Node)

```
CPU1 → L1 → L2 ↘
                  L3 (shared) → RAM (shared) → Disk (shared)
CPU2 → L1 → L2 ↗
```

With multiple cores, each CPU has its own private L1 and L2 caches, but they share L3 and RAM. This creates the **cache coherence problem**: CPU1 and CPU2 may both cache a copy of the same memory address, and if one modifies it, the other's copy becomes stale.

### Cache Coherence Protocol

The hardware solution is a **cache snooping** protocol over a shared **memory bus**:
- All caches monitor (snoop) every transaction on the memory bus.
- When CPU1 wants to write to address `X`, it first announces this on the bus.
- Every other cache that holds a copy of `X` sees this announcement and **invalidates** its copy.
- CPU1 is now the sole valid owner and can proceed with the write.

This is called a **write-invalidate** protocol: before writing, you invalidate all other copies so there is only one authoritative version. The alternative — **write-update** — broadcasts the new value to all caches rather than invalidating them, but this consumes significantly more bus bandwidth in practice.

The [[CSE452/Consistency/Memory Consistency|Memory Consistency]] model (specifically **TSO** on x86-64) governs the ordering constraints these hardware caches must respect at the instruction level.

---

## Distributed Cache

In a distributed system, nodes are separate machines connected by a network. We place caches close to users to reduce latency and avoid repeatedly fetching data from a distant central store. However, the absence of a shared memory bus means we cannot snoop — we need a different coherence protocol.

Three main approaches exist, each with distinct trade-offs:

### 1. Write-Through Caching

The flow for a client write:
1. Client sends a write to its nearby cache.
2. Cache forwards the write to the authoritative server.
3. Server executes the write and responds to the cache.
4. Cache (or server) sends invalidations to all other caches that hold a copy.
5. Once all caches acknowledge the invalidation, the original cache responds to the client.

**Why coordinate all caches before responding?** Because [[CSE452/Consistency/Definitions/Linearizability|Linearizability]] requires that any read issued after a write completes must see that write. If another cache still holds the old value and responds to a read before receiving the invalidation, the linearizable guarantee is violated.

**Failure cases this approach must handle**:
- **Dropped messages during invalidation**: The cache must use reliable delivery (retries, ACKs) to ensure every cache receives the invalidation. See: [[CSE452/RPC/Remote Procedure Call (RPC)|RPC at-least-once semantics]].
- **Cache failure mid-coordination**: If a cache crashes after forwarding to the server but before receiving all ACKs, the write may be partially visible. Recovery requires the server to re-invalidate on reconnect.
- **Scalability cost**: Coordinating all caches before each write means write latency scales with the number of caches — intolerable in geo-distributed systems with dozens of cache nodes.

### 2. Server-Side Invalidation

An alternative where **writes go directly to the server**, and the server is responsible for invalidating stale cache entries:
- The server maintains a **directory**: a mapping from each key to the set of caches currently holding it.
- On a write, the server applies the update and then sends invalidation messages to every cache in the directory entry for that key.
- Caches respond with ACKs; the server removes those entries from the directory.

**Advantage over write-through**: The server is the authoritative source and knows exactly which caches need to be invalidated, without caches needing to know about each other. The coherence protocol is centralized at the server.

**Downside**: The server is still the write bottleneck. A write-heavy workload means the server spends most of its time sending invalidations rather than serving requests.

### 3. Sharding (Partition-Based)

Instead of replicating data across many caches and solving the coherence problem, **partition** (shard) the data so each key lives in exactly one cache. With no duplication, there is no coherence problem:
- Each client determines which cache owns a given key (e.g., via consistent hashing) and contacts it directly.
- That owning cache handles writes and reads for its partition autonomously.

**Trade-offs**:
- **Eliminates coherence overhead entirely**: Each key has exactly one owning cache, so there is nothing to coordinate.
- **Loses geographic proximity**: If the cache owning a key is in a different data center from the client, the latency benefit of caching disappears. Sharding prioritizes scalability over locality.
- **Client routing complexity**: Clients must know (or discover) which cache to contact for a given key, usually via a **consistent hashing ring** or a directory lookup service.

See: [[CSE452/Consistency/Memory Consistency#Caching and Sharding|Memory Consistency: Caching and Sharding]] for how this fits into the broader distributed memory architecture.

---

## Linearizable Caching

### Formal Definition
A distributed cache is **linearizable** if every read returns the value of the most recent completed write, and all operations appear to occur atomically at a single point in wall-clock time, consistent with real-time ordering.

### Simplified Explanation
No cache is allowed to return a stale value. If any client wrote a new value and that write completed, every subsequent read from any cache anywhere must return that new value.

**What this requires**: Before a cache can respond to a read, it must verify that no invalidation for that key is in-flight. This means coordinating with all nodes that may hold a copy on every write operation — or holding a validated lease that proves ownership (see Performance section below).

**The read-heavy insight**: The more reads a workload has relative to writes, the cheaper linearizability becomes. Reads do not trigger invalidations — only writes do. When a cache holds a valid copy and no write has occurred, it can serve many consecutive reads without any coordination overhead. A 99%-read workload can linearize at nearly the cost of not linearizing at all, since the coordination penalty only fires on the rare writes.

---

## Performance Impacts of Caching

A linearizable distributed cache has terrible performance under write-heavy workloads. Each write forces a global coordination round across all caches, driving up latency and consuming network bandwidth proportional to the number of cache replicas.

The core trade-off: accept **stale reads** in exchange for lower latency. This weakens the consistency guarantee from [[CSE452/Consistency/Definitions/Linearizability|Linearizable]] toward [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual Consistency]] — the cache is allowed to serve data that was accurate at some point in the recent past, but may not reflect the absolute latest write.

### Leases

A **lease** is a mechanism for granting a cache **timed, exclusive ownership** of a key. It allows the cache to serve reads without consulting the server, bounded by the lease duration — a form of timed coherence guarantee.

**Protocol**:
1. A cache requests ownership of key `K` from the server.
2. The server grants a lease for duration `T` (typically seconds) and records this cache as the current leaseholder for `K`.
3. While the lease is valid, the leaseholder is the sole authoritative reader for `K` — it can answer reads directly without a round-trip to the server.
4. The server will not grant a conflicting write or issue a new lease for `K` to another node until the current lease expires.
5. When a write to `K` arrives at the server, it waits for the current lease to expire (or for the leaseholder to voluntarily release early) before accepting the write and granting a new lease.

**Fault Tolerance**: If the leaseholder crashes, the server simply waits for the lease TTL to expire before granting a new one. No crash-detection protocol is required — the lease expiry is self-healing, at the cost of temporary unavailability bounded by `T`. This is why lease durations are kept short (seconds, not minutes).

**Why this helps performance**: Between lease acquisition and expiry, the leaseholder is guaranteed to hold the most recent value. No other cache can accept a write to `K` during this window, so reads are linearizable within the lease period *without* per-read coordination. The cache is free to execute reads as fast as it can.

---

## Related
- [[CSE351/Cache/Handling Writes|CSE351: Write-Through and Write-Back Policies]]
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]]
- [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual Consistency]]
- [[CSE452/Consistency/Memory Consistency|Memory Consistency and Caching Architectures]]
- [[CSE452/RPC/Remote Procedure Call (RPC)|RPC Semantics (at-least-once / at-most-once)]]
- [[CSE452/Consistency/CAP Theorem and Partitions|CAP Theorem]] — consistency vs. availability trade-off underlying these design choices
