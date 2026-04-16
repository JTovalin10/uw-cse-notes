# CSE444: Sort-Merge Join

**Sort-merge join** $R \bowtie S$ sorts both relations on the join attribute and then merges them in a single linear scan.

## Algorithm

1. Scan $R$ and sort in main memory
2. Scan $S$ and sort in main memory
3. Merge $R$ and $S$ on the join attribute

## Cost

**Cost**: $B(R) + B(S)$

This is a **one-pass algorithm** when $B(R) + B(S) \leq M$ — both tables must fit in memory simultaneously. In practice, this constraint is often not met, making sort-merge join a two-pass algorithm that depends on [[CSE444/Query Evaluation/External Merge-Sort|external merge-sort]] to pre-sort large relations.

## Example

![[CSE444/screenshots/Sort-Merge Join.png]]

1. Scan Patients and sort in memory
2. Scan Insurance and sort in memory
3. Merge Patients and Insurance on the join key

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[CSE444/Query Evaluation/External Merge-Sort|External Merge-Sort]] — used when relations are too large to sort in memory
- [[CSE444/Query Evaluation/Hash Join|Hash Join]] — alternative one-pass join algorithm
- [[CSE444/Query Evaluation/Nested Loop Join|Nested Loop Join]] — simpler but higher-cost alternative
