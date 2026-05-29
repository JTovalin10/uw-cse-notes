# External Merge-Sort: Worked Example

## Problem: $B(R) = 1000$, $B(S) = 800$, $M = 11$

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
