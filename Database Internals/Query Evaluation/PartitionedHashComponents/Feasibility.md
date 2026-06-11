# Database Internals: Partitioned Hash Join — Feasibility & Recursive Partitioning

## Calculating Partition Size ($B(R_i)$)

Before Step 3 (the join phase), we estimate the build partition size. Assuming **uniform hashing** — that $h_1$ distributes tuples evenly across all $M-1$ buckets:

$$B(R_i) = \frac{B(R)}{M-1}$$

In practice, hash functions are not perfectly uniform and some buckets may be larger than average (a phenomenon called **data skew**). The ideal cost assumes uniform distribution.

## The Feasibility Check

For Step 3 to work, the entire build partition $R_i$ must fit in the allocated build memory ($M-2$ pages):

$$B(R_i) \leq M - 2$$

Substituting the formula for $B(R_i)$:

$$\frac{B(R)}{M-1} \leq M - 2 \implies B(R) \leq (M-1)(M-2) \approx M^2$$

This is the feasibility condition for a single-pass partitioned hash join. When $B(R)$ is too large, the build partitions will not fit in memory during Step 3 and the algorithm must recurse.

## How Many Partitioning Passes ($P$) Are Needed?

Each partitioning pass increases the number of partitions by a factor of $M-1$, progressively shrinking each partition. After $P$ passes, the total capacity of the partition hierarchy is $(M-1)^P$ partitions, each holding $M-2$ build pages. For Step 3 to succeed:

$$\boxed{B(R) \leq (M-1)^P \cdot (M-2)}$$

Solving for $P$:

$$P \geq \log_{M-1}\!\left(\frac{B(R)}{M-2}\right)$$

Take $P = \lceil \log_{M-1}(B(R)/(M-2)) \rceil$.

## Recursive Partitioning (the "Overflow" Strategy)

If $B(R_i) > M - 2$ after the initial partitioning pass, the DBMS must **recurse**:

- **Strategy**: Treat each oversized bucket pair $(R_i, S_i)$ as a new sub-join problem. Apply the same partitioning algorithm to $R_i$ and $S_i$, splitting them into up to $M-1$ smaller sub-buckets using a different hash function (to avoid the same skew pattern).
- **Cost per extra pass**: Each additional partitioning level adds $2(B(R) + B(S))$ I/Os (one full read + write for each relation).
- **Total cost formula** with $P$ partitioning passes:
  $$(2P + 1) \times (B(R) + B(S))$$
  - The $2P$ factor covers $P$ partition passes (each costing $2(B(R) + B(S))$).
  - The $+1$ covers the final join pass (cost $B(R) + B(S)$, reads only).

For the standard single-pass case ($P = 1$): $(2 \cdot 1 + 1) \times (B(R) + B(S)) = 3(B(R) + B(S))$.

---

## Formal Analysis

### Formal Definition

$$P = \left\lceil \log_{M-1}\!\left(\frac{B(R)}{M-2}\right) \right\rceil$$

$$\text{Total Cost} = (2P + 1)(B(R) + B(S))$$

### Simplified Explanation

You need enough partitioning rounds so that each individual bucket (of the smaller relation) fits in $M-2$ memory pages. Each round shrinks each bucket by a factor of roughly $M-1$. Once a bucket fits, you can build a hash table over it in memory and probe the matching bucket from the other relation.

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Recursive partitioning | Hybrid hash join / overflow partitioning |
| Uniform hashing assumption | Uniform hash distribution |
| Feasibility condition | Memory fit requirement |

## Related

- [[Database Internals/Query Evaluation/PartitionedHashComponents/Overview|Overview & Key Idea]]
- [[Database Internals/Query Evaluation/PartitionedHashComponents/Algorithm|The Algorithm]]
- [[Database Internals/Query Evaluation/PartitionedHashComponents/Worked Example|Worked Example]]
