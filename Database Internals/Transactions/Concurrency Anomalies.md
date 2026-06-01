# CSE444: Concurrency Anomalies

Interleaving transactions without proper control (i.e., not enforcing a [[CSE444/Transactions/Serializability/Schedules|serializable schedule]]) leads to data corruption. The three main conflict types are:

1. **Write-Read Conflict ([[Dirty Read|Dirty Read]])** — $T_1$ writes a value, $T_2$ reads it before $T_1$ commits. If $T_1$ aborts, $T_2$ has read a value that never logically existed.
2. **Read-Write Conflict ([[Unrepeatable Read|Unrepeatable Read]])** — $T_1$ reads a value, $T_2$ writes it, then $T_1$ reads it again and sees a different value within the same transaction.
3. **Write-Write Conflict ([[Lost Update|Lost Update]])** — $T_1$ and $T_2$ both update the same object. The second write overwrites the first, losing $T_1$'s update.

## Related
- [[Database Internals/Transactions/Isolation Levels|Isolation Levels]]
- [[CSE444/Transactions/Serializability/Schedules|Schedules]]
- [[Transaction Fundamentals|Transaction Fundamentals]]
