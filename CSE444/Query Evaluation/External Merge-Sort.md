# CSE444: External Merge-Sort

**External merge-sort** is a two-phase algorithm for sorting a relation that is too large to fit in memory. It is the foundation of [[CSE444/Query Evaluation/Sort-Merge Join|sort-merge join]] for large relations.

## When to Use

When there is not enough memory for one-pass algorithms (i.e., $B(R) > M$), two-pass algorithms are required. The two key techniques are **sorting** (this file) and **hashing**. The basic two-pass external merge-sort handles a single relation as large as $M^2$ pages. When used for sort-merge join over two relations $R$ and $S$, the two-pass version requires $B(R) + B(S) \leq M^2$ — both relations together must fit within that bound. For larger relations, additional merge passes are required.

## Terminology

- **Run**: a sorted (increasing) subsequence of the data, stored as contiguous pages on disk
- **$M$**: the number of buffer pages available in memory (the buffer pool size)
- **$B(R)$**: the number of disk pages in relation $R$

Example of runs separated by `|`: `2, 4, 99, 103 | 88 | 77 | 3, 79, 100 | 2, 50`

Phase 1 produces sorted runs of length $M$; phase 2 merges them into a single sorted output.

---

## Phase 1: Create Sorted Runs

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

---

## Phase 2: Merge Runs

**Goal**: merge all the sorted runs produced in phase 1 into one fully sorted output.

**Memory layout**:
- Allocate **$M-1$ pages for the input buffer** — one slot per run, so at most $M-1$ runs can be merged at once
- Allocate **1 output buffer page** for writing resultsa

**Steps**:
1. Load the **first page** of each run into its dedicated input buffer
2. Use a **min-heap (priority queue)** over the front tuple of each input buffer to find the globally smallest tuple
3. Move the minimum tuple to the output buffer
4. Advance the pointer in that run's input buffer
5. If an input buffer page is exhausted, load the **next page of that run** from disk into the same buffer slot
6. If the output buffer is full, flush it to disk
7. Repeat until all input runs are fully consumed

**Result**: merged runs of length $M(M-1) \approx M^2$ pages.
cost: B(R)
### How many runs fit?

Phase 2 can hold at most $M-1$ input buffers at once. For a single merge pass to fully sort the relation:

$$\lceil B(R)/M \rceil \leq M-1 \implies B(R) \leq M(M-1) \approx M^2$$

**If $\lceil B(R)/M \rceil \leq M-1$** (i.e., $B(R) \leq M^2$): all runs fit into the $M-1$ input buffers simultaneously — the entire relation is sorted in a single merge pass.
#### Reducing runs
Otherwise, not all runs fit in memory at once, meaning phase 2 can only **reduce the run count**, not fully sort the relation. Instead of loading all runs simultaneously, process them in **batches of $M-1$**:
- Batch 1: load runs 1 through $M-1$ → merge → write one larger run to disk
- Batch 2: load runs $M$ through $2(M-1)$ → merge → write one larger run to disk
- Continue until all runs are processed

After one such pass:
- Run count shrinks from $\lceil B(R)/M \rceil$ down to $\lceil B(R) / M(M-1) \rceil$
- Each run is now $M(M-1)$ pages long instead of $M$
- The data has been fully read and rewritten, but is **still not a single sorted output** — more passes are needed
- Each additional pass costs $2B(R)$ I/Os and again shrinks the run count by a factor of $M-1$
- Repeat until $\leq M-1$ runs remain, at which point the final pass produces a single sorted output

**Number of merge passes needed** to reduce to 1 run:
$$\text{merge passes} = \lceil \log_{M-1}(\lceil B(R)/M \rceil) \rceil$$

![[CSE444/Screenshots/External Merge Sort phase 2.png]]

### Example

![[CSE444/Screenshots/External Merge-Sort phase 2 example.png]]

---

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

---

## Use in Sort-Merge Join

When used for sort-merge join, external merge-sort runs on both $R$ and $S$. Rather than fully sorting each relation to disk and then joining, it is more efficient to merge the runs and join **simultaneously** in the final pass.

