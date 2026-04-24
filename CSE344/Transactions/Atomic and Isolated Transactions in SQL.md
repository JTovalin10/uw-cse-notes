# Transactions: Two-Phase Locking (2PL)

## Generating Conflict-Serializable Schedules

To make transactions safe:
- Add locks to enforce ordering
- Verify isolation using the precedence graph

The question is: how do we do both automatically?

## Two-Phase Locking Protocol

**2-Phase Locking (2PL):** in every transaction, all lock requests must precede all unlock requests.

![[2PL in action.png]]

## Recoverability and Strict 2PL

### A Problem with Rollbacks

![[A Problem with Rollbacks.png]]

Vanilla 2PL does not guarantee **recoverability** — the ability to restore the database to a consistent state after a rollback.

### 2PL Problems

- **Recoverability**: vanilla 2PL doesn't guarantee the database can be rolled back to a consistent state
- **Deadlocks**: a by-product of managing groups of locks
	- Transactions can't make any progress due to a cycle in the order of lock acquisitions

### Strict Two-Phase Locking

**Strict 2PL** adds one additional constraint on top of 2PL:
- In every transaction, all lock requests must precede all unlock requests
- All unlock requests must happen immediately after `COMMIT` or `ROLLBACK`

![[Strict Two-Phase Locking.png]]

Schedules under Strict 2PL are:
- Conflict-serializable
- Recoverable
- Can still deadlock

**Implementation of Strict 2PL:**
- When a transaction requests to `READ` or `WRITE` some element $A$, the scheduler adds a `LOCK` command
- When the transaction commits or aborts, the scheduler inserts all `UNLOCK` commands

## Related
- [[Atomic Transactions in SQL]] — basic locking and atomicity
- [[Other Lock Modes and Lock Granularity]] — shared/exclusive locks, fine vs. coarse-grained locking
- [[Isolation Transactions in SQL]] — conflict-serializability and precedence graphs
- [[Phantom Reads]] — a concurrency problem not solved by standard 2PL
- CSE451/Synchronization/Deadlock — OS-level deadlock detection and prevention
