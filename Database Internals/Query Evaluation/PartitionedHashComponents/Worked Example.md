# Database Internals: Partitioned Hash Join — Worked Example

## Problem: $B(R) = 1000$, $B(S) = 800$, $M = 11$

We want to compute $R \bowtie S$ using partitioned hash join with only 11 buffer pages available. We treat $R$ as the build relation (smaller relative to the build memory constraint).

### Pass 1: Initial Partitioning (Steps 1 and 2)

With $M = 11$, we create **10 buckets** ($M - 1 = 10$).

**Memory layout**: 1 input buffer + 10 output buffers = 11 = $M$.

- **Read cost**: Read $1000$ ($R$) + $800$ ($S$) = **1,800 I/Os**.
- **Write cost**: Write all partitions: $1000$ ($R_i$ files) + $800$ ($S_i$ files) = **1,800 I/Os**.
- **Cost of Pass 1**: $1800 + 1800 = \mathbf{3600}$ I/Os.

Resulting partition size (assuming uniform distribution):

$$B(R_i) = \frac{1000}{10} = \mathbf{100 \text{ pages per bucket}}$$

### Feasibility Check — Why We Must Recurse

- **Build memory limit**: $M - 2 = \mathbf{9 \text{ pages}}$.
- **Check**: $B(R_i) = 100 > 9 = M - 2$. **Fails** — each build partition is far too large to fit in memory during the join phase.

We cannot yet perform Step 3. A second partitioning pass is required to shrink each $R_i$ further.

### Pass 2: Recursive Partitioning (Repeat Steps 1 and 2 on Sub-Buckets)

Take each of the 10 buckets and split each one into 10 smaller sub-buckets using a new hash function.

**Memory layout**: same as Pass 1 — 1 input buffer + 10 output buffers.

- **Read/Write cost**: Process all $1000 + 800 = 1800$ pages again = **3,600 I/Os**.

Resulting sub-bucket size:

$$B(R_{i,j}) = \frac{100}{10} = \mathbf{10 \text{ pages per sub-bucket}}$$

**Check**: $10 > 9 = M - 2$. **Fails again** — the sub-buckets are still slightly too large. Because $R$ is the build relation and $B(R) = 1000$ is relatively large compared to $M = 11$, a third partitioning pass is required.

### Pass 3: Third Partitioning Pass

Split each sub-bucket into 10 even smaller sub-sub-buckets.

- **Cost**: $2 \times 1800 = \mathbf{3600}$ I/Os.

Resulting sub-sub-bucket size:

$$B(R_{i,j,k}) = \frac{10}{10} = \mathbf{1 \text{ page per sub-sub-bucket}}$$

**Check**: $1 \leq 9 = M - 2$. **Passes.** Step 3 (join phase) is now feasible.

### Final Join Pass (Step 3)

For each matching sub-sub-bucket pair, read $R_{i,j,k}$ into memory (at most 1 page), build a hash table, then probe with the matching $S_{i,j,k}$.

- **Cost**: Read all of $R$ + all of $S$ once: $1000 + 800 = \mathbf{1800}$ I/Os.

### Total Cost (3 Partitioning Passes + 1 Join Pass)

$$\text{Total} = 3600 \text{ (P1)} + 3600 \text{ (P2)} + 3600 \text{ (P3)} + 1800 \text{ (Join)} = \mathbf{12{,}600 \text{ I/Os}}$$

Using the formula: $(2P + 1)(B(R) + B(S)) = (2 \times 3 + 1) \times 1800 = 7 \times 1800 = \mathbf{12{,}600}$.

---

## Visual Examples

![[Partitioned Hash Join ex1.png]]
![[Partitioned Hash Join 6.png]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Recursive partitioning | Multi-pass hash join / hybrid hash join overflow |
| Pass $P$ | Partitioning level |

## Related

- [[Database Internals/Query Evaluation/PartitionedHashComponents/Overview|Overview & Key Idea]]
- [[Database Internals/Query Evaluation/PartitionedHashComponents/Algorithm|The Algorithm]]
- [[Database Internals/Query Evaluation/PartitionedHashComponents/Feasibility|Feasibility & Recursive Partitioning]]
- [[Database Internals/Query Evaluation/ExternalMergeSortComponents/Worked Example|Sort-Merge Join Worked Example]] — comparable scenario with $B(R)=1000, B(S)=800, M=11$
