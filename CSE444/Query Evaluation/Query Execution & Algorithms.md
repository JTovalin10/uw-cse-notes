# CSE444: Query Execution & Algorithms

## Query Processor Overview

The **Query Processor** is responsible for two major phases:

- **[[CSE444/Query Optimization/Query Optimization|Query Optimization]]**: finding an efficient execution plan.
- **Query Execution**: executing the chosen plan via physical operators.

An SQL query is transformed into a **Physical Plan**. Each operator in the plan is allocated a limited amount of memory (often called a "buffer quota"). Key decisions in this transformation include:

- **Access Path Selection**: Choosing how to retrieve data from each relation (e.g., **File Scan** vs. **Index Scan**).
- **Implementation Choice**: Selecting the algorithm for each operator (e.g., **[[CSE444/Query Evaluation/Partitioned Hash Algorithms|Hash Join]]** vs. **[[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]]**).
- **Scheduling Decisions**: Determining execution strategy (Single-threaded vs. Parallel, Pipelined vs. Materialized).

## Execution Models

### Volcano (Iterator) Model
The **Volcano Model** (also known as the **Iterator Model** or **Pull Model**) is the classic query execution strategy where each operator implements a standard interface:
- `open()`: Initializes operator state.
- `next()`: Returns the next tuple in the result stream.
- `close()`: Cleans up resources.

The root operator drives execution by calling `next()`, which propagates down the tree. This enables **Pipelining**, where operators run concurrently without needing to fully materialize intermediate results on disk.

**Problem**: Modern systems find this model inefficient for high-performance analytical workloads due to millions of virtual function calls and poor CPU cache utilization when processing one tuple at a time.

### Vectorized (Batch) Model
The **Vectorized Model** processes a **batch of tuples** (a vector) at a time rather than a single tuple.
- **Advantage**: Significantly reduces the number of function calls and allows the compiler to utilize **Single Instruction, Multiple Data (SIMD)** instructions to process multiple values in a single CPU cycle.
- **Performance**: Data remains in the CPU's L1/L2 caches longer, making it ideal for Online Analytical Processing (OLAP) workloads.

### Just-In-Time (JIT) Compilation
**Just-In-Time (JIT) Compilation** involves generating machine code for a specific query at runtime.
- **Benefit**: It eliminates interpreter overhead and enables aggressive inlining of complex expressions and data-type-specific optimizations, effectively "fusing" operators together into a tight loop.

## Memory Management

Each operator manages its own memory state. There are two primary strategies for representing tuples as they flow through the plan:

1. **BP-Tuples**: Pointers to data in the **[[CSE444/DBMS Architecture and Deployments/Subsystems/Buffer Manager|Buffer Pool]]**.
2. **M-Tuples**: New tuples allocated directly on the **Heap**.

### BP-Tuples
A **BP-Tuple** (Buffer Pool Tuple) is a descriptor that holds a pointer directly into a page residing in the buffer pool, avoiding the overhead of copying data.

When an operator constructs a BP-tuple, it must **increment the pin count** of the corresponding page. The pin count is decremented when the descriptor is cleared, ensuring the page is not evicted by the **[[CSE444/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]]** while in use.

**Pros:**
- **Zero-copy**: Excellent performance by reading data in-place.

**Cons:**
- **Pinning Pressure**: Holding pages pinned can exhaust the buffer pool under high concurrency.
- **Static Content**: Cannot represent computed or derived values (e.g., arithmetic results).

### M-Tuples
An **M-Tuple** (Memory Tuple) is fully materialized; the data is copied out of the buffer pool and stored as a new allocation on the heap.

**Pros:**
- **Flexibility**: Can represent new or derived values (computed columns, aggregations).
- **Reduced Pinning**: Pages are only pinned briefly during the copy operation.

**Cons:**
- **Copy Overhead**: Data copying introduces CPU and memory bandwidth overhead, scaling with relation size.

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

---

## Industry Standard Terms
- **BP-Tuples** $\rightarrow$ Zero-copy Tuples / Pinned Tuples
- **M-Tuples** $\rightarrow$ Materialized Tuples / Heap-allocated Tuples
- **Iterator Interface** $\rightarrow$ Volcano Model / Pull Model
- **Access Path Selection** $\rightarrow$ Access Method Selection
- **Vectorized** $\rightarrow$ Batch Processing

## Related
- [[CSE444/Query Optimization/Query Optimization|Query Optimization Hub]]
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]]
- [[CSE444/DBMS Architecture and Deployments/Architecture|DBMS Architecture and Query Processing]]
- [[CSE444/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]]
- [[CSE332/ADT and Design/Iterators|CSE332 Iterators]]
