# CSE444: Transaction Schedules and Concurrency Problems

A **schedule** is a sequence of interleaved actions from multiple transactions.

- **Serial Schedule**: One transaction runs fully, then the next. No interleaving.
- **Serializable Schedule**: A schedule equivalent to some serial schedule.
    - The **scheduler** ensures that interleaved execution remains serializable.
    - **Why interleave?** Sequential execution has poor throughput due to disk latency.

## Concurrent Execution Problems (Anomalies)

Interleaving transactions without proper control leads to three main conflict types:

1. **Write-Read Conflict (Dirty Read)** — $T_1$ writes a value, $T_2$ reads it before $T_1$ commits. If $T_1$ aborts, $T_2$ has read a value that never logically existed.
2. **Read-Write Conflict (Unrepeatable Read)** — $T_1$ reads a value, $T_2$ writes it, then $T_1$ reads it again and sees a different value within the same transaction.
3. **Write-Write Conflict (Lost Update)** — $T_1$ and $T_2$ both update the same object. The second write overwrites the first, losing $T_1$'s update.

## Related
- [[Conflict Serializability]]
- [[Locking]]
- [[Transaction Fundamentals]]
