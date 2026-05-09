# Course: Advanced Query Execution

Modern query engines utilize advanced techniques to overcome the bottlenecks of the traditional Volcano iterator model, specifically targeting CPU efficiency and data locality.

## Execution Models

### Volcano (Iterator) Model
The **Volcano Model** (also known as the Iterator Model) is the classic query execution strategy where each operator implements a `Next()` method.
- **Mechanism**: The root operator calls `Next()` on its children, which recursively pull tuples up the plan tree one by one.
- **Problem**: High overhead due to millions of virtual function calls and poor CPU cache utilization.

### Vectorized (Batch) Model
The **Vectorized Model** processes a batch of tuples (a vector) at a time rather than a single tuple.
- **Advantage**: Reduces the number of function calls and allows the compiler to use **Single Instruction, Multiple Data (SIMD)** instructions to process multiple values in a single CPU cycle.
- **Performance**: Significant improvement for analytical workloads (OLAP) as data remains in the CPU's L1/L2 caches longer.

### Just-In-Time (JIT) Compilation
**Just-In-Time (JIT) Compilation** generates machine code for a specific query at runtime.
- **Benefit**: Eliminates the interpreter overhead and allows for aggressive inlining of complex expressions and data type-specific optimizations.

## Optimization Techniques

### Predicate Pushdown
**Predicate Pushdown** is a fundamental optimization that moves filter conditions as low as possible in the query plan.
- **Goal**: Reduce the number of rows processed by higher-level operators (especially Joins), minimizing I/O and memory usage.

### Join Algorithms
1. **Nested Loop Join (NLJ)**: The simplest join; for every row in the outer table, scan the entire inner table.
2. **Hash Join**: Build a hash table on the smaller table and probe it with rows from the larger table. Highly efficient for equi-joins.
3. **Sort-Merge Join**: Sort both tables on the join key and then merge them. Best for range-based joins or when data is already sorted.

### Cardinality and Selectivity Estimation
The query optimizer relies on statistics to estimate how many rows will pass through a filter or join.
- **Selectivity**: The probability that a tuple satisfies a predicate.
- **Cardinality**: The estimated number of rows in the result set ($Cardinality = Total Rows \times Selectivity$).

## Related
- [[CSE444/Query Optimization/Query Optimization|Query Optimization Hub]]
- [[CSE444/Query Evaluation/Query Execution & Algorithms|Query Execution & Algorithms]]
