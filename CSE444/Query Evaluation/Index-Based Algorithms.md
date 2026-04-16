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

![[CSE444/screenshots/Index-based selection example.png]]

## Index Nested Loop Join

**Index nested loop join** $R \bowtie S$ assumes $S$ has an index on the join attribute.

Algorithm: iterate over every tuple in $R$; for each tuple, use the index on $S$ to fetch only the matching tuples.

Cost:
- If index on $S$ is **clustered**: $B(R) + T(R) \times \dfrac{B(S)}{V(S, a)}$
- If index on $S$ is **unclustered**: $B(R) + T(R) \times \dfrac{T(S)}{V(S, a)}$

This avoids the full scan of $S$ for each tuple of $R$ that plain [[CSE444/Query Evaluation/Nested Loop Join|nested loop join]] performs.

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[CSE444/Query Evaluation/Nested Loop Join|Nested Loop Join]] — the non-index variant
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — index types (clustered vs. unclustered, B+ trees, hash indexes)
