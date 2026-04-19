# CSE344: Physical Algorithms and Pipelining

**Physical operators** are the concrete implementations of [[RA Operators|RA operators]] that the DBMS actually executes.

## Physical Operator Classification

Physical operators come in two flavors:

- **Main memory operators**: assume that the data fits entirely in main memory
	- Best performance
	- May be limited in how much data they can process
- **External memory algorithms**: assume the data is on disk
	- Slower, but no limitation on data size

## Key Topics

- [[Main Memory Join Algorithms]] — nested loop, hash join, and merge join (in-memory)
- [[External Memory Algorithms]] — block nested loop, GRACE join, index-based join; costing with $B(R)$, $T(R)$, $V(R, \text{attr})$
- [[Pipelined Execution]] — iterator interface, blocking vs. pipelined execution, I/O cost

## Related
- [[Relational Algebra]] — the logical operators being physically implemented
- [[RA Operators]] — logical operator reference
- [[Cardinality Estimation]] — how the optimizer chooses between candidate physical plans
- [[Parallel Query Execution]] — how these single-node operators compose across machines
- [[Parallel Join Algorithms]] — distributed join variants
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — how data is laid out on disk, which drives the I/O costs
- [[CSE344/Database Design/Physical Design and Indices|Physical Design and Indices]] — physical storage decisions impacting operator costs
