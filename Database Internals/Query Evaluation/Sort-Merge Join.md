# CSE444: Sort-Merge Join

**Sort-merge join** $R \bowtie S$ is a join algorithm that sorts both relations on the join attribute and then merges them in a linear scan. It can be implemented as either a one-pass or two-pass algorithm depending on available memory.

## One-Pass Algorithm

If both relations fit entirely in main memory ($B(R) + B(S) \leq M$), sort-merge join is a one-pass algorithm.

1. Scan $R$ and sort in memory.
2. Scan $S$ and sort in memory.
3. Merge $R$ and $S$ on the join attribute.

**Cost**: $B(R) + B(S)$

![[Sort-Merge Join.png]]

## Two-Pass Algorithm (Sort-Merge Join)

When relations do not fit in memory ($B(R) + B(S) > M$), we use the two-pass version which integrates with **[[External Merge-Sort|External Merge-Sort]]**.

1. **Step 1: Run Generation**: Generate sorted runs of length $M$ for both $R$ and $S$.
   - Cost: $2(B(R) + B(S))$
2. **Step 2: Merge + Join**: Load the head page of every run from both relations into memory. Merge the runs of $R$ and $S$ on-the-fly and join them simultaneously.
   - Requires: $\lceil B(R)/M \rceil + \lceil B(S)/M \rceil \leq M - 1$
   - Cost: $B(R) + B(S)$ (reads only; results are pipelined)

**Total Cost**: $3(B(R) + B(S))$ I/Os.

![[Merge Join.png]]

### Two-Pass Example

![[Merge join example 1.png]]
![[Merge-Join example 2.png]]
![[Merge Join Example 3.png]]

---

## Related

- [[Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[External Merge-Sort|External Merge-Sort]] — the sorting primitive used for large relations
- [[Single-Pass Hash Join|Hash Join]] — alternative join algorithm (one-pass or two-pass)
- [[Nested Loop Join|Nested Loop Join]] — simpler but higher-cost alternative
