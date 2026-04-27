# CSE444: External Merge-Sort

**External merge-sort** is a two-phase algorithm for sorting a relation that is too large to fit in memory. It is the foundation of [[CSE444/Query Evaluation/Sort-Merge Join|sort-merge join]] for large relations.

## When to Use

When there is not enough memory for one-pass algorithms (i.e., $B(R) > M$), two-pass algorithms are required. The two key techniques are **sorting** (this file) and **hashing**. External merge-sort handles relations as large as $M^2$ pages.

## Terminology

A **run** is a sorted (increasing) subsequence of the data.

Example of runs separated by `|`: `2, 4, 99, 103 | 88 | 77 | 3, 79, 100 | 2, 50`

Phase 1 produces sorted runs of length $M$; phase 2 merges them into a single sorted output.

## Phase 1: Create Sorted Runs

1. Load $M$ blocks into memory
2. Sort them in memory
3. Write the sorted run back to disk
4. Repeat until all blocks are processed

Each run has length $M$. There are $\lceil B(R) / M \rceil$ runs after phase 1.

![[CSE444/Screenshots/External Merge-Sort step 1.png]]

## Phase 2: Merge Runs

Merge $M - 1$ runs at a time into a single larger sorted run, using 1 buffer page per input run and 1 output buffer:
- Result: runs of length $M(M-1) \approx M^2$
- If $B(R) \leq M^2$, the entire relation is sorted after one merge pass

![[CSE444/Screenshots/External Merge Sort phase 2.png]]

### Example

![[CSE444/Screenshots/External Merge-Sort phase 2 example.png]]

## Cost

**Assumption**: $B(R) \leq M^2$

| Step | I/Os |
|---|---|
| Phase 1: read $R$ and $S$ | $B(R) + B(S)$ |
| Phase 1: write runs | $B(R) + B(S)$ |
| Phase 2: read sorted runs | $B(R) + B(S)$ |
| **Total** | $\mathbf{3(B(R) + B(S))}$ |

## Use in Sort-Merge Join

When external merge-sort is used to implement [[CSE444/Query Evaluation/Sort-Merge Join|sort-merge join]], it runs on both relations $R$ and $S$. Rather than fully sorting each relation to disk and then joining, it is more efficient to merge the runs and join **simultaneously** in a single pass.

### Step 1: Run Generation
Generate initial sorted runs for both $R$ and $S$.
- **Cost**: $2(B(R) + B(S))$ — 1 full read + 1 full write per relation.

### Step 2: Merge and Join
Merge the sorted runs of $R$ and $S$ while simultaneously performing the join.
- **Memory Layout**:
    - Allocate **one input buffer** for every sorted run (total runs = $k_R + k_S$).
    - Allocate **one output buffer** for the final joined results.
- **Process**:
    1. Peek at the first tuple of every run buffer.
    2. Pick the tuple with the smallest join key across all runs.
    3. If there is a match between $R$ and $S$, move it to the output buffer.
    4. Advance the pointer in the run that had the smallest key.
    5. If a run buffer becomes empty, load the next page from that specific run on disk.
- **Cost**: $B(R) + B(S)$ — read only.

**Total cost for sort-merge join**: $\mathbf{3(B(R) + B(S))}$

This is feasible when $B(R) + B(S) \leq M^2$.

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — uses external merge-sort when relations don't fit in memory
