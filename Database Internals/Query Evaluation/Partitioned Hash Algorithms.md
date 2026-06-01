# CSE444: Partitioned Hash Join (Grace Join)

**Partitioned hash join** is the standard multi-pass algorithm used when relations are larger than main memory.

## Table of Contents

1. [[Database Internals/Query Evaluation/PartitionedHashComponents/Overview|Overview & Key Idea]]
2. [[Algorithm|The Detailed 3-Step Algorithm]]
3. [[Feasibility|Feasibility & Recursive Partitioning]]
4. [[Database Internals/Query Evaluation/PartitionedHashComponents/Worked Example|Worked Example ($B(R)=1000, B(S)=800, M=11$)]]

---

## Related
- [[Single-Pass Hash Join|Single-Pass Hash Join]]
- [[Operator Algorithms|Operator Algorithms]]
- [[Sort-Merge Join|Sort-Merge Join]]
