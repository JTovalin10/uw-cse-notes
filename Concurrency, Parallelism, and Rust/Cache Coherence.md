# Concurrency, Parallelism, and Rust: Cache Coherence

## Why Coherence

- Recall that each core has its own cache (L1 and L2) (see [[Concurrency, Parallelism, and Rust/Threads and Cores/Cache Topology and Scheduler Queues|Cache Topology and Scheduler Queues]]).
- **Cache coherence** keeps the private copies in agreement.
- We don't want inconsistency between the copies.

![[Cache Coherence Memory Model.png]]

- Keep this memory model in mind.

---

## Inside the Cache

- Caches are stored in **blocks**.
  - In most architectures the cache block is 64 bytes, and Apple's is 128 bytes.

![[Cache and Memory.png]]

- You can think of a cache as a set of lines, each holding a block. Each line needs metadata for bookkeeping:
  - **valid**: is the line's data usable, or out of date?
  - **dirty**: has the cache line been written to?
  - **tag**: which block does the line belong to?
- **Write-back**: a write changes the cached line (now dirty); memory is updated later, when the dirty block is evicted (a "write-back").
- **Write-allocate**: a write to a block not in the cache first reads the block in.

See [[Hardware & Software Interface/Cache/Cache Organization|Cache Organization]] for how lines are laid out.

---

## Without Coherence

![[without coherence exmaple.png]]

- Both caches have a copy of `x`, and so does memory.
- Core 0 writes `x = 5`. This only changes its local copy, and memory still has 0 (write-back).
- Core 1 reads `x`: a hit in its own copy, so it gets the stale 0.
- A lock would not help, as the lock's own state is cached the same way.

---

## What Coherence Guarantees

For each memory location:

- **Write propagation**: every write is eventually seen by every core's later reads.
- **Write serialization**: all cores see the writes to that location in the same order.
- **One location only**: coherence says nothing about the order in which a core sees writes to two different locations. That is **memory consistency** (see [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Memory Reordering and Fences|Memory Reordering and Fences]] and [[Datacenter Systems/Server Memory Systems/Memory Consistency and Cache Coherence|Memory Consistency and Cache Coherence]]).

---

## MSI: Three States Per Copy

- Each cache keeps a state per line.
- The rule of thumb: **one writer or many readers**.

![[MSI.png]]

- **M (Modified)**
  - No other cache has a valid copy.
  - May differ from memory, as we can write to it.
  - Reads and writes allowed.
- **S (Shared)**
  - One of possibly many copies.
  - Matches memory, as we are only reading.
  - Reads only.
- **I (Invalid)**
  - No valid copy.
  - Don't use it for an access.

---

## Snooping: Every Cache Watches a Bus

- We need to tell the others what we are doing.
- Caches must also listen, to check what they need to adjust.
- A cache holding the line in M answers a `BusRd` or `BusRdX` by **flushing**: it sends the data on the bus, and memory is updated at the same time.

![[Memory Bus Requests.png]]

- When writing, we change our state to M. This can leave the main memory copy out of date, but because we notify the bus that the line is modified, we know the value is invalid at the other cores.
  - `BusUpgr` asks the others to invalidate their copies.
- Like in any cache, if the item is not in the cache we have a miss and must fetch it from main memory.
- When another core issues a read request, the cache holding the line in M must flush and then change its state to S.
  - The M-state core hears that someone wants to read, so it flushes to update main memory, letting the other core get the correct value, and downgrades to S.

### MSI as a State Machine

![[MSI as a state machine.png]]

---

## Snooping Doesn't Scale

- Every request goes to every cache, and only one request is handled at a time.
- With many cores, the bus becomes the bottleneck.
- **Directory**: keep, for each block, which caches have it and in what state, and send messages only to those caches.
- Snooping and directories enforce the same states. They differ in who finds out: everyone, or only the caches the directory names.

### Snooping or Directory

| | Snooping | Directory |
|---|---|---|
| Hardware | Simpler | Extra storage |
| Latency | Fewer hops: lower latency | Extra hops |
| Who hears a request | Every cache | Only the caches the directory names |
| Scaling | Bus is the bottleneck | Scales to many cores; no shared bus to wait for |

- Real chips mix them: snooping inside a group of cores, plus **snoop filters** (a small directory) that skip caches known not to hold the block.

![[Read with directory.png]]

---

## MESI: An Exclusive State

- A common case: `x += 1` on data no other core is using. It reads `x`, then writes it.
- In MSI, that read-then-write sends two requests: `BusRd`, then `BusUpgr`.
- **E (Exclusive)**: no other cache has a valid copy, and it matches memory.
  - A read miss when no other cache has a valid copy gets E.
  - A write to E becomes M silently: no bus request.
  - Another core's read turns E into S.
- MESI reduces the traffic on the memory bus.

---

## More States

![[More States.png]]

- **O (Owned)**, in MOESI: the owner keeps a modified line while others share it, and writes it back later. There is no write-back on every read by another core.
- **F (Forward)**, in MESIF: of the shared copies, one is chosen to answer requests, so several caches don't answer at once.

---

## Coherence Costs Time

- We can have **false sharing** (see [[Concurrency, Parallelism, and Rust/Threads and Cores/False Sharing|False Sharing]]).
- We can save some time with padding, but at the cost of space.

---

## Coherence Is Not Atomicity

- Coherence orders the writes to `x`. It doesn't make a read and a write one step: that needs an atomic read-modify-write or a lock (see [[Concurrency, Parallelism, and Rust/Implementing Threads/Implementing Threads#Atomic Read-Modify-Write Instructions|Atomic Read-Modify-Write Instructions]] and [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Mutual Exclusion Locks|Mutual Exclusion Locks]]).

---

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores/False Sharing|False Sharing]]: invalidation mechanics and cache line padding
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Cache Topology and Scheduler Queues|Cache Topology and Scheduler Queues]]
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Memory Reordering and Fences|Memory Reordering and Fences]]: consistency vs coherence
- [[Datacenter Systems/Server Memory Systems/Memory Consistency and Cache Coherence|Memory Consistency and Cache Coherence]]
- [[Hardware & Software Interface/Cache/Cache Organization|Cache Organization]]

## Industry Standard Terms

- **Snooping** → bus-based (snoopy) coherence protocol
- **Directory** → directory-based coherence protocol
- **Flush** → write-back / cache-to-cache transfer
- **`BusRd` / `BusRdX` / `BusUpgr`** → read / read-for-ownership (RFO) / upgrade request
- **Snoop filter** → partial directory
- **MSI / MESI / MOESI / MESIF** → invalidation-based coherence protocols
- **Write propagation / write serialization** → the two coherence invariants

## Sources

- *A Primer on Memory Consistency and Cache Coherence* (2nd ed., 2020), ch. 6 to 8
- *What Every Programmer Should Know About Memory* (2007), section 3.3
