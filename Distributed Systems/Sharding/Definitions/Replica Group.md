# Distributed Systems: Replica Group

A **Replica Group** is a fault-tolerant cluster of servers responsible for serving a specific set of [[Shard|shards]].

### Formal Definition
A set of nodes $N = \{n_1, n_2, ... n_m\}$ that implement a [[Deterministic State Machine|Replicated State Machine]] (via [[Multi-Paxos|Multi-Paxos]]) to provide [[Linearizability|Linearizability]] for a subset of the system's data.

### Simplified Explanation
A "team" of servers. Instead of trusting one machine with your data, you give it to a group of 3 or 5 machines that use Paxos to stay in sync.

---

**Responsibility**: A group must maintain a state machine for every shard assigned to it by the [[ShardMaster|ShardMaster]].

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Replica Group** | Replica set / partition group |

## Related
- [[Sharding|Sharding]] — the partitioning architecture
- [[Sharded Key-Value Server|Sharded Key-Value Server]] — the ShardStoreServer inside a replica group
