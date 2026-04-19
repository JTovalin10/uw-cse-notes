# CSE344: Isolation Levels

**Serializable** — even conflict-serializable — is expensive to implement. SQL allows more efficient transaction implementations that are not fully serializable: **weak isolation levels**.

![[Weaker Isolation Levels in SQL.png]]

## Isolation Levels

### Read Uncommitted

- **Writes**: strict 2PL write locks
- **Reads**: no locks needed
- Inconsistent reads are possible
- Extremely fast reads
- **Use cases:**
	- Static data — few or no writes after data is initialized
	- Applications or data where limited consistency is acceptable (e.g., application is down while data updates)
	- Read coverage/accuracy is not mission critical

### Read Committed

- **Writes**: strict 2PL write locks
- **Reads**: no locks needed, but a shared lock is acquired and immediately released per read
- Inconsistent reads are possible — a dirty/inconsistent read can happen if a read occurs after a write but before `ROLLBACK`/`COMMIT`
- Reads are fast and can happen as soon as write transactions are done
- **Use cases:**
	- Guarantees that a read result was valid at some point in time
	- Often useful for e-commerce situations

### Repeatable Read

- **Writes**: strict 2PL write locks
- **Reads**: strict 2PL read locks
- Unrepeatable reads are prevented
- Does not require overhead beyond standard element-based locking
- **Use cases:**
	- Application needs practically serializable behavior
	- Guarantees that a read result is valid throughout the entire session
- Note: Repeatable Read uses strict 2PL for both reads and writes — we are under a conflict-serializable guarantee
	- Why is this still only the second-highest isolation level?
		- **[[Phantom Reads|Phantom reads]] are still possible** — conflict-serializability assumes a static database; insertions and deletions break that assumption

### Serializable

- **Writes**: strict 2PL
- **Reads**: strict 2PL
- Plus table locks and/or predicate locks to prevent phantom reads
- High risk of contention
- **Use cases:**
	- Mission-critical applications where no mistakes are allowed
	- Performance is not a concern

### Note on Commercial DBMSes

In commercial DBMSes:
- The default isolation level is often **not** Serializable
- The default level differs by system — read the documentation
- "Serializable" in a specific DBMS may not be exactly ACID-serializable

## Summary

| Scenario | Implication |
|---|---|
| Static database | Conflict-serializability implies serializability |
| Dynamic database | Must deal with phantom reads separately — this is expensive |

## Related
- [[Phantom Reads]] — the concurrency problem that separates Repeatable Read from Serializable
- [[Other Lock Modes and Lock Granularity]] — predicate locks used at the Serializable level
- [[Atomic and Isolated Transactions in SQL]] — strict 2PL as the mechanism underlying most isolation levels
- [[Isolation Transactions in SQL]] — conflict-serializability and why it matters
- [[ACID Properties]] — weakening the I in ACID for performance