**Feasibility constraint** for two-pass sort-merge join:
$$\lceil B(R)/M \rceil + \lceil B(S)/M \rceil \leq M - 1 \quad \approx \quad B(R) + B(S) \leq M^2$$

### Step 1: Run Generation

Generate initial sorted runs independently for both $R$ and $S$.

- Load $M$ pages of $R$ → sort in memory → write run to disk; repeat for all of $R$
- Do the same for $S$
- **Cost**: $2(B(R) + B(S))$ — 1 full read + 1 full write per relation

### Step 2: Merge and Join Simultaneously

Instead of writing fully sorted copies of $R$ and $S$ to disk, merge the sorted runs of both relations **while performing the join** in a single pass.

**Memory layout**:
- 1 input buffer page per run of $R$ ($k_R = \lceil B(R)/M \rceil$ buffers)
- 1 input buffer page per run of $S$ ($k_S = \lceil B(S)/M \rceil$ buffers)
- 1 output buffer page for joined results
- Constraint: $k_R + k_S + 1 \leq M$, i.e., total runs $\leq M - 1$

**Process**:
1. Load the first page of every run (for both $R$ and $S$) into its input buffer
2. Use a min-heap to find the minimum join-key tuple across all $R$ runs, and separately across all $S$ runs
3. If the minimum $R$ key equals the minimum $S$ key: emit all matching combinations to the output buffer
4. Advance the pointer in the run(s) whose minimum key was consumed
5. When a run buffer is exhausted, load the next page of that run from disk
6. When the output buffer is full, flush it to disk

**Cost**: $B(R) + B(S)$ — reads only; output is pipelined

**Total cost for two-pass sort-merge join**:

| Step | I/Os |
|---|---|
| Step 1: run generation | $2(B(R) + B(S))$ |
| Step 2: merge + join pass | $B(R) + B(S)$ |
| **Total** | $\mathbf{3(B(R) + B(S))}$ |

---

## Worked Example: $B(R) = 1000$, $B(S) = 800$, $M = 11$

This example shows how sort-merge join is performed when $B(R) + B(S) > M^2$, meaning the standard two-pass sort-merge join is not feasible.

First, check the two-pass feasibility condition:
$$B(R) + B(S) = 1000 + 800 = 1800 \quad \not\leq \quad M^2 = 11^2 = 121$$

Since this fails, we cannot sort both relations and join in just two passes. We need intermediate merge passes to reduce the run counts before the final merge+join pass is possible.

### Why two passes are not enough

After phase 1, the number of runs is:
$$k_R = \lceil 1000/11 \rceil = 91 \qquad k_S = \lceil 800/11 \rceil = 73$$

To merge+join simultaneously, we need $k_R + k_S + 1 \leq M$, i.e., $164 + 1 \leq 11$. This fails by a huge margin — we need to chip away at the run counts with intermediate merge passes before the final merge+join pass is feasible.

---

### Phase 1: Generate sorted runs for R and S

**Memory layout**: all 11 buffer frames are used as input — the entire buffer pool is loaded with raw data and sorted in-place.

**For R**:
- Read pages 1–11 of R into all 11 buffers → sort in memory → write **run 1** (11 pages) to disk
- Read pages 12–22 → sort → write **run 2** (11 pages) to disk
- Repeat until all 1000 pages of R are processed
- Last run: pages 991–1000 → 10 pages (the final group is smaller)
- Result: **91 sorted runs** on disk (90 runs × 11 pages + 1 run × 10 pages = 1000 pages total)

**For S**: same process
- Result: **73 sorted runs** on disk (72 runs × 11 pages + 1 run × 8 pages = 800 pages total)

**What is written to disk**: 91 sorted run files for R, 73 for S.

**Phase 1 cost**: $2 \times 1000 + 2 \times 800 = 3600$ I/Os

---

### Phase 2: Intermediate merge pass (reduce run count)

**Memory layout**: 10 input buffers (one per run being merged) + 1 output buffer = 11 total.

**For R** (91 runs → 10 runs):

Process runs in groups of 10 at a time:
- **Groups 1–9** (runs 1–90): each group of 10 runs × 11 pages → 1 merged run of 110 pages
- **Group 10** (run 91 only): 10 pages, passed through as-is
- Result: **10 runs** (9 × 110 + 1 × 10 = 1000 pages)

