# CSE452: ShardMaster

The **ShardMaster** is the fault-tolerant metadata service that manages [[Configuration|configurations]] and shard assignments.

### Formal Definition
The authoritative source of truth for the system's **Configuration**. It sequences all membership and assignment changes into a linearizable, numbered sequence of states.

### Simplified Explanation
The "Boss" or "Traffic Controller." It decides which group of servers is responsible for which slice of data and tells the clients where to go.

---

**Reliability**: The ShardMaster is itself a [[Multi-Paxos|Multi-Paxos]] cluster, ensuring that the system's metadata is never lost and remains consistent even if some master nodes crash.

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **ShardMaster** | Configuration service / control plane (ZooKeeper, etcd) |

## Related
- [[Shard Master|Shard Master]] — full coverage of operations and the rebalancing algorithm
- [[Sharding|Sharding]] — the partitioning architecture
