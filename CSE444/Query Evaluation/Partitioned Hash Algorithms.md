# CSE444: Partitioned Hash Join

**Partitioned hash join** (also called **Grace join**) is a two-pass join algorithm that partitions both relations into buckets on disk so that each bucket pair fits in memory for joining.

## Key Idea

Partition $R$ into $k$ buckets on disk: $R_1, R_2, \ldots, R_k$.

Assuming uniform distribution, each bucket has size:

$$B(R_i) = \frac{B(R)}{k}, \quad \forall i$$

The goal is for each $R_i$ to fit in main memory: $B(R_i) \leq M$.

We choose $k = M - 1$, giving each bucket size approximately:

$$\frac{B(R)}{M - 1} \approx \frac{B(R)}{M}$$

![[CSE444/Screenshots/Partitioned Hash Algorithm.png]]

## Algorithm

1. Hash $S$ into $M - 1$ buckets and write all buckets to disk
2. Hash $R$ into $M - 1$ buckets and write all buckets to disk
3. For every matching pair of buckets $(R_i, S_i)$, load both into memory and join them using [[CSE444/Query Evaluation/Hash Join|hash join]]

## Cost

$$\text{Cost} = 3(B(R) + B(S))$$

Same asymptotic cost as [[CSE444/Query Evaluation/Sort-Merge Join|sort-merge join]], but without requiring a sort — useful when data is not already sorted or when sorting is more expensive.

## Example

![[CSE444/Screenshots/Partitioned Hash Join ex1.png]]
![[CSE444/Screenshots/Partitioned Hash-Join ex 2.png]]
![[CSE444/Screenshots/Partitoned hash-join 2.png]]
![[CSE444/Screenshots/Partitioned Hash-Join 4.png]]
![[CSE444/Screenshots/Partitioned Hash Join 6.png]]

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[CSE444/Query Evaluation/Hash Join|Hash Join]] — the one-pass hash join used within each bucket pair
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — alternative two-pass join algorithm using sorting
- [[CSE444/Query Evaluation/External Merge-Sort|External Merge-Sort]] — the sort-based counterpart to partitioned hashing
