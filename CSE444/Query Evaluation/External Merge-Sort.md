# CSE444: External Merge-Sort

**External merge-sort** is a multi-pass algorithm for sorting relations that are too large to fit in memory.

## Table of Contents

1. [[CSE444/Query Evaluation/ExternalMergeSort/Overview|Overview & Terminology]]
2. [[CSE444/Query Evaluation/ExternalMergeSort/Phase 1 - Run Generation|Phase 1: Run Generation]]
3. [[CSE444/Query Evaluation/ExternalMergeSort/Phase 2 - Merging Runs|Phase 2: Merging Runs]]
4. [[CSE444/Query Evaluation/ExternalMergeSort/Sort-Merge Join Integration|Sort-Merge Join Integration]]
5. [[CSE444/Query Evaluation/ExternalMergeSort/Worked Example|Worked Example ($B(R)=1000, B(S)=800, M=11$)]]

---

## Related
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — uses external merge-sort when relations don't fit in memory
