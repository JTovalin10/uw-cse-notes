# Transaction Schedules and Concurrency Problems

A **schedule** is a sequence of interleaved actions from multiple transactions.

- **Serial Schedule**: One transaction runs fully, then the next. No interleaving.
- **Serializable Schedule**: A schedule that is equivalent to a serial schedule.
    - The **scheduler** ensures that the interleaved execution remains serializable.
    - **Why interleave?** Sequential execution has poor throughput due to disk latency.

## Concurrent Execution Problems (Anomalies)

Interleaving transactions without proper control leads to three main types of conflicts:

1.  **Write-Read Conflict (Dirty Read)**:
    - $T_1$ writes a value, $T_2$ reads it before $T_1$ commits.
    - If $T_1$ later aborts, $T_2$ has read a "dirty" value that never logically existed.
2.  **Read-Write Conflict (Unrepeatable Read)**:
    - $T_1$ reads a value, $T_2$ modifies/writes it, and $T_1$ reads it again.
    - $T_1$ sees different values for the same object within the same transaction.
3.  **Write-Write Conflict (Lost Update)**:
    - $T_1$ and $T_2$ both update the same object. The second write overwrites the first, losing $T_1$'s update.

### Conflict Shorthand
- **WR**: Write-Read
- **RW**: Read-Write
- **WW**: Write-Write
