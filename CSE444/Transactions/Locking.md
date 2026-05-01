# CSE444: Locking and Schedulers

The **scheduler** is the module that orders transaction actions to ensure serializability.

## Pessimistic Scheduler
Coarse-grained approach — always correct but slower. Each element has a unique lock, and each transaction must acquire the lock before reading or writing that element. If a lock is held by another transaction, the requesting transaction waits (placed in a queue for that lock).

#### Notation
- $L_i(A)$ = transaction $T_i$ acquires lock for element $A$
- $U_i(A)$ = transaction $T_i$ releases lock for element $A$

![[Pessimistic Scheduler creates conflict-serializable.png]]

### Two-Phase Locking (2PL)
In every transaction, all lock requests must precede all unlock requests. This ensures **conflict serializability**.

- **Growing phase**: acquire locks
- **Shrinking phase**: release locks (no new locks after first release)

#### Without 2PL
![[Without 2Pl.png]]

#### With 2PL
![[With 2PL.png]]

#### Problem: Non-Recoverable Schedules
If a transaction aborts after another has already read its uncommitted writes, the changes that should never have existed have already been seen — recovery becomes impossible.

![[Non-recoverable schedule.png]]

### Strict 2PL
All locks held by a transaction are released only at **COMMIT** or **ROLLBACK** — not during execution.

![[Strict 2PL example.png]]

This guarantees:
- **Serializability**
- **Recoverability**
- **No cascading aborts**

## Optimistic Scheduler
Assumes conflicts are rare. Transactions execute without locking, then validate at commit time. If a conflict is detected, one transaction is rolled back.

## Lab 3 Notes
- Transactions (not threads) must hold locks — many threads can execute different pieces of the same transaction
- Must detect deadlocks (cycles in the waits-for graph) and resolve them by aborting a transaction
- Lock pages, not rows

## Related
- [[Conflict Serializability]]
- [[Schedules and Concurrency Problems]]
- [[Transaction Fundamentals]]
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks/Locks|Locks (CSE451)]]
