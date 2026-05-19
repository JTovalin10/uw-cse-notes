# CSE452: Shard

A **Shard** is a discrete subset of the total key-space used as the unit of partitioning in [[CSE452/Sharding/Sharding|sharding]].

### Formal Definition
A disjoint partition $S_i$ of the set of all possible keys $K$, such that $\bigcup S_i = K$ and $S_i \cap S_j = \emptyset$ for $i \neq j$.

### Simplified Explanation
A slice of the database. Instead of one giant table, we cut it into 10 pieces (shards) so different machines can handle different pieces.

---

**Implementation**: In Lab 4, keys are mapped to shards using a deterministic hash function: `shard = hash(key) % num_shards`.

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Shard** | Shard / partition |

## Related
- [[CSE452/Sharding/Sharding|Sharding]] — the partitioning architecture
- [[CSE452/Sharding/Definitions/Replica Group|Replica Group]] — the cluster that serves a set of shards
