# CSE444: Single-Pass Hash Join

**Hash join** is the default join algorithm in most database systems. It uses a hash function to partition tuples into buckets by join key, making it highly efficient.

---

## 1. One-Pass Hash Join

Used when the smaller relation fits entirely in main memory: $B(R) \leq M$ (assuming $R$ is the smaller relation).

**Algorithm** $R \bowtie S$:
1. Scan $R$ and build a hash table in main memory, partitioning tuples into buckets by join key.
2. Scan $S$ and probe each tuple into the hash table to find matches.

**Cost**: $B(R) + B(S)$ I/Os.
This is a **one-pass algorithm**. One table is read once to build the hash table, and the other is read once to probe it.

![[CSE444/Screenshots/Hash Join Example 1.png]]

### Iterator Implementation

Hash join maps naturally onto the [[CSE444/Query Evaluation/Query Execution & Algorithms#Iterator Interface|iterator interface]]:

1. **`open()`** — scan the build relation (e.g., Patient) and build the in-memory hash table
   - Cost: $B(P) = 4$ I/Os in this example
   - ![[CSE444/Screenshots/Hash Join Example 2.png]]

2. **`next()`** — scan the probe relation (e.g., Insurance) one tuple at a time, probing into the hash table and returning matching pairs
   - ![[CSE444/Screenshots/Hash join Ex 3.png]]

---

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[Partitioned Hash Algorithms (Grace Join)|Partitioned Hash Join (Grace Join)]] — the two-pass hash join for relations larger than memory
- [[CSE444/Query Evaluation/Nested Loop Join|Nested Loop Join]] — simpler alternative join algorithm
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — sort-based join algorithm
- [[CSE444/Query Evaluation/Query Execution & Algorithms|Query Execution]] — iterator interface used by all operators
