# Database Internals: External Merge-Sort

**External merge-sort** is a multi-pass algorithm for sorting relations that are too large to fit in memory. It is the foundation of [[Database Internals/Query Evaluation/Sort-Merge Join|sort-merge join]] for large relations.

## Table of Contents

1. [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Overview|Overview & Terminology]]
2. [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Phase 1 - Run Generation|Phase 1: Run Generation]]
3. [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Phase 2 - Merging Runs|Phase 2: Merging Runs]]
4. [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Sort-Merge Join Integration|Sort-Merge Join Integration]]
5. [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Worked Example|Worked Example ($B(R)=1000, B(S)=800, M=11$)]]

---

## Related

- [[Database Internals/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[Database Internals/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — uses external merge-sort when relations do not fit in memory
