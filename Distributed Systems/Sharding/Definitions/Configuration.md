# Distributed Systems: Configuration

A **Configuration** is the authoritative metadata describing the layout and membership of the distributed system at a specific point in time.

### Formal Definition
A tuple $C = \langle config\_num, M_{shard}, M_{group} \rangle$ where:
- $config\_num$ is a monotonically increasing version identifier.
- $M_{shard}: ShardID \to GID$ is the routing mapping.
- $M_{group}: GID \to \{Address_1, ... Address_n\}$ is the membership mapping.

### Simplified Explanation
The system's "Map." It tells you:
1. What version of the map this is.
2. Which group (GID) owns which slice of data ([[Shard|Shard]]).
3. Where those groups are located (server addresses).

---

**Lifecycle**: Configurations are numbered sequentially. Clients and servers use the `config_num` to detect when their local map is stale and must be updated from the [[ShardMaster|ShardMaster]].

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Configuration** | Cluster topology / shard map / membership view |
| **config_num** | Configuration / epoch number |

## Related
- [[ShardMaster|ShardMaster]] — the service that issues configurations
- [[Reconfiguration|Reconfiguration]] — how groups react to a new configuration
