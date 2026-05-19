# CSE452: Fast Reads in Multi-Paxos

In standard [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]], every read must go through the **leader** and be appended to the log to guarantee [[CSE452/Consistency/Definitions/Linearizability|Linearizability]]. This ensures reads reflect the most up-to-date committed state, but it is expensive — every read consumes log slots and requires at least a round-trip to the leader. **Fast reads** are optimizations that allow reads to be served directly from **any replica** without full consensus, at the cost of relaxed consistency guarantees.

There are two main fast read models, each offering a different consistency trade-off:

---

## Snapshot Reads

### Formal Definition

A **snapshot read** may return a value that is behind the current committed state (i.e., **stale**), but the returned value must correspond to a consistent prefix of the global linearizable write order. Additionally, the sequence of reads issued by a single client must be **monotonically non-descending** in the global log order — no read may return a value older than what the client has already observed.

Formally: if client $C$ issued read $R_i$ and observed the state at log index $k$, then any future read $R_{i+1}$ by the same client must return a state at log index $\geq k$.

### Simplified Explanation

The replica you read from might be behind the leader — it hasn't applied the most recent commits yet. That's fine. But the value it returns must be consistent with *some* real point in time (not a garbled mix), and your reads as a client can only move forward in time — you can never see a value older than what you just read.

### Properties

- Writes remain **fully linearizable** — all writes still go through the leader and the Paxos log
- A snapshot read may return a **stale** value, but the value must be a valid committed state in the global log
- **Per-client monotonicity**: each subsequent read by the same client must see a state at least as recent as its prior read
- Reads can be served from **any replica**, without touching the leader

### Example

Suppose the global log has committed three writes in order:

```
[W1: x=1] → [W2: x=5] → [W3: x=9]   (all committed at leader)
```

Replica R2 has only applied W1 and W2 (it is slightly behind). A snapshot read to R2 can legally return `x=5`. It cannot return `x=1` if the client's previous read already saw `x=5` (monotonicity). It cannot return `x=9` unless it has applied W3.

If the client now issues a second read:
- **Legal**: R2 has caught up and returns `x=9`
- **Legal**: R2 still returns `x=5` (hasn't moved backward)
- **Illegal**: R2 returns `x=1` (violates per-client monotonicity)

---

## Eventually Consistent Reads

### Formal Definition

An **eventually consistent read** may return a value that is stale or even inconsistent with the global linearizable order. There is **no monotonicity guarantee**. However, if all of the following conditions hold for a sufficient period of time:

- All servers are up and connected
- All in-flight messages are eventually delivered
- No new writes are issued

...then repeated reads will **converge** and eventually return the most up-to-date committed value.

### Simplified Explanation

This is the weakest guarantee. You may read from any replica, and that replica might be arbitrarily far behind or even temporarily inconsistent with other replicas. If writes stop long enough and the system stabilizes, every replica will eventually catch up and return the correct value. Until then, all bets are off.

### Properties

- No guarantee that the returned value corresponds to any single consistent snapshot
- **No per-client monotonicity** — successive reads by the same client can move backward in the global log order
- Different replicas may return **different values** for the same key at the same instant
- Reads are fully **local** to a replica — zero coordination cost
- Commonly used for **read-heavy** workloads where occasional staleness is acceptable

### Example

Suppose the global log has committed:

```
[W1: x=1] → [W2: x=5] → [W3: x=9]   (all committed at leader)
```

Three replicas have applied different prefixes of the log:
- Replica R1: applied W1, W2, W3 → returns `x=9`
- Replica R2: applied W1, W2 → returns `x=5`
- Replica R3: applied W1 only → returns `x=1`

An eventually consistent client might:
1. Read from R1 → sees `x=9`
2. Read from R3 → sees `x=1` (**no monotonicity violation — this model allows it**)
3. Read from R2 → sees `x=5`

Once writes stop and all replicas receive and apply W1, W2, and W3, every replica will return `x=9`.

---

## Comparison

| Property | Linearizable Read | Snapshot Read | Eventually Consistent Read |
|---|---|---|---|
| Staleness | Never stale | May be stale | May be stale |
| Consistent with global order | Always | Yes (valid prefix) | Not guaranteed |
| Per-client monotonicity | Yes | Yes | No |
| Coordination required | Leader round-trip | None | None |
| Cost | High | Low | Lowest |

---

## Why Fast Reads Exist

In [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]], the leader is a bottleneck for all operations. Fast reads allow replicas to serve reads locally, providing:

- **Lower latency**: no leader round-trip
- **Higher throughput**: read load is distributed across all replicas
- **Geo-distribution benefit**: clients read from the nearest replica rather than routing to a potentially distant leader

The trade-off is consistency. The appropriate model depends on the application — financial transactions demand linearizable reads, while social media timelines can tolerate eventual consistency.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Fast Read** | Follower read / local read optimization |
| **Snapshot Read** | Bounded-staleness read / consistent-prefix read |
| **Eventually Consistent Read** | Stale read / best-effort read |
| **Per-Client Monotonicity** | Monotonic-reads session guarantee |

---

## Related

- [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] — the consensus protocol whose leader bottleneck fast reads relieve
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]] — the strong guarantee that fast reads relax
- [[CSE452/Consistency/Weak Consistency Models|Weak Consistency Models]] — eventual consistency, the model behind eventually consistent reads
- [[CSE452/Consistency/Consistency|Consistency]] — the consistency-model hub
