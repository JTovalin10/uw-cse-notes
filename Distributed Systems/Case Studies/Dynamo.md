# Distributed Systems: Dynamo

**Dynamo** is Amazon's highly available, eventually consistent key-value store. It was designed to provide "always-on" write availability for services like the shopping cart, prioritizing availability over strong consistency.

---

## Core Philosophy: Availability > Consistency

In the context of the **[[Distributed Systems/Consistency/Theoretical Foundations|CAP Theorem]]**, Dynamo chooses **Availability** and **Partition Tolerance** (AP) over **Consistency** (CP). 

### Business Motivation
- **Revenue and Latency**: Amazon's research showed that even small increases in latency (the **tail latency**, specifically the 99.9th percentile) directly correlate to a drop in revenue. 
- **Customer Obsession**: A "Service Oriented Architecture" where every team operates their own distributed system. If the shopping cart service is down, customers cannot spend money. Therefore, a write (adding to cart) must *always* succeed, even if the system is partitioned.
- **Service Level Agreements (SLAs)**: Dynamo guarantees a specific 99.9th percentile latency to other teams, ensuring predictable performance for the "worst-case" requests.

## Architecture and Mechanisms

Dynamo uses several decentralized techniques to achieve its goals without a single point of failure.

### Consistent Hashing
To map keys to nodes, Dynamo uses **[[Sharding|Consistent Hashing]]**.
- Nodes and keys are mapped onto a logical **circular identifier space** (the "ring").
- A key is assigned to the first node whose identifier is greater than or equal to the key's identifier.
- **Advantages**: Adding or removing a node only affects its immediate neighbors on the ring, minimizing data movement.
- **Replication**: For each key, Dynamo stores copies at $N$ successor nodes on the ring (the **preference list**).

```mermaid
graph LR
    subgraph Ring [Consistent Hashing Ring]
    A((Node A)) --> B((Node B))
    B --> C((Node C))
    C --> D((Node D))
    D --> A
    end
    K1[Key 1] -.-> B
    K2[Key 2] -.-> D
    
    style Ring fill:#f9f,stroke:#333,stroke-width:2px
```

### Quorum Parameters (N, R, W)
Dynamo allows per-service tuning of the trade-off between consistency, durability, and availability using three parameters:
- **$N$**: The number of replicas.
- **$R$**: The number of replicas that must respond to a read request.
- **$W$**: The number of replicas that must respond to a write request.

#### Performance and Consistency Trade-offs
- **$R + W > N$**: This is the "standard" quorum configuration (similar to **[[Paxos|Paxos]]**). It ensures that the read set and write set overlap, providing a higher likelihood of reading the latest value.
- **$W = 1$**: Provides maximum write availability but risks losing data if that single node fails before replicating.
- **Low $R, W$**: Lowers latency by requiring fewer network round-trips but increases the chance of stale reads or conflicts.

## Conflict Resolution: Vector Clocks

Since Dynamo allows writes during partitions, it must handle **conflicting versions** of the same data.

### Mechanism
- Dynamo uses **[[Vector Clock Algorithm|Vector Clocks]]** to track causality between different versions of an object.
- A vector clock is a list of `(node, counter)` pairs.
- If version $A$ has a vector clock that is "greater than" version $B$'s (all counters are $\ge$ and at least one is $>$), then $A$ is a descendant of $B$ and $B$ can be discarded.
- If the clocks are incomparable, the versions are **concurrent** (a "branch").

### Semantic Reconciliation
- When a client reads a key that has concurrent versions, Dynamo returns *all* current leaves of the version tree.
- The **application** must then resolve the conflict (e.g., merging two versions of a shopping cart by taking the union of items).
- The resolved value is then written back with a context that includes the vector clocks of the versions it replaced, "merging" the branches back into a single leaf.

## API
Dynamo provides a simple interface:
- `get(key)`: Returns an object or a set of conflicting objects, along with a **context** (opaque metadata containing vector clock info).
- `put(key, context, object)`: Writes a new version of the object. The context tells Dynamo which version(s) this write is intended to replace/update.

---

## Deep Dive

> [!info] Beyond lecture
> Everything above is from the CSE452 lecture and the Dynamo paper. This section adds cross-course connections and the lineage of systems Dynamo spawned — context that was *not* part of the class.

### Virtual Nodes: Consistent Hashing's Answer to Skew

The lecture's ring places one point per physical node, but real Dynamo gives each physical node **many** points on the ring — **virtual nodes (vnodes)**. This matters for two reasons: load spreads more evenly (a powerful machine can simply own more vnodes), and when a node joins or leaves, its share of data is redistributed across *many* neighbors instead of dumping onto one. It is the consistent-hashing counterpart to the [[Data Partitioning Schemes#Skew: The Justin Bieber Effect|data-skew]] problem from CSE444: more partitions than nodes so no single node becomes a hot spot.

### N, R, W Is the Same Quorum Argument as Paxos

The rule **$R + W > N$** is the *same* quorum-intersection idea that makes [[Paxos|Paxos]] safe (see [[Majority Overlap|Majority Overlap]]): if every read contacts $R$ replicas and every write reaches $W$, and $R + W > N$, then any read set and any write set must **share at least one replica** — so a read is guaranteed to see at least one copy of the most recent acknowledged write. Dynamo just exposes $R$ and $W$ as tunable knobs instead of hard-coding a majority.

### Anti-Entropy via Merkle Trees

To keep replicas in sync in the background, Dynamo compares them with **Merkle trees**: each replica hashes its key-range into a tree, and two replicas exchange only the tree nodes that differ, syncing just the divergent ranges instead of scanning everything. This is the **same Merkle-tree structure Bitcoin uses** to compact blocks ([[Distributed Systems/Case Studies/Bitcoin#Reclaiming Disk Space|Reclaiming Disk Space]]) — a recurring tool for cheaply detecting "what's different between two big things."

### The Lineage: Cassandra and CRDTs

- **Cassandra** is Dynamo's most direct descendant — it inherited consistent hashing and tunable $N, R, W$ outright. It originally used [[Vector Clock Algorithm|vector clocks]] but later dropped them for simpler **last-write-wins timestamps**, trading conflict-detection fidelity for operational simplicity.
- Dynamo's **application-level semantic reconciliation** (merge two shopping carts by union) is the *manual* version of a **CRDT** (Conflict-free Replicated Data Type), covered under [[Weak Consistency Models|Weak Consistency Models]]. A CRDT makes that merge automatic and guaranteed-convergent, so the application no longer has to write the merge logic by hand.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Context** | Causal Metadata / Version Tag |
| **Branch/Leaf** | Divergent Versions / Sibling Records |
| **Preference List** | Replication Group |
| **SLA (99.9%)** | P99.9 Latency / Tail Latency |

---

## Related
- [[Distributed Systems/Consistency/Theoretical Foundations|CAP Theorem]] — the theoretical basis for Dynamo's design
- [[Distributed Systems/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — the formal mechanism for tracking causality
- [[Distributed Systems/Sharding/Sharding|Sharding]] — the general concept of partitioning data across nodes
- [[Distributed Systems/Case Studies/Key Takeaways|Key Takeaways in Performance and Durability]] — broader context on why Dynamo's trade-offs matter