# CSE444: Partitioned Hash Join (Grace Join)

**Partitioned hash join** is the standard multi-pass algorithm used when relations are larger than main memory. It uses a "Divide and Conquer" strategy to split data into manageable chunks.

---

## Key Idea

When neither relation fits in memory ($B(R) > M$ and $B(S) > M$), we use a two-pass algorithm that partitions the data on disk.

- **Partitioning Strategy**: Split $R$ and $S$ into $k = M-1$ buckets on disk.
- **Partition Size**: Assuming **uniform distribution**, each bucket has size $B(R_i) = \frac{B(R)}{k}$ and $B(S_i) = \frac{B(S)}{k}$.
- **Goal**: Each build partition (e.g., $R_i$) must fit in the $M-2$ pages of the main memory build area.

![[CSE444/Screenshots/Partitioned Hash Algorithm.png]]

---

## The Detailed 3-Step Algorithm

### Step 1: Hash S into M-1 buckets & Send to Disk
- **Goal**: Split relation $S$ into $k = M-1$ smaller files on disk.
- **The Process (Internal Shuffle)**:
    1.  **Load**: Read one page of $S$ from disk into the **1-page Input Buffer**.
    2.  **Scan & Hash**: The CPU iterates through every tuple in that Input Buffer and calculates $h_1(join\_key)$.
    3.  **Internal Copy**: Based on the hash (e.g., result is `3`), the CPU **copies** the tuple from the Input Buffer to **Output Buffer #3** in RAM.
    4.  **Flush**: When an Output Buffer hits the **Disk Page Size** (e.g., 8KB), its contents are written to a **new partition file** on disk (e.g., $S_3.dat$) and the buffer is reset to empty.
    5.  **Repeat**: Once the Input Buffer is fully scanned, load the next page of $S$ until finished.

### Step 2: Hash R into M-1 buckets & Send to Disk
- **Goal**: Split relation $R$ using the **exact same process and hash function ($h_1$)**.
- **Result**: Because we use the same $h_1$, matching tuples from $R$ and $S$ end up in the same numbered bucket (e.g., $R_3$ and $S_3$).

### Step 3: Join Buckets (Build & Match)
- **Memory Layout**: $M-2$ pages for the **Build Table**, 1 page for **Input (Probe)**, 1 page for **Output (Result)**.
- **The Process (The Bucket Loop)**:
    For each bucket pair $i$:
    1.  **Build**: **Read one partition of $R$ and create a hash table in memory using a different hash function ($h_2$)**. This partition ($R_i$) is **pinned** in the $M-2$ build pages until matching with $S_i$ is complete.
    2.  **Probe (Stream)**: Read the matching partition $S_i$ into the **1-page Input Buffer** one page at a time.
    3.  **Match**: Probe the **pinned** $R_i$ hash table with tuples from the current page of $S_i$. Matches are moved to the **1-page Output Buffer**.
    4.  **Flush**: When the Output Buffer becomes full (reaches the Disk Page Size), it is **flushed (written) to disk** and reset.
    5.  **Next Page**: Overwrite the input buffer with the next page of $S_i$ until $S_i$ is finished.
    6.  **Clear**: Clear RAM (unpin $R_i$) and move to the next bucket pair.W.

**Total Ideal Cost**: $3(B(R) + B(S))$ I/Os.

---

## Why we use this specific Buffer Allocation?

Memory $M$ is a **zero-sum game**. Every page used for input is a page **not** used for an output bin or a build table.

1.  **Maximizing Fan-out ($k$)**: In Phase 1, we use only **1 input page** so we can have $M-1$ output bins.
2.  **Why not create more buckets initially?**: We are physically limited by RAM. Each bucket *must* have its own 1-page Output Buffer to ensure **Sequential I/O**.
3.  **Sequential I/O**: Buffers ensure we only write to disk in full-page chunks (sequential I/O).
4.  **The Result Buffer**: In Phase 2, we "sacrifice" one more page for the **Output Buffer** so that we don't have to perform a disk write for every single match found.

---

## Feasibility & Recursive Partitioning

### 1. Calculating Partition Size ($B(R_i)$)
Before Step 3, we estimate the build partition size. We assume **Uniform Hashing**:
- **The Calculation**: $B(R_i) = \frac{B(R)}{M-1}$

### 2. The Feasibility Check
For Step 3 to work, the entire build partition **must fit** in the allocated build memory ($M-2$ pages):
$$\text{Condition: } B(R_i) \leq M - 2$$

### 3. How many passes ($P$) are needed?
We need enough passes so that the total capacity of all buckets ($M-1$ per pass) covers the relation size:
$$\boxed{B(R) \leq (M-1)^P \cdot (M-2)}$$

### 4. Recursive Partitioning (The "Overflow" Strategy)
If $B(R_i) > M - 2$, the DBMS must **Recurse**:
- **Strategy**: Treat the oversized bucket pair as a new join problem and "re-split" the hashed bucket files into even smaller sub-buckets.
- **Cost**: Each extra partitioning level adds $2(B(R) + B(S))$ I/Os.
- **Total Multiplier**: $(2P + 1)$, where $P$ is the total number of partitioning passes.

---

## Explicit Worked Example: $B(R) = 1000, B(S) = 800, M = 11$

### Pass 1: Initial Partitioning (Steps 1 & 2)
With $M=11$, we create **10 buckets** ($M-1=10$).
- **Read Cost**: Read 1,000 ($R$) + 800 ($S$) = **1,800 I/Os**.
- **Write Cost**: Write 1,000 ($R_i$) + 800 ($S_i$) = **1,800 I/Os**.
- **Cost of Pass 1**: $1800 + 1800 = \mathbf{3600 \text{ I/Os}}$.
- **Resulting Bucket Size ($R$ is Build)**:
    - $B(R_i) = 1000 / 10 = \mathbf{100 \text{ pages per bucket}}$.

### Feasibility Check (Why we must recurse)
- **Build Limit**: $M-2 = \mathbf{9 \text{ pages}}$.
- **Check**: Our build bucket $R_i$ is **100 pages**. Since $100 > 9$, Step 3 fails.

### Pass 2: Recursive Partitioning (Repeat Steps 1 & 2)
We take the 10 buckets and split each one into 10 smaller "sub-buckets."
- **Read/Write Cost**: Process all 1,800 pages again = **3,600 I/Os**.
- **Resulting Sub-bucket Size**:
    - $B(R_{i,j}) = 100 / 10 = \mathbf{10 \text{ pages per sub-bucket}}$.
- **Check**: $10 > 9$. **FAILED AGAIN.** (Note: Because $R$ is the build relation and it's larger, we need a 3rd partitioning pass or a smaller bucket).

*Self-Correction: With $B(R)=1000$ and $M=11$, we actually need 3 passes if we build on R.*

### Total Cost (3 Passes)
- **Grand Total**: $3600 (\text{P1}) + 3600 (\text{P2}) + 3600 (\text{P3}) + 1800 (\text{Join}) = \mathbf{12,600 \text{ I/Os}}$.
- **Formula**: $(2(3)+1) \times 1800 = 7 \times 1800 = \mathbf{12,600}$.

---

## Visual Examples
![[CSE444/Screenshots/Partitioned Hash Join ex1.png]]
![[CSE444/Screenshots/Partitioned Hash Join 6.png]]

- [[CSE444/Query Evaluation/Single-Pass Hash Join|Single-Pass Hash Join]]
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]]
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]]
