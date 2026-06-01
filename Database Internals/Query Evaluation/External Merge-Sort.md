# CSE444: External Merge-Sort

**External merge-sort** is a multi-pass algorithm for sorting relations that are too large to fit in memory.

## Table of Contents

1. [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Overview|Overview & Terminology]]
2. [[Phase 1 - Run Generation|Phase 1: Run Generation]]
3. [[Phase 2 - Merging Runs|Phase 2: Merging Runs]]
4. [[Sort-Merge Join Integration|Sort-Merge Join Integration]]
5. [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Worked Example|Worked Example ($B(R)=1000, B(S)=800, M=11$)]]

---

## Related
- [[Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[Sort-Merge Join|Sort-Merge Join]] — uses external merge-sort when relations don't fit in memory
