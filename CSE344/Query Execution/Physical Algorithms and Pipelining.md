# CSE344: Physical Algorithms and Pipelining

**Physical Operators** are the concrete implementations of [[RA Operators|RA Operators]] that the DBMS actually executes.

## Physical Operator Classification

Physical operators come in two flavors:

- **Main Memory Operators**: Assume that the data fits entirely in main memory.
	- Best performance.
	- May be limited in how much data they can process.
- **External Memory Algorithms**: Assume the data is on disk.
	- Slower, but no limitation on data size.

## Key Topics

- [[Main Memory Join Algorithms|Main Memory Join Algorithms]] — nested loop, hash join, and merge join (in-memory)
- [[External Memory Algorithms|External Memory Algorithms]] — block nested loop, GRACE join, index-based join; costing with $B(R)$, $T(R)$, $V(R, \text{attr})$
- [[Pipelined Execution|Pipelined Execution]] — iterator interface, blocking vs. pipelined execution, I/O cost

## Related
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — the logical operators being physically implemented
- [[RA Operators|RA Operators]] — logical operator reference
- [[Cardinality Estimation|Cardinality Estimation]] — how the optimizer chooses between candidate physical plans
- [[CSE344/Query Execution/Parallel Query Execution|Parallel Query Execution]] — how these single-node operators compose across machines
- [[Parallel Join Algorithms|Parallel Join Algorithms]] — distributed join variants
- [[Disk Storage|Disk Storage]] — how data is laid out on disk, which drives the I/O costs
- [[Physical Design and Indices|Physical Design and Indices]] — physical storage decisions impacting operator costs
