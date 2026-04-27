# CSE444: Sort-Merge Join

d**Sort-merge join** $R \bowtie S$ is a join algorithm that sorts both relations on the join attribute and then merges them in a linear scan. It can be implemented as either a one-pass or two-pass algorithm depending on available memory.

## One-Pass Algorithm

If both relations fit entirely in main memory ($B(R) + B(S) \leq M$), sort-merge join is a one-pass algorithm.

1. Scan $R$ and sort in memory.
2. Scan $S$ and sort in memory.
3. Merge $R$ and $S$ on the join attribute.

**Cost**: $B(R) + B(S)$

![[CSE444/Screenshots/Sort-Merge Join.png]]

## Two-Pass Algorithm (Sort-Merge Join)

 **[[CSE444/Query Evaluation/External Merge-Sort|External Merge-Sort]]**


![[CSE444/Screenshots/Merge Join.png]]

### Two-Pass Example

![[CSE444/Screenshots/Merge join example 1.png]]
![[CSE444/Screenshots/Sort-Merge Join example 2.png]]
![[CSE444/Screenshots/Merge Join Example 3.png]]

---

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[CSE444/Query Evaluation/External Merge-Sort|External Merge-Sort]] — the sorting primitive used for large relations
- [[CSE444/Query Evaluation/Hash Join|Hash Join]] — alternative join algorithm (one-pass or two-pass)
- [[CSE444/Query Evaluation/Nested Loop Join|Nested Loop Join]] — simpler but higher-cost alternative
