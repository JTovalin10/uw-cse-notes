# Database Internals: Single-Pass Hash Join

**Hash join** is the default join algorithm in most database systems. It uses a hash function to partition tuples into buckets by join key, making it highly efficient for equi-joins.

---

## One-Pass Hash Join

Used when the smaller relation fits entirely in main memory: $B(R) \leq M$ (assuming $R$ is the smaller relation).

**Algorithm** $R \bowtie S$:
1. **Build phase**: Scan $R$ and build a hash table in main memory, partitioning tuples into buckets by join key.
2. **Probe phase**: Scan $S$ and probe each tuple against the hash table to find matching tuples in $R$.

**Cost**: $B(R) + B(S)$ I/Os.

This is a **one-pass algorithm** — one table is read once to build the hash table, and the other is read once to probe it. There are no intermediate writes to disk.

The choice of which relation to build on is critical: the build relation must fit in $M$ buffer pages. If neither relation is small enough, the one-pass algorithm is not feasible and the **[[Database Internals/Query Evaluation/Partitioned Hash Algorithms|Partitioned Hash Join]]** must be used instead.

![[Hash Join Example 1.png]]

### Iterator Implementation

Hash join maps naturally onto the [[Database Internals/Query Evaluation/Query Execution & Algorithms|iterator interface]]:

1. **`open()`** — scan the build relation (e.g., Patient) and build the in-memory hash table.
   - Cost: $B(P) = 4$ I/Os in this example.
   - ![[Hash Join Example 2.png]]

2. **`next()`** — scan the probe relation (e.g., Insurance) one tuple at a time, probing into the hash table and returning matching pairs.
   - ![[Hash join Ex 3.png]]

The key advantage of this design is that the build phase happens once inside `open()`, paying the cost of reading the build relation a single time. Every subsequent `next()` call only reads from the probe relation and performs an in-memory hash lookup, which is essentially free from an I/O perspective.

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Single-Pass Hash Join | In-memory hash join / classic hash join |
| Build phase | Hash build phase |
| Probe phase | Hash probe phase |
| Build relation | Inner relation / hash side |
| Probe relation | Outer relation / probe side |

## Related

- [[Database Internals/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[Database Internals/Query Evaluation/Partitioned Hash Algorithms|Partitioned Hash Join (Grace Join)]] — the two-pass hash join for relations larger than memory
- [[Database Internals/Query Evaluation/Nested Loop Join|Nested Loop Join]] — simpler alternative join algorithm
- [[Database Internals/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — sort-based join algorithm
- [[Database Internals/Query Evaluation/Query Execution & Algorithms|Query Execution]] — iterator interface used by all operators
