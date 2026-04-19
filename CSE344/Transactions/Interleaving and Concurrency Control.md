# CSE344: Interleaving and Concurrency Control

**Concurrency control** is the process of deciding how to interleave operations from multiple transactions.
- The **scheduler** (or **concurrency control manager**) is responsible for these decisions.

## Conflicts

**Conflicts** are the root cause of incorrect behavior in concurrent transactions:

- **Dirty/Inconsistent Read** — Write-Read (WR) conflict
	- An inconsistent read happens when data is read during an in-progress write
- **Unrepeatable Read** — Read-Write (RW) conflict
	- An unrepeatable read happens when data is read prior to a change
- **[[Phantom Reads|Phantom Read]]** — Read-Write (RW) conflict
	- A phantom read happens when data is read prior to an addition or deletion
- **Lost Update** — Write-Write (WW) conflict
	- Happens when one transaction's write is overwritten by another before it is observed

## Key Topics

- [[ACID Properties]] — the correctness properties transactions must satisfy (Atomic, Consistent, Isolated, Durable)
- [[Schedules and Serial Schedules]] — what it means for a schedule to be serializable
- [[Isolation Transactions in SQL]] — conflict-serializability and how to verify it
- [[Precedence Graphs]] — cycle detection to verify conflict-serializability
- [[Atomic Transactions in SQL]] — how locks enforce atomicity
- [[Atomic and Isolated Transactions in SQL]] — 2PL for achieving both atomicity and isolation
- [[Other Lock Modes and Lock Granularity]] — shared/exclusive locks and fine vs. coarse-grained locking
- [[Phantom Reads]] — a concurrency problem not solved by standard 2PL
- [[Isolation Levels]] — weaker isolation levels and their trade-offs

## Related
- [[CSE451/Processes/Synchronization/Locks/Locks|Locks (CSE451)]] — OS-level perspective on locking and synchronization
- [[CSE451/Processes/Synchronization/Race Conditions/Race Condition|Race Conditions]] — the OS-level analog of transaction conflicts
- [[CSE451/Processes/Synchronization/Synchronization|Synchronization]] — general concurrency control in OSes
