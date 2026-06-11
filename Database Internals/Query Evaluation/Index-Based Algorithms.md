# Database Internals: Index-Based Algorithms

Index-based algorithms exploit an existing index on one relation to avoid full scans. They are part of the §15.6 family in Ramakrishnan & Gehrke. The core principle is that a well-chosen index can answer a highly selective query by fetching only the relevant pages, rather than reading the entire relation.

## Index-Based Selection

**Selection on equality**: $\sigma_{a=v}(R)$

Standard cost parameters:
- $B(R)$: size of $R$ in blocks.
- $T(R)$: number of tuples in $R$.
- $V(R, a)$: number of distinct values of attribute $a$.

Cost (ignoring I/O cost for index pages themselves):

| Index type | Cost |
|---|---|
| **Clustered** index on $a$ | $\dfrac{B(R)}{V(R, a)}$ |
| **Unclustered** index on $a$ | $\dfrac{T(R)}{V(R, a)}$ |

A clustered index is cheaper because matching tuples are stored contiguously on disk — only $\frac{1}{V(R,a)}$ fraction of the pages need to be read. An unclustered index may require a separate I/O for each matching tuple since they can be scattered across many different pages.

Indexes are fast for highly selective queries (small $\frac{1}{V(R,a)}$), but for low-selectivity queries a full sequential scan may be cheaper because sequential I/O is much faster than the random I/Os demanded by an unclustered index scan.

### Example

![[Index-based selection example.png]]

## Range Selection Cost

| Index type | Cost |
|---|---|
| **Clustered** index | $sel(P) \times B(R)$ |
| **Unclustered** index | $sel(P) \times T(R)$ |

### When to Prefer Clustered vs. Unclustered

- A clustered index is always cheaper for range queries because matching tuples are stored on consecutive pages.
- An unclustered index is only worth using if $sel(P)$ is very small — meaning only a tiny fraction of tuples match the predicate, so the random I/Os for each match are fewer than a full sequential scan.
- **Rule of thumb**: if $sel(P) \times T(R) > B(R)$, just do a full sequential scan instead. This is because the expected number of random I/Os (one per matching tuple) exceeds the cost of reading every page sequentially.

## Index Nested Loop Join

**Index nested loop join** $R \bowtie S$ assumes $S$ has an index on the join attribute.

**Algorithm**: iterate over every tuple in $R$; for each tuple, use the index on $S$ to fetch only the matching tuples from $S$ directly, rather than scanning all of $S$.

Cost:
- If index on $S$ is **clustered**: $B(R) + T(R) \times \dfrac{B(S)}{V(S, a)}$
- If index on $S$ is **unclustered**: $B(R) + T(R) \times \dfrac{T(S)}{V(S, a)}$

This avoids the full scan of $S$ for each tuple of $R$ that plain [[Database Internals/Query Evaluation/Nested Loop Join|nested loop join]] performs. Instead, each tuple in $R$ only fetches the subset of $S$ pages (or tuples) that actually match, scaling by the selectivity $\frac{1}{V(S,a)}$.

### Special Case: Primary-Key to Foreign-Key Join

In a **Primary-Key (S) to Foreign-Key (R)** join:
1. Every tuple in $R$ matches **exactly one** tuple in $S$.
2. Because the join attribute is a Primary Key in $S$, the number of distinct values equals the number of tuples: $V(S, a) = T(S)$.
3. The selectivity fraction $\frac{T(S)}{V(S, a)}$ reduces to **1** — each probe retrieves exactly one matching tuple.

**Clustered vs. Unclustered in this case**: The cost is the same for both. Clustering benefits queries where one value matches *multiple* tuples (by keeping them on the same page). For a unique Primary Key lookup, you always perform exactly 1 I/O to fetch the single matching partner in $S$, regardless of whether the index is clustered.

Assuming index pages are in memory, the cost simplifies to:

$$\text{Cost} = B(R) + T(R)$$

*(1 I/O to scan each page of R + 1 I/O to fetch the single matching partner in S for every tuple in R.)*

### For Intermediate Relations

If $R$ is an intermediate result (not a base table), you may not know $B(R)$ directly. Estimate it by scaling the page count by the fraction of tuples that survived:

$$B(R_{\text{int}}) = \frac{T(R_{\text{int}})}{T(R)} \times B(R)$$

## Pipelining and I/O Costs

In a physical query plan, operators are connected via the **Iterator Interface** (pull-based model).

- **Pipelined operations**: If an operator can process tuples one-at-a-time as they are pulled from the child, the incremental I/O cost for that step is **0** — the I/O was already counted at the base-relation scan.
  - *Examples*: Selection ($\sigma$), Projection ($\pi$), and the probe phase of a Hash Join or Index Nested Loop Join.
- **Materialized operations**: If an operator must read or write to disk (e.g., because a hash table does not fit in memory or a sort is required), those I/Os must be counted explicitly.
- **Rule of thumb for cost analysis**:
  - Reading a base table: $B(R)$ I/Os.
  - Selection or Projection on a stream: 0 additional I/Os.
  - Hash Join (if the build side fits in memory): 0 additional I/Os beyond reading the two inputs.
  - Index Nested Loop Join: $T(R_{\text{left}}) \times (\text{probe cost per tuple})$.

## Selectivity Caveats

When multiple predicates are applied together, selectivity is estimated under an independence assumption:

- **AND**: $sel(P_1 \land P_2) \approx sel(P_1) \times sel(P_2)$
- **OR**: $sel(P_1 \lor P_2) \approx sel(P_1) + sel(P_2) - sel(P_1) \times sel(P_2)$
  - Simplified to $sel(P_1) + sel(P_2)$ in practice.

These approximations can be inaccurate when attributes are correlated, but the independence assumption is the standard baseline used by most optimizers.

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Clustered index | Clustered (physical) index / IOT (Index-Organized Table) |
| Unclustered index | Non-clustered index / secondary index |
| Index Nested Loop Join | Index join / lookup join |
| $V(R, a)$ | NDV (number of distinct values) / cardinality of attribute |
| Selection selectivity | Filter selectivity |

## Related

- [[Database Internals/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[Database Internals/Query Evaluation/Nested Loop Join|Nested Loop Join]] — the non-index variant
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — index types (clustered vs. unclustered, B+ trees, hash indexes)
