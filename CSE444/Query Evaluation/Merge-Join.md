# CSE444: Merge-Join

**Merge-join** is a two-pass join algorithm that sorts both relations on the join attribute and then merges and joins them in a combined pass. It handles relations too large to fit in memory.

## Algorithm

1. **Step 1a** — generate initial sorted runs for $R$ using [[CSE444/Query Evaluation/External Merge-Sort|external merge-sort]]
2. **Step 1b** — generate initial sorted runs for $S$ using external merge-sort
3. **Step 2** — merge and join:
   - Option A: fully merge $R$ and $S$ first, then join
   - Option B: merge and join simultaneously in a single pass

![[CSE444/screenshots/Merge Join.png]]

## Cost

$$\text{Cost} = 3(B(R) + B(S))$$

This is feasible when $B(R) + B(S) \leq M^2$, which holds for most practical relation sizes given modern buffer pools.

## Example

![[CSE444/screenshots/Merge join example 1.png]]
![[CSE444/screenshots/Merge-Join example 2.png]]
![[CSE444/screenshots/Merge Join Example 3.png]]

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[CSE444/Query Evaluation/External Merge-Sort|External Merge-Sort]] — the sorting primitive used in steps 1a and 1b
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — the one-pass version when both relations fit in memory
- [[CSE444/Query Evaluation/Partitioned Hash Algorithms|Partitioned Hash Join]] — alternative two-pass join algorithm
- [[CSE444/Query Evaluation/Hash Join|Hash Join]] — one-pass hash-based join
