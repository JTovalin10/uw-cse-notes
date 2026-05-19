# CSE452: Replica Group

A **Replica Group** is a fault-tolerant cluster of servers responsible for serving a specific set of [[CSE452/Sharding/Definitions/Shard|shards]].

### Formal Definition
A set of nodes $N = \{n_1, n_2, ... n_m\}$ that implement a [[CSE452/RPC/Deterministic State Machine|Replicated State Machine]] (via [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]]) to provide [[CSE452/Consistency/Definitions/Linearizability|Linearizability]] for a subset of the system's data.

### Simplified Explanation
A "team" of servers. Instead of trusting one machine with your data, you give it to a group of 3 or 5 machines that use Paxos to stay in sync.

---

**Responsibility**: A group must maintain a state machine for every shard assigned to it by the [[CSE452/Sharding/Definitions/ShardMaster|ShardMaster]].

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Replica Group** | Replica set / partition group |

## Related
- [[CSE452/Sharding/Sharding|Sharding]] — the partitioning architecture
- [[CSE452/Sharding/Sharded Key-Value Server|Sharded Key-Value Server]] — the ShardStoreServer inside a replica group
