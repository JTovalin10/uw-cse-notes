# CSE344: External Memory Algorithms

**External memory algorithms** assume data is on disk rather than in main memory. They are slower than [[Main Memory Join Algorithms|main memory algorithms]] but have no limitation on data size.

## Introduction and Costing

Data on disk is organized in **blocks** — see [[CSE344/Database Design/Disk Storage|Disk Storage]].
- A file = collection of blocks
- A relation = a file
- Each block may contain multiple records

**Costing a main memory algorithm:**
- Cost: number of CPU instructions
- Asymptotic cost: function of input size $n$

**Costing an external memory algorithm:**
- Dominated by disk I/O — measured as the number of blocks read or written
- Typically a small multiple of the data size
- Main memory cost is also incurred but usually ignored

### Metrics

The RDBMS keeps statistics about tables:
- $B(R)$ = number of blocks in relation $R$
- $T(R)$ = number of tuples in relation $R$
- $V(R, \text{attr})$ = number of distinct values of `attr` in $R$
- Typically $B(R) \leq T(R)$

## Physical Selection Operators

- **Sequential scan**: full scan on $R$
	- Cost: $B(R)$
	- Always works, but slow
- **Use index**: load only the matching tuples into memory using an index
	- Assuming uniformity, matches $T(R)/V(R, \text{name})$ tuples
	- **Unclustered index cost**: $T(R)/V(R, \text{name})$ (one I/O per matching tuple)
	- **Clustered index cost**: $B(R)/V(R, \text{name})$ (sequential I/O for the matching range)

## External Memory Join Algorithms

For $R \bowtie S$:

### Naive Nested Loop Join

The in-memory loop join with no modifications to handle disk I/O cost:

```python
for each tuple tR in R:
    for each tuple tS in S:
        if canJoin(tR, tS):
            output(tR, tS)
```

### Block-at-a-Time Nested Loop Join

A block-aware version of the naive nested loop join.

![[Block-at-a-time Nested-Loop Join.png]]

### Block Nested Loop Join

Uses $N + 1$ blocks of memory to reduce I/O:
- Cost to read $R$: $B(R)$
- Total cost: $B(R) + \lceil B(R)/N \rceil \cdot B(S)$

![[Block Nested Loop Join.png]]

### External Memory Hash Join

Build a hash table from the smaller relation — it must fit in main memory ($B(R) \leq M$ or $B(S) \leq M$). Then for each block of the larger relation, join using the hash table.

- Expected cost: $B(R) + B(S)$

![[External Memory Hash.png]]

### GRACE Join (Partitioned Hash Join)

For when neither relation fits in memory.

**Two phases:**

1. **Build phase**: reorganize $R$ and $S$ by join key
	- Hash $R$ and $S$ into parallel partitions
	- Each partition pair $PR_i$ and $PS_i$ contains the same join keys

2. **Probe phase**: load pairs of partitions into memory simultaneously
	- For each bucket: read $PR_i$ into main memory, scan $PS_i$ one block at a time and join

**Cost**: $3B(R) + 3B(S)$
- Build phase: $2B(R) + 2B(S)$
- Probe phase: $B(R) + B(S)$

**Efficiency requirements:**
- Cannot have more than $M$ partitions
- Each partition $PR_i$ must fit in main memory: $B(PR_i) \leq M$

### Index-Based Join

$$R \bowtie_{R.A = S.B} S$$

Assuming an index exists on $S.B$:
- For each record $x$ in $R$: use the index on $S.B$ to find all records where $S.B = x$
- Conceptually similar to a hash join

There are $T(S)/V(S, B)$ tuples in $S$ whose value equals $x$, and we loop over $T(R)$ records.

**Cost:**
- Unclustered: $B(R) + T(R) \cdot T(S)/V(S, B)$
- Clustered: $B(R) + B(R)/V(R, A) \cdot B(S)/V(S, B)$

Not a general-purpose join, but useful as a helper when an index is already available.

## Related
- [[Main Memory Join Algorithms]] — the in-memory versions of these algorithms
- [[Pipelined Execution]] — how these algorithms compose in a full query plan
- [[Physical Algorithms and Pipelining]] — overview of physical operator classification
- [[Parallel Join Algorithms]] — distributed extensions of these joins
- [[Cardinality Estimation]] — how the optimizer chooses between these algorithms
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — block organization on disk that drives these I/O costs
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — how index type affects selection and join cost
- [[CSE344/Database Design/Database Indices|Database Indices]] — index structures referenced by index-based join
- [[CSE451/Persistent Storage/Magnetic Disks|Magnetic Disks]] — OS-level view of the disk I/O these algorithms minimize
- [[CSE351/Cache/Spatial Locality|Spatial Locality]] — the block-level locality principle that makes these algorithms efficient
