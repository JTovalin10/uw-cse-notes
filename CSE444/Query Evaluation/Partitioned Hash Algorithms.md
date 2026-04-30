# CSE444: Partitioned Hash Join (Grace Join)

**Partitioned hash join** is the standard multi-pass algorithm used when relations are larger than main memory.

## Table of Contents

1. [[CSE444/Query Evaluation/PartitionedHash/Overview|Overview & Key Idea]]
2. [[CSE444/Query Evaluation/PartitionedHash/Algorithm|The Detailed 3-Step Algorithm]]
3. [[CSE444/Query Evaluation/PartitionedHash/Feasibility|Feasibility & Recursive Partitioning]]
4. [[CSE444/Query Evaluation/PartitionedHash/Worked Example|Worked Example ($B(R)=1000, B(S)=800, M=11$)]]

---

## Related
- [[CSE444/Query Evaluation/Single-Pass Hash Join|Single-Pass Hash Join]]
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]]
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]]
