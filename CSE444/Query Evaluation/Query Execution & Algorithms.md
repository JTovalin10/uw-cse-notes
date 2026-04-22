# CSE444: Query Execution

## Query Processor Overview

The **query processor** is responsible for two major phases:

- **Query optimization**: find a good execution plan
- **Query execution**: execute the chosen plan

An SQL query is transformed into a physical plan. Each operator in the plan is given a limited amount of memory to work with. The key decisions made during this transformation are:

- **Access path selection** for each relation (e.g., sequential scan vs. index scan)
- **Implementation choice** for each operator (e.g., hash join vs. nested loop join)
- **Scheduling decisions** for operators:
  - Single-threaded or parallel
  - Pipelined or materialized

## Memory Management

Each operator in the plan manages its own memory in two ways:

1. **Pre-allocating heap space for input/output tuples** — there are two strategies for how tuples are represented:
   - **BP-tuples**: pointers to data in the buffer pool
   - **M-tuples**: new tuples allocated on the heap
2. **Allocating memory for its internal state** — stored on the heap

The DBMS enforces limits on how much memory each operator or each query can consume. This constraint shapes which tuple representation strategy makes sense.

## BP-Tuples

A **BP-tuple** (buffer pool tuple) is a tuple descriptor that holds a pointer directly into a page in the buffer pool, rather than copying the data.

When an operator constructs a BP-tuple, it references a tuple in the buffer pool and must **increment the pin count** of that page. The pin count is decremented when the descriptor is cleared, ensuring the page is not evicted while it is in use.

![[CSE444/Screenshots/BP-Tuples.png]]

**Pros:**
- No data copying — excellent performance since data is read in-place from the buffer pool

**Cons:**
- Pages must be pinned in the buffer pool, which can exhaust the pool under high operator concurrency
- Cannot represent computed or derived values (e.g., the result of an arithmetic expression), since the data must exist as-is on a buffer pool page

## M-Tuples

An **M-tuple** (memory tuple) is a tuple that is fully materialized — the actual data is copied out of the buffer pool and stored as a new allocation on the heap.

![[CSE444/Screenshots/M-Tuples.png]]

**Pros:**
- No need to hold pages pinned in the buffer pool (only briefly pinned during the copy)
- Can represent new or derived values (e.g., computed columns, aggregation results)

**Cons:**
- Data copying introduces overhead that can degrade performance, especially for large relations

## Iterator Interface

The query execution engine is typically built around an **iterator interface** (also called the Volcano model or pull model). Each operator exposes `open()`, `next()`, and `close()` methods. The root operator drives execution by repeatedly calling `next()`, which propagates down the tree — each operator pulls tuples from its children on demand. This enables pipelined execution where operators run concurrently without fully materializing intermediate results.

---

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]]
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]]
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]]
