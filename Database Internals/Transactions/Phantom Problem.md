# Database Internals: The Phantom Problem

If tuples are inserted or deleted during a transaction, the **Phantom Problem** appears.

![[Phantom Problem.png]]

A **phantom** is a tuple that is invisible during part of a transaction execution but not invisible during the entire execution. Unlike ordinary [[Database Internals/Transactions/Concurrency Anomalies|concurrency anomalies]] that involve conflicts on a specific existing tuple, phantoms arise because no lock exists for rows that have not yet been inserted — locking only existing tuples leaves gaps.

**Example**:
1. $T_1$ reads a list of products with predicate `color = 'blue'`.
2. $T_2$ inserts a new blue product and commits.
3. $T_1$ re-reads the same predicate: a new "phantom" product appears that was not present in the first read.

The critical difference from an **[[Database Internals/Definitions/Unrepeatable Read|unrepeatable read]]** is that phantoms involve a *set* of tuples rather than a single existing row. $T_1$ holds shared locks on each row it read initially, but those locks do not prevent $T_2$ from inserting an entirely new matching row.

## Dealing with Phantoms

Dealing with phantoms is generally expensive and requires locking more than just existing individual tuples:

- **Table Locks**: Lock the entire table (coarse-grained). Prevents any concurrent inserts or deletes but eliminates most concurrency.
- **Index Locking**: Lock the index entry (e.g., for `color = 'blue'`) if an index is **available**. More targeted than a full table lock but requires an index on the predicate column.
- **Predicate Locks**: A lock on an arbitrary predicate, covering all current and future tuples that match the condition. Very precise but very expensive to check — every new lock acquisition must be tested against all outstanding predicate locks.

The [[Database Internals/Transactions/Isolation Levels|Serializable isolation level]] addresses phantoms by using predicate or index locking, which is why it is the only SQL level that fully prevents this anomaly.

## Industry Standard Terms
- **Phantom Problem** $\rightarrow$ Phantom Read (ANSI SQL terminology)
- **Predicate Lock** $\rightarrow$ Range Lock / Gap Lock (MySQL InnoDB terminology)
- **Index Locking** $\rightarrow$ Next-Key Locking (in systems like InnoDB)

## Related
- [[Database Internals/Transactions/PessimisticComponents/Pessimistic Scheduler|Locking]]
- [[Database Internals/Transactions/PessimisticComponents/Lock Modes|Lock Modes]]
- [[Database Internals/Transactions/Isolation Levels|Isolation Levels]]
