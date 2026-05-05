# CSE444: Index-Based Algorithms

Index-based algorithms exploit an existing index on one relation to avoid full scans. They are part of the §15.6 family in Ramakrishnan & Gehrke.

## Index-Based Selection
**Selection on equality**: $\sigma_{a=v}(R)$

Standard cost parameters:
- $B(R)$: size of $R$ in blocks
- $T(R)$: number of tuples in $R$
- $V(R, a)$: number of distinct values of attribute $a$

Cost (ignoring I/O cost for index pages themselves):

| Index type | Cost |
|---|---|
| **Clustered** index on $a$ | $\dfrac{B(R)}{V(R, a)}$ |
| **Unclustered** index on $a$ | $\dfrac{T(R)}{V(R, a)}$ |

A clustered index is cheaper because matching tuples are stored contiguously on disk — only $\frac{1}{V(R,a)}$ fraction of the pages need to be read. An unclustered index may require a separate I/O for each matching tuple since they can be scattered across many pages.

Note: indexes are fast for highly selective queries (small $\frac{1}{V(R,a)}$), but for low-selectivity queries a full sequential scan may be cheaper.

### Example

![[CSE444/Screenshots/Index-based selection example.png]]

## Range Selection Cost

| Index type            | Cost                 |
| --------------------- | -------------------- |
| **Clustered** index   | $sel(P) \times B(R)$ |
| **Unclustered** index | $sel(P) \times T(R)$ |

### When to prefer clustered vs unclustered
- Clustered is always cheaper for range queries
- Unclustered is only worth using if $sel(P)$ is very small
- Rule of thumb: if $sel(P) \times T(R) > B(R)$, just do a full sequential scan instead

## Index Nested Loop Join

**Index nested loop join** $R \bowtie S$ assumes $S$ has an index on the join attribute.

Algorithm: iterate over every tuple in $R$; for each tuple, use the index on $S$ to fetch only the matching tuples.

Cost:
- If index on $S$ is **clustered**: $B(R) + T(R) \times \dfrac{B(S)}{V(S, a)}$
- If index on $S$ is **unclustered**: $B(R) + T(R) \times \dfrac{T(S)}{V(S, a)}$

This avoids the full scan of $S$ for each tuple of $R$ that plain [[CSE444/Query Evaluation/Nested Loop Join|nested loop join]] performs.

### Special Case: PK-FK Join
In a **Primary-Key (S) to Foreign-Key (R)** join:
1. Every tuple in $R$ matches **exactly one** tuple in $S$.
2. Because the join attribute is a Primary Key in $S$, the number of distinct values equals the number of tuples: $V(S, a) = T(S)$.
3. The selectivity fraction $\frac{T(S)}{V(S, a)}$ cancels out to **1**.

**Clustered vs. Unclustered:** 
In this specific case, the cost is the same for both. Clustering only benefits joins where one value matches *multiple* tuples (by keeping them on the same page). For a unique Primary Key lookup, you always perform exactly 1 I/O to fetch the data page regardless of clustering.

Assume index pages are in memory, the cost simplifies to:
$$\text{Cost} = B(R) + T(R)$$
*(1 I/O to scan each page of R + 1 I/O to fetch the single matching partner in S for every tuple in R).*

### For intermediate relations
If $R$ is an intermediate result (not a base table), you may not know $B(R)$ directly.
Estimate it as:
$$B(R_{int}) = \frac{T(R_{int})}{T(R)} \times B(R)$$
i.e. scale the page count by how many tuples survived.

## Pipelining & I/O Costs

In a physical query plan, we assume an **Iterator Interface** (pull-based model).

- **Pipelined Operations**: If an operator can process tuples one-at-a-time as they are pulled from the child, the I/O cost for that step is **0**.
  - *Examples*: Selection ($\sigma$), Projection ($\pi$), and the "probe" phase of a Hash Join or Index Nested Loop Join.
- **Materialized Operations**: If an operator must read/write to disk (e.g., because a hash table doesn't fit in memory or a sort is required), you must count those I/Os.
- **Rule of Thumb for HW**:
  - Reading a base table = $B(R)$ I/Os.
  - Selection/Projection on a stream = 0 I/Os.
  - Hash Join (if fits in memory) = 0 additional I/Os beyond reading the two inputs.
  - Index Nested Loop Join = $T(R_{left}) \times (\text{probe cost})$.

## Selectivity Caveats

- **AND**: $sel(P_1 \land P_2) \approx sel(P_1) \times sel(P_2)$ (Independence assumption)
- **OR**: $sel(P_1 \lor P_2) \approx sel(P_1) + sel(P_2) - sel(P_1) \times sel(P_2)$
  - Simplified to $sel(P_1) + sel(P_2)$ in practice

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[CSE444/Query Evaluation/Nested Loop Join|Nested Loop Join]] — the non-index variant
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — index types (clustered vs. unclustered, B+ trees, hash indexes)
