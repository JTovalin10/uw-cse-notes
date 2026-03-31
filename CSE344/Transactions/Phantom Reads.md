# Transactions: Phantom Reads

A **phantom read** occurs when a tuple is invisible during part of a transaction's execution but not invisible during the entire execution — i.e., a row appears or disappears mid-transaction due to an insertion or deletion by another transaction.

## Phantom Reads and Conflict-Serializability

Standard conflict-serializability assumes the database is **static** — the set of tuples does not change.
- If the database is **dynamic** (rows can be inserted or deleted), then conflict-serializability does **not** imply serializability
- This is the gap between [[Isolation Levels#Repeatable Read|Repeatable Read]] and [[Isolation Levels#Serializable|Serializable]] isolation

## Dealing with Phantoms

- **Lock the entire table**: prevents all insertions and deletions during the transaction — simple but low concurrency
- **Predicate locks** (also known as **range locks**): lock the portion of the table matching an arbitrary predicate
	1. Determine the query's predicate $P$
	2. Establish a lock on $P$
	3. Updates that affect $P$ are blocked until the lock is released

## Related
- [[Isolation Levels]] — how different isolation levels handle (or don't handle) phantom reads
- [[Other Lock Modes and Lock Granularity]] — predicate locks as a lock granularity strategy
- [[Interleaving and Concurrency Control#Conflicts]] — phantom reads as a RW conflict
