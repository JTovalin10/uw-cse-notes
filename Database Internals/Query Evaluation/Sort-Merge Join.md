# Database Internals: Sort-Merge Join

**Sort-merge join** $R \bowtie S$ is a join algorithm that sorts both relations on the join attribute and then merges them in a linear scan. It can be implemented as either a one-pass or two-pass algorithm depending on available memory.

## One-Pass Algorithm

If both relations fit entirely in main memory ($B(R) + B(S) \leq M$), sort-merge join is a one-pass algorithm.

1. Scan $R$ and sort it in memory.
2. Scan $S$ and sort it in memory.
3. Merge $R$ and $S$ on the join attribute.

**Cost**: $B(R) + B(S)$

![[Sort-Merge Join.png]]

## Two-Pass Algorithm (Sort-Merge Join)

When relations do not fit in memory ($B(R) + B(S) > M$), we use the two-pass version, which integrates with **[[Database Internals/Query Evaluation/External Merge-Sort|External Merge-Sort]]**.

The key insight of the two-pass algorithm is that we do not need to fully sort each relation to disk before joining. Instead, we generate sorted runs in the first pass and then merge all runs from both relations simultaneously while performing the join in the second pass. This avoids writing fully sorted copies of $R$ and $S$ to disk.

1. **Step 1 — Run Generation**: Generate sorted runs of length $M$ for both $R$ and $S$.
   - Cost: $2(B(R) + B(S))$ — one full read and one full write per relation.
2. **Step 2 — Merge + Join**: Load the head page of every run from both relations into memory. Merge the runs of $R$ and $S$ on-the-fly while performing the join simultaneously.
   - Feasibility requirement: $\lceil B(R)/M \rceil + \lceil B(S)/M \rceil \leq M - 1$ — all run buffers plus one output buffer must fit in $M$ pages.
   - Cost: $B(R) + B(S)$ (reads only; results are pipelined directly to the output buffer).

**Total Cost**: $3(B(R) + B(S))$ I/Os.

![[Merge Join.png]]

### Two-Pass Example

![[Merge join example 1.png]]
![[Merge-Join example 2.png]]
![[Merge Join Example 3.png]]

### Why the Two-Pass Feasibility Constraint Matters

The constraint $\lceil B(R)/M \rceil + \lceil B(S)/M \rceil \leq M - 1$ ensures that all run input buffers (one per run of $R$ and one per run of $S$) plus one output buffer fit within the $M$ available buffer pages. If this constraint is violated — for example, when $B(R)$ and $B(S)$ are both much larger than $M^2$ — intermediate merge passes are required to reduce the run counts before the merge+join pass becomes feasible. The [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Worked Example|worked example]] ($B(R)=1000, B(S)=800, M=11$) illustrates this multi-pass scenario.

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Sort-Merge Join | Merge join / sort-merge join (SMJ) |
| Run | Sorted run / sorted chunk |
| Merge + Join pass | Merge join phase |

## Related

- [[Database Internals/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[Database Internals/Query Evaluation/External Merge-Sort|External Merge-Sort]] — the sorting primitive used for large relations
- [[Database Internals/Query Evaluation/Single-Pass Hash Join|Single-Pass Hash Join]] — alternative join algorithm (one-pass or two-pass)
- [[Database Internals/Query Evaluation/Nested Loop Join|Nested Loop Join]] — simpler but higher-cost alternative
