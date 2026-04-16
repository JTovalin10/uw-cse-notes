# CSE444: External Merge-Sort

**External merge-sort** is a two-pass sorting algorithm for relations too large to fit in memory. It is the foundation of two-pass query operators such as [[CSE444/Query Evaluation/Sort-Merge Join|sort-merge join]].

## When to Use

When there is not enough memory for one-pass algorithms (i.e., $B(R) > M$), two-pass algorithms are required. The two key techniques are **sorting** (this file) and **hashing**. External merge-sort handles relations as large as $M^2$ pages.

## Terminology

A **run** is a sorted (increasing) subsequence of the data.

Example of runs separated by `|`: `2, 4, 99, 103 | 88 | 77 | 3, 79, 100 | 2, 50`

Phase 1 produces sorted runs of length $M$; phase 2 merges them into a single sorted output.

## Cost

**Assumption**: $B(R) \leq M^2$

**Total cost**: $3B(R)$

| Step | I/Os |
|---|---|
| Phase 1: read $R$ | $B(R)$ |
| Phase 1: write runs | $B(R)$ |
| Phase 2: read sorted runs | $B(R)$ |
| **Total** | $3B(R)$ |

## Phase 1: Create Sorted Runs

1. Load $M$ blocks into memory
2. Sort them in memory
3. Write the sorted run back to disk
4. Repeat until all blocks are processed

Each run has length $M$. There are $\lceil B(R) / M \rceil$ runs after phase 1.

![[CSE444/screenshots/External Merge-Sort step 1.png]]

## Phase 2: Merge Runs

Merge $M - 1$ runs at a time into a single larger sorted run, using 1 buffer page per input run and 1 output buffer:
- Result: runs of length $M(M-1) \approx M^2$
- If $B(R) \leq M^2$, the entire relation is sorted after one merge pass

![[CSE444/screenshots/External Merge Sort phase 2.png]]

### Example

![[CSE444/screenshots/External Merge-Sort phase 2 example.png]]

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — uses external merge-sort when relations don't fit in memory
