# Partitioned Hash Join: Feasibility & Recursion

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
