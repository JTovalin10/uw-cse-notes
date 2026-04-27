# CSE444: Operator Algorithms

## Design Criteria

When evaluating the quality of an operator algorithm, three criteria are considered:

- **Cost**: measured in I/O, CPU, and network operations
  - The cost of reading operands from disk is the primary concern
  - The cost of writing the final result to disk is *not* included in operator cost estimates — it must be counted separately when applicable
- **Memory utilization**: how much buffer pool memory the operator requires
- **Load balance**: for parallel operators, how evenly work is distributed across workers

## Cost Parameters

For simplicity, **cost** is defined as the total number of I/Os. Reading from memory is free; this is a simplification that ignores CPU and network costs.

The standard parameters used in cost formulas are:

- **$B(R)$**: number of disk blocks (pages) for relation $R$
  - For a sequential scan, the cost is $B(R)$
- **$T(R)$**: number of tuples in relation $R$
- **$V(R, a)$**: number of distinct values of attribute $a$ in relation $R$
  - When $a$ is a key, $V(R, a) = T(R)$
  - Otherwise, $V(R, a)$ can be any value $\leq T(R)$

**$M$** denotes the number of memory buffers (pages) available to the operator.

## Algorithm Families

Join algorithms are classified into three families depending on how many passes over the data they require:

### One-Pass Algorithms
Require one relation to fit entirely in memory (§15.2–15.3):
- [[CSE444/Query Evaluation/Single-Pass Hash Join|Single-Pass Hash Join]] — default; build hash table on smaller relation, probe with larger; cost $B(R) + B(S)$ when $B(R) \leq M$
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — sort both relations then merge; cost $B(R) + B(S)$ when $B(R) + B(S) \leq M$

### Index-Based Algorithms
Exploit an existing index on one relation to avoid full scans (§15.6):
- [[CSE444/Query Evaluation/Index-Based Algorithms|Index-Based Selection and Join]] — clustered index costs $B(R)/V(R,a)$; unclustered costs $T(R)/V(R,a)$

### Two-Pass Algorithms
Sort or hash-partition the data before joining; handle relations larger than memory (§15.4–15.5):
- [[CSE444/Query Evaluation/External Merge-Sort|External Merge-Sort]] — produces sorted runs then merges; total cost $3B(R)$; requires $B(R) \leq M^2$
- [[CSE444/Query Evaluation/Nested Loop Join|Nested Loop Join]] — tuple-based, page-at-a-time, and block-memory variants; best case cost $B(R) + B(S) \cdot \lceil B(R)/(M-1) \rceil$

## Related

- [[CSE444/Query Evaluation/Query Execution & Algorithms|Query Execution]] — iterator interface, BP-tuples vs. M-tuples
- [[CSE444/Query Optimization/Query Optimization|Query Optimization]]
