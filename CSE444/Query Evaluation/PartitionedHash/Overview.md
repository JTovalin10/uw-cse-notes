# Partitioned Hash Join: Overview

**Partitioned hash join** (also known as **Grace Join**) is the standard multi-pass algorithm used when relations are larger than main memory. It uses a "Divide and Conquer" strategy to split data into manageable chunks.

---

## Key Idea

When neither relation fits in memory ($B(R) > M$ and $B(S) > M$), we use a two-pass algorithm that partitions the data on disk.

- **Partitioning Strategy**: Split $R$ and $S$ into $k = M-1$ buckets on disk.
- **Partition Size**: Assuming **uniform distribution**, each bucket has size $B(R_i) = \frac{B(R)}{k}$ and $B(S_i) = \frac{B(S)}{k}$.
- **Goal**: Each build partition (e.g., $R_i$) must fit in the $M-2$ pages of the main memory build area.

![[CSE444/Screenshots/Partitioned Hash Algorithm.png]]

**Total Ideal Cost**: $3(B(R) + B(S))$ I/Os.

---

## Why we use this specific Buffer Allocation?

Memory $M$ is a **zero-sum game**. Every page used for input is a page **not** used for an output bin or a build table.

1.  **Maximizing Fan-out ($k$)**: In Phase 1, we use only **1 input page** so we can have $M-1$ output bins.
2.  **Why not create more buckets initially?**: We are physically limited by RAM. Each bucket *must* have its own 1-page Output Buffer to ensure **Sequential I/O**.
3.  **Sequential I/O**: Buffers ensure we only write to disk in full-page chunks (sequential I/O).
4.  **The Result Buffer**: In Phase 2, we "sacrifice" one more page for the **Output Buffer** so that we don't have to perform a disk write for every single match found.
