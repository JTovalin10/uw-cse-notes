# CSE444: Undo Logging

**Undo Logging** is a recovery strategy used when a system follows a **Steal** policy. It allows the DBMS to revert changes made by transactions that did not successfully commit, as those uncommitted changes may have already been written to disk.

## Mechanism

An Undo Log record stores the "before image" of the data.

- **Record Format**: `<T, X, v>` where `v` is the **old value** of element X before the modification.
- **Purpose**: Enables the system to restore data to a known-good point in time or to create consistent snapshots.

![[Screenshots/Undo Log Example.png]]

## Protocol Rules

Undo logging is governed by two strict rules that ensure atomicity and the correctness of the recovery process:

1. **U1 (WAL Rule)**: If transaction `T` modifies element `X`, then the log record `<T, X, v>` must be written to disk *before* the dirty page containing `X` is flushed to disk (`OUTPUT(X)`).
2. **U2 (Force-like Rule)**: If `T` commits, then **all** dirty pages modified by `T` (`OUTPUT(X)`) must be written to disk *before* the `<COMMIT T>` record is written to the log.

### Mechanism Walkthrough: Why U1 and U2?

These rules are strictly required because Undo Logging lacks "after images" (redo information).

- **Why U1 (WAL)?**: If the DBMS flushed a dirty page to disk *before* the corresponding log record was persisted, and a crash occurred immediately after, the disk would contain uncommitted data. Without the log record, the Recovery Manager would have no knowledge of the transaction's previous state and would be unable to "undo" the change, violating **Atomicity**.
- **Why U2 (Force)?**: Since the log only contains old values, it cannot be used to "redo" a transaction. Therefore, the system must ensure that every change made by a committed transaction is already safely on disk *before* the `<COMMIT T>` record is persisted. If we wrote `<COMMIT T>` without forcing the data, a crash would result in a "committed" transaction whose changes are lost, violating **Durability**.

## Recovery Process

After a system crash, the Recovery Manager determines the status of each transaction:

- **Complete**: The log contains `<START T>` followed by either `<COMMIT T>` or `<ABORT T>`.
- **Incomplete**: The log contains `<START T>` with no subsequent completion record.

### Undo Algorithm

The recovery manager scans the log **backwards** (from the end to the most recent checkpoint).

### Formal Definition
$S_{loser} = \{ T \mid \langle \text{START } T \rangle \in \text{Log} \land \langle \text{COMMIT } T \rangle \notin \text{Log} \land \langle \text{ABORT } T \rangle \notin \text{Log} \}$
For each record $\langle T, X, v \rangle$ in Log (scanned backwards):
If $T \in S_{loser}$, then $\text{OUTPUT}(X, v)$.

### Simplified Explanation
Find everyone who didn't finish. Walk backwards through the log and put the old values back for those "losers" so it's like their changes never happened.

![[Screenshots/Recovery With Undo Log.png]]

## Recovery Walkthrough

Consider the following log sequence and disk state at the time of a crash. Assume elements $A, B, C, D$ initially have values $10, 20, 30, 40$.

**Log at Crash:**
1. `<START T1>`
2. `<T1, A, 10>`
3. `<START T2>`
4. `<T2, B, 20>`
5. `<T1, C, 30>`
6. `<COMMIT T1>`  *(Note: By U2, A and C are guaranteed to be 11 and 31 on disk now)*
7. `<T2, D, 40>`
8. `--- CRASH ---`

### Step-by-Step Recovery

1.  **Identify Losers**: Scanning the log, we see `<COMMIT T1>`, so $T1$ is committed. We see `<START T2>` but no `<COMMIT T2>`, so $T2$ is a **loser**.
2.  **Backward Scan**:
    -   **Record 7**: `<T2, D, 40>`. $T2$ is a loser. **Action**: Write $D = 40$ to disk.
    -   **Record 6**: `<COMMIT T1>`. $T1$ is committed. **Action**: None (Mark $T1$ as "done" for this scan).
    -   **Record 5**: `<T1, C, 30>`. $T1$ is committed. **Action**: Skip.
    -   **Record 4**: `<T2, B, 20>`. $T2$ is a loser. **Action**: Write $B = 20$ to disk.
    -   **Record 3**: `<START T2>`. **Action**: None.
    -   **Record 2**: `<T1, A, 10>`. $T1$ is committed. **Action**: Skip.
    -   **Record 1**: `<START T1>`. **Action**: None.

**Final Disk State**: $A=11, B=20, C=31, D=40$. Note that $T1$'s changes persisted while $T2$'s uncommitted changes to $B$ and $D$ were reverted.

## Undo Algorithm Implementation (Java)

Below is a Java implementation of the Undo recovery logic, typically found in a Buffer Manager or Recovery Manager.

```java
public class UndoRecoveryManager {
    /**
     * Performs undo recovery by scanning the log backwards.
     * @param logRecords List of log entries, where the last element is the newest.
     */
    public void performUndoRecovery(List<LogRecord> logRecords) {
        Set<Integer> committedTransactions = new HashSet<>();
        Set<Integer> activeLosers = new HashSet<>();

        // Traverse log in reverse (from most recent to oldest)
        ListIterator<LogRecord> it = logRecords.listIterator(logRecords.size());
        while (it.hasPrevious()) {
            LogRecord record = it.previous();

            switch (record.getType()) {
                case COMMIT:
                case ABORT:
                    committedTransactions.add(record.getTransactionId());
                    break;

                case UPDATE:
                    if (!committedTransactions.contains(record.getTransactionId())) {
                        // Transaction is a loser; restore the "before image" (old value)
                        active_losers.add(record.getTransactionId());
                        diskManager.write(record.getElementId(), record.getOldValue());
                    }
                    break;

                case START:
                    if (activeLosers.contains(record.getTransactionId())) {
                        // Transaction fully undone; in a real system, log a CLR or END record here
                        activeLosers.remove(record.getTransactionId());
                    }
                    break;
            }
        }
        
        // Finalize by flushing disk and persisting state
        diskManager.flush();
    }
}
```

### Key Properties

- **Scope**: Only updates from incomplete (uncommitted) transactions are undone.
- **Traveral**: Requires scanning backwards to ensure the most recent "old value" is applied first if multiple transactions touched the same element.
- **Idempotency**: Log records are idempotent; if the system crashes during recovery, re-running the algorithm from the same point results in the same correct state.

## Trade-offs

| Pros | Cons |
|------|------|
| Simple recovery logic. | **High Commit Latency**: Forces all data to disk at commit time (Rule U2). |
| Supports Steal policy (memory efficiency). | **I/O Bottleneck**: Can result in many small, random disk writes during commit. |

## Industry Standard Mapping
- **Undo Logging** $\rightarrow$ Transaction Rollback / Undo Segments (e.g., Oracle Undo tablespace, InnoDB Undo Logs).

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Redo Logging|Redo Logging]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo-Redo Logging|Undo-Redo Logging]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
