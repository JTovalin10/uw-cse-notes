# CSE444: Operator Algorithms

## Design Criteria

When evaluating the quality of an operator algorithm, three criteria are considered:

- **Cost**: measured in I/O, CPU, and network operations
  - The cost of reading operands from disk is the primary concern
  - The cost of writing the final result to disk is *not* included in operator cost estimates — it must be counted separately when applicable
- **Memory utilization**: how much buffer pool memory the operator requires
- **Load balance**: for parallel operators, how evenly work is distributed across workers

## Cost Parameters

For simplicity, **cost** is defined as the total number of I/Os. Reading from memory is free; this is a simplification that ignores CPU and network costs.

The standard parameters used in cost formulas are:

- **$B(R)$**: number of disk blocks (pages) for relation $R$
  - For a sequential scan, the cost is $B(R)$
- **$T(R)$**: number of tuples in relation $R$
- **$V(R, a)$**: number of distinct values of attribute $a$ in relation $R$
  - When $a$ is a key, $V(R, a) = T(R)$
  - Otherwise, $V(R, a)$ can be any value $\leq T(R)$

**$M$** denotes the number of memory buffers (pages) available to the operator.

## Join Operator Algorithm Categories

Join algorithms are classified into three families depending on how many passes over the data they require:

- **One-pass algorithms**: fit one relation entirely in memory (Ramakrishnan & Gehrke §15.2–15.3)
- **Index-based algorithms**: exploit an existing index on one relation (§15.6)
- **Two-pass algorithms**: sort or hash-partition the data before joining, allowing relations larger than memory (§15.4–15.5)

## Join Algorithms

### Hash Join

**Hash join** is the default join algorithm in most database systems.

**Hash join** $R \bowtie S$:

1. Scan $R$ and build a hash table in main memory, partitioning tuples into buckets by join key
2. Scan $S$ and probe each tuple into the hash table to find matches

**Cost**: $B(R) + B(S)$

This is a **one-pass algorithm** when $B(R) \leq M$ — that is, when the smaller relation fits entirely in memory. One table is read once to build the hash table, and the other is read once to probe it.

![[CSE444/screenshots/Hash Join Example 1.png]]

#### Hash Join Iterator Implementation

Hash join maps naturally onto the iterator interface:

1. **`open()`** — scan the build relation (e.g., Patient) and build the in-memory hash table
   - Cost: $B(P) = 4$ I/Os in this example
   - ![[CSE444/screenshots/Hash Join Example 2.png]]

2. **`next()`** — scan the probe relation (e.g., Insurance) one tuple at a time, probing into the hash table and returning matching pairs
   - ![[CSE444/screenshots/Hash join Ex 3.png]]

### Nested Loop Join

**Nested loop join** is the most straightforward join algorithm. It iterates over every pair of tuples from the two relations.

**Tuple-based nested loop join** $R \bowtie S$:
- $R$ is the **outer relation**, $S$ is the **inner relation**
- Time complexity: $O(n^2)$
- **Cost**: $B(R) + T(R) \cdot B(S)$
- This is a **multiple-pass algorithm** since $S$ is re-read once for every tuple in $R$

```java
for each tuple t_1 in R do:
    for each tuple t_2 in S do:
        if t_1 and t_2 join then output(t1, t2)
```

### Page-at-a-Time Refinement

The **page-at-a-time refinement** improves on the basic nested loop join by iterating over pages rather than individual tuples. This reduces redundant I/O by reading each page of $S$ once per page of $R$ rather than once per tuple of $R$.

**Cost**: $B(R) + B(R) \cdot B(S)$

```java
for each page of tuples r in R do
    for each page of tuples s in S do
        for all pairs of tuples t1 in r, t2 in s
            if t1 and t2 join then output(t1, t2)
```

This is strictly better than tuple-based nested loop join since $B(R) \leq T(R)$, meaning the inner relation $S$ is scanned $B(R)$ times instead of $T(R)$ times.

---

## Related

- [[CSE444/Query Evaluation/Query Execution & Algorithms|Query Execution]]
- [[CSE444/Query Optimization/Query Optimization|Query Optimization]]