**What is written to disk**: 10 larger sorted run files for R.

**For R cost**: $2 \times 1000 = 2000$ I/Os

**For S** (73 runs → 8 runs):
- **Groups 1–7** (runs 1–70): 7 groups of 10 → 7 runs of 110 pages each
- **Group 8** (runs 71–73): 3 runs (2 × 11 + 8 = 30 pages) → 1 merged run of 30 pages
- Result: **8 runs** (7 × 110 + 1 × 30 = 800 pages)

**What is written to disk**: 8 larger sorted run files for S.

**For S cost**: $2 \times 800 = 1600$ I/Os

**After phase 2**: $k_R = 10$, $k_S = 8$. Check: $10 + 8 + 1 = 19 > M = 11$. **Still can't merge+join.** One more pass is needed.

---

### Phase 3: Fully sort R

We need $k_R + k_S + 1 \leq M = 11$, so $k_R \leq 2$. Since R has 10 runs and $10 \leq M-1 = 10$, we can merge all 10 at once and fully sort R in one pass.

**Memory layout**: 10 input buffers (one per R run) + 1 output buffer = 11 = M exactly.

**Process**:
- Load the first page of each of R's 10 runs into the 10 input buffers
- Run the min-heap over all 10 run heads, streaming the globally smallest tuple to the output buffer
- When any input buffer empties, load the next page of that run from disk
- When the output buffer fills, flush it to disk

**What is written to disk**: 1 fully sorted copy of R (1000 pages).

**Phase 3 cost**: $1000 \text{ (read)} + 1000 \text{ (write)} = 2000$ I/Os

**After phase 3**: $k_R = 1$, $k_S = 8$. Check: $1 + 8 + 1 = 10 \leq M = 11$. ✓

---

### Phase 4: Merge S's 8 runs while joining with sorted R

Rather than writing a fully sorted S to disk and then joining, we merge S's 8 runs **on-the-fly** while simultaneously performing the merge-join against fully sorted R.

**Memory layout**:

| Buffer(s) | Count | Purpose |
|---|---|---|
| S run buffers | 8 | One page from each of S's 8 sorted runs |
| R input buffer | 1 | Sequential read of fully sorted R (one page at a time) |
| Output buffer | 1 | Accumulates join result tuples |
| **Total** | **10** | $\leq M = 11$ ✓ |

**Process**:
1. Load the first page of each of S's 8 runs and the first page of sorted R
2. Use a min-heap over the 8 S run buffer heads to produce S tuples in sorted order on-the-fly
3. Compare the current minimum S key against the current R key:
   - $R_{key} < S_{key}$: advance R (load next R tuple; reload R buffer page from disk when empty)
   - $S_{key} < R_{key}$: advance S (load next S tuple; reload that run's buffer page from disk when empty)
   - $R_{key} = S_{key}$: emit all matching pairs to the output buffer; flush output to disk when full
4. Continue until both R and all S runs are exhausted

**What is written to disk**: join results only. The 8 S runs and sorted R are read once and never re-written.

**Phase 4 cost**: $1000 \text{ (read R)} + 800 \text{ (read S)} = 1800$ I/Os

---

### Total Cost

| Phase | Operation | Reads | Writes | I/Os |
|---|---|---|---|---|
| 1 | Generate 91 runs for R | 1000 | 1000 | 2000 |
| 1 | Generate 73 runs for S | 800 | 800 | 1600 |
| 2 | Merge R: 91 → 10 runs | 1000 | 1000 | 2000 |
| 2 | Merge S: 73 → 8 runs | 800 | 800 | 1600 |
| 3 | Sort R: 10 → 1 run (written to disk) | 1000 | 1000 | 2000 |
| 4 | Merge 8 S runs + join with sorted R | 1800 | — | 1800 |
| **Total** | | | | **11000** |

Compare to the two-pass case: $3(B(R)+B(S)) = 5{,}400$ I/Os. The extra passes to reduce run counts roughly double the cost.

---

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — uses external merge-sort when relations don't fit in memory
