# CSE444: Query Execution & Algorithms

## Query Processor Overview

The **Query Processor** is responsible for two major phases:

- **[[CSE444/Query Optimization/Query Optimization|Query Optimization]]**: finding an efficient execution plan.
- **Query Execution**: executing the chosen plan via physical operators.

An SQL query is transformed into a **Physical Plan**. Each operator in the plan is allocated a limited amount of memory (often called a "buffer quota"). Key decisions in this transformation include:

- **Access Path Selection**: Choosing how to retrieve data from each relation (e.g., **File Scan** vs. **Index Scan**).
- **Implementation Choice**: Selecting the algorithm for each operator (e.g., **[[CSE444/Query Evaluation/Partitioned Hash Algorithms|Hash Join]]** vs. **[[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]]**).
- **Scheduling Decisions**: Determining execution strategy (Single-threaded vs. Parallel, Pipelined vs. Materialized).

## Memory Management

Each operator manages its own memory state. There are two primary strategies for representing tuples as they flow through the plan:

1. **BP-Tuples**: Pointers to data in the **[[CSE444/DBMS architecture and deployments/Subsystems/Buffer Manager|Buffer Pool]]**.
2. **M-Tuples**: New tuples allocated directly on the **Heap**.

The DBMS enforces strict memory limits to prevent a single query from exhausting system resources.

## BP-Tuples

A **BP-Tuple** (Buffer Pool Tuple) is a descriptor that holds a pointer directly into a page residing in the buffer pool, avoiding the overhead of copying data.

When an operator constructs a BP-tuple, it must **increment the pin count** of the corresponding page. The pin count is decremented when the descriptor is cleared, ensuring the page is not evicted by the **[[CSE444/DBMS architecture and deployments/Subsystems/Buffer Manager|Buffer Manager]]** while in use.

![[Screenshots/BP-Tuples.png]]

**Pros:**
- **Zero-copy**: Excellent performance by reading data in-place.

**Cons:**
- **Pinning Pressure**: Holding pages pinned can exhaust the buffer pool under high concurrency.
- **Static Content**: Cannot represent computed or derived values (e.g., arithmetic results) because the data must exist physically on a page.

## M-Tuples

An **M-Tuple** (Memory Tuple) is fully materialized; the data is copied out of the buffer pool and stored as a new allocation on the heap.

![[Screenshots/M-Tuples.png]]

**Pros:**
- **Flexibility**: Can represent new or derived values (computed columns, aggregations).
- **Reduced Pinning**: Pages are only pinned briefly during the copy operation.

**Cons:**
- **Copy Overhead**: Data copying introduces CPU and memory bandwidth overhead, which scales with relation size.

## Iterator Interface

The execution engine typically follows the **Iterator Interface** (also known as the **Volcano Model** or **Pull Model**). Each operator exposes three standard methods:
- `open()`: Initializes operator state.
- `next()`: Returns the next tuple in the result stream.
- `close()`: Cleans up resources.

The root operator drives execution by calling `next()`, which propagates down the tree. This enables **Pipelining**, where operators run concurrently without needing to fully materialize intermediate results on disk.

---

## Industry Standard Terms
- **BP-Tuples** $\rightarrow$ Zero-copy Tuples / Pinned Tuples
- **M-Tuples** $\rightarrow$ Materialized Tuples / Heap-allocated Tuples
- **Iterator Interface** $\rightarrow$ Volcano Model / Pull Model
- **Access Path Selection** $\rightarrow$ Access Method Selection

## Related
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]]
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]]
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]]
- [[CSE332/ADT and Design/Iterators|CSE332 Iterators]]
