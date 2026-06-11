# Database Internals: Partitioned Hash Join (Grace Join)

**Partitioned hash join** is the standard multi-pass algorithm used when relations are larger than main memory.

## Table of Contents

1. [[Database Internals/Query Evaluation/PartitionedHashComponents/Overview|Overview & Key Idea]]
2. [[Database Internals/Query Evaluation/PartitionedHashComponents/Algorithm|The Detailed 3-Step Algorithm]]
3. [[Database Internals/Query Evaluation/PartitionedHashComponents/Feasibility|Feasibility & Recursive Partitioning]]
4. [[Database Internals/Query Evaluation/PartitionedHashComponents/Worked Example|Worked Example ($B(R)=1000, B(S)=800, M=11$)]]

---

## Related

- [[Database Internals/Query Evaluation/Single-Pass Hash Join|Single-Pass Hash Join]] — the one-pass hash join used when the smaller relation fits in memory
- [[Database Internals/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[Database Internals/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — alternative two-pass join algorithm using sorting instead of hashing
