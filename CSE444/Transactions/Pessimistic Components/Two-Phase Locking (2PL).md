# CSE444: Two-Phase Locking (2PL)

Simply using locks is not enough to guarantee that a schedule is serializable. A transaction could lock A, update it, unlock A, and then later decide to lock B based on what it saw in A, allowing another transaction to slip in and mess up the logic.

To guarantee **[[CSE444/Transactions/Serializability/Conflict Serializability|Conflict Serializability]]**, the [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|scheduler]] enforces a rule called **Two-Phase Locking**.

## The Basic 2PL Rule
In every transaction, **all lock requests must precede all unlock requests.**

A transaction executing under 2PL has two distinct phases:
1.  **Growing phase**: The transaction can acquire locks but cannot release any.
2.  **Shrinking phase**: The transaction can release locks, but once it releases its first lock, it **cannot acquire any new locks**.

#### Without 2PL
![[Without 2Pl.png]]

#### With 2PL
![[With 2PL.png]]

---

## The Problem: Cascading Aborts
Basic 2PL guarantees serializability, but it does not guarantee that the schedule is **[[CSE444/Definitions/Recoverable Schedule|Recoverable]]**.

**The Danger**: 
During the shrinking phase, a transaction might release a lock on $X$ *before* it has actually committed. If another transaction swoops in, acquires the lock on $X$, reads the uncommitted value, and commits, we have a problem. If the first transaction then aborts, the second transaction has committed based on "dirty data" that logically never existed. This requires a **[[CSE444/Definitions/Cascading Abort|cascading abort]]** to fix, which is terrible for performance (and impossible if the second transaction already committed).

![[Non-recoverable schedule.png]]

---

## Strict 2PL (S2PL)
To solve the cascading abort problem, almost all modern databases use a stricter version of the rule.

**The Strict Rule**: All locks (or at least all Exclusive/Write locks) held by a transaction are released **only at the very end**, during **COMMIT** or **ROLLBACK**. There is no "shrinking phase" during normal execution.

![[Strict 2PL example.png]]

### Guarantees of Strict 2PL
By holding locks until the end, Strict 2PL guarantees:
1.  **Serializability**: (Because it still follows the basic 2PL rule).
2.  **Recoverability**: No one can read your uncommitted data because you don't release the lock until you commit.
3.  **No Cascading Aborts**: Because you only read committed data, if someone aborts, it doesn't affect you.

## Related
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|Pessimistic Scheduler]]
- [[CSE444/Transactions/Pessimistic Components/Lock Modes|Lock Modes]]
- [[CSE444/Transactions/Concurrency Anomalies|Schedules and Concurrency Problems]]
