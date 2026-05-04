assume schedule will be serializable, snort when conflicts detected, best for workloads with low levels of contention (timestamp, multi-version, validation)
## Isolation Levels in SQL
1. Dirty reads
	1. SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	2. long duration write locks
		1. strict 2PL
	3. no read locks
	4. read-only transactions are nevere delayed
		2
2. Committed reads
	1. SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	2. . long duration write locks
			1. struct 2pl
	3. short duration read locks
		1. only acquire locks while reading
	4. unrepeatable reads
		1. when reading same element twice, may get two different values
	5. possible problems: dirty and inconsistent reads
3. Repeatable reads
	1. SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	2. 5. long duration write locks
			1. strict 2PL
		6. long duration read locks
			1. strict 2pl
4. Serializable transactions
	1. SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	2. ACID
	3. ling duration write and read locks
		1. struct 2pl
	4. preducate locking to deal with phantoms
## Pessimistic vs Optimistic
- Pessimistic CC (locking)
	- prevent unserializable shcedules
	- never abort for serializability (but may abort for deadlocks)
	- best for workloads with high levels of contention
- Optimistic CC (timestamp, multi-version, validation)
	- assume schedule will be serializable
	- abort when conflicts detected
	- best for workloads with low levels of contention
## Concurrency control by timestamp
- each transaction recieves a unqiue timestamp
	- systems clock
		- need to change for distributed systems
	- unqiue counter, incremented by the scheduler
	- ![[Timestamp Multiple Transactions esaxmple.png]]
- main invariant:
	- the timestamp order defines the serialization order fo the transaction
		- will generate a schedule that is view-equiavlent to a serial schedule and recoverable
- main idea:
	- scheduler recieves a request
	- should t allow it to proceed, wait, or abort?
### Timestamps
with each element X, associate. If transactions abort, we must reset the timestamps
- RT(X) = the highest timestamp of any transaction I that reads X
- WT(X = the highest timestamp of any transaction I that wrote X
- C(X) = the commit bit: true when transaction with highest timestamp that wrote X committed