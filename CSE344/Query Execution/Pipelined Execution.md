# CSE344: Pipelined Execution

## Single Pass vs. Multi-Pass

Ideally, the database reads data from disk only once per table (**single pass**). Due to memory constraints, it often has to evict data already in memory to hold the next batch, forcing multiple reads from disk (**multi-pass**).

## Blocking vs. Pipelined Execution

When executing a query plan with multiple joins:

- **Blocking execution**: subplans are completed and their results fully stored before the parent operation can start
	- Simple to implement
	- Higher memory usage — intermediate results must be materialized

- **Pipelined execution**: tuples are processed through the entire query plan as they become "ready" for the next operation
	- Lower latency — results start appearing without waiting for all input
	- Lower memory — no need to materialize entire intermediate results

## Pipelined Execution: Iterator Interface

RA operators expose an **iterator interface**:
- `open()`: initialize the operator at the start of the query
- `close()`: clean up the operator at the end
- `next()`: get the next output tuple from a child operator or input table

Each operator calls `next()` on its child to pull tuples through the tree one at a time.

![[Pipelined Execution Example.png]]

## I/O Cost for Pipelined Execution

I/O cost may be lower with pipelined execution:
- No need to read the entirety of a previous stage off disk
- Generated tuples remain in main memory, so future access is "free"
- Baseline assumption: no indexes + block-at-a-time NLJ

## Related
- [[CSE344/Query Execution/External Memory Algorithms|External Memory Algorithms]] — the algorithms that execute within a pipeline stage
- [[CSE344/Query Execution/Main Memory Join Algorithms|Main Memory Join Algorithms]] — in-memory operators pipelined via the iterator interface
- [[CSE344/Query Execution/Physical Algorithms and Pipelining|Physical Algorithms and Pipelining]] — overview of physical operator types
- [[CSE344/Query Execution/Parallel Query Execution|Parallel Query Execution]] — pipelining interacts with the shared-nothing shuffle model
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — the logical operators implemented by the pipeline
- [[CSE344/Query Execution/Cardinality Estimation|Cardinality Estimation]] — memory availability affects whether a pipeline is single- or multi-pass
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — the disk I/O that pipelining tries to minimize
