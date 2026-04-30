# Phase 1: Create Sorted Runs

**Goal**: break $R$ into sorted chunks that each fit in memory.

**Memory layout**: all $M$ buffer pages are used as input — the entire buffer pool is loaded with data from $R$ and sorted in-place.

**Steps** (repeated until all of $R$ is processed):
1. Read the next $M$ pages of $R$ from disk into the $M$ buffer frames
2. Sort all tuples across those $M$ pages entirely in memory (e.g., quicksort)
3. Write the resulting sorted run (all $M$ pages) back to disk as a new file/run

**After phase 1**:
- Each run occupies exactly $M$ pages on disk (except possibly the last run, which may be shorter)
- Total runs produced: $\lceil B(R) / M \rceil$
- **Cost**: read $B(R)$ + write $B(R)$ = $2B(R)$ I/Os

![[CSE444/Screenshots/External Merge-Sort step 1.png]]
