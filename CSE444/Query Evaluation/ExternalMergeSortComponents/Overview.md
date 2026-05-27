# External Merge-Sort: Overview

**External merge-sort** is a two-phase algorithm for sorting a relation that is too large to fit in memory. It is the foundation of [[CSE444/Query Evaluation/Sort-Merge Join|sort-merge join]] for large relations.

## When to Use

When there is not enough memory for one-pass algorithms (i.e., $B(R) > M$), two-pass algorithms are required. The two key techniques are **sorting** (this file) and **hashing**. The basic two-pass external merge-sort handles a single relation as large as $M^2$ pages. When used for sort-merge join over two relations $R$ and $S$, the two-pass version requires $B(R) + B(S) \leq M^2$ — both relations together must fit within that bound. For larger relations, additional merge passes are required.

## Terminology

- **Run**: a sorted (increasing) subsequence of the data, stored as contiguous pages on disk
- **$M$**: the number of buffer pages available in memory (the buffer pool size)
- **$B(R)$**: the number of disk pages in relation $R$

Example of runs separated by `|`: `2, 4, 99, 103 | 88 | 77 | 3, 79, 100 | 2, 50`

Phase 1 produces sorted runs of length $M$; phase 2 merges them into a single sorted output.

## Cost Summary

### Two-pass (when $B(R) \leq M^2$)

| Step | Read | Write | I/Os |
|---|---|---|---|
| Phase 1: generate sorted runs | $B(R)$ | $B(R)$ | $2B(R)$ |
| Phase 2: merge all runs (final pass, pipelined) | $B(R)$ | — | $B(R)$ |
| **Total** | | | $\mathbf{3B(R)}$ |

### Multi-pass (when $B(R) > M^2$)

| Pass | I/Os |
|---|---|
| Phase 1 (run generation) | $2B(R)$ |
| Each intermediate merge pass (read + write) | $2B(R)$ |
| Final merge pass (read only, output pipelined) | $B(R)$ |
| **Total** | $B(R) \cdot (3 + 2 \cdot \text{intermediate passes})$ |

The final pass always costs $B(R)$ — whether there were intermediate steps or not — because the output is pipelined directly into the join operator and never written to disk. Intermediate passes cost $2B(R)$ because their output must be written back to disk for the next pass to consume.

The formula $\lceil \log_{M-1}(\lceil B(R)/M \rceil) \rceil$ gives the **total number of merge passes** (intermediate + final). Intermediate passes = total − 1, since the last pass is always the final read-only pass.

**Example**: $M = 100$, $B(R) = 1{,}000{,}000$
- Phase 1: $\lceil 1{,}000{,}000 / 100 \rceil = 10{,}000$ runs
- Total merge passes: $\lceil \log_{99}(10{,}000) \rceil = \lceil 2.07 \rceil = 3$ → so **2 intermediate passes + 1 final pass**
- After intermediate pass 1: $\lceil 10{,}000 / 99 \rceil = 102$ runs — still $> M-1$
- After intermediate pass 2: $\lceil 102 / 99 \rceil = 2$ runs — $2 \leq M-1 = 99$ ✓, final pass is now feasible
- Cost: $B(R) \cdot (3 + 2 \cdot 2) = 7B(R)$
