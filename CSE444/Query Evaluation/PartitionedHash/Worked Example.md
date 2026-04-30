# Partitioned Hash Join: Worked Example

## Problem: $B(R) = 1000, B(S) = 800, M = 11$

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
