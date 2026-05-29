# CSE444: Recovery

**[[Database Recovery]]** is the process of ensuring that a database remains in a consistent state despite system crashes, power failures, or transaction aborts. It is the primary mechanism for enforcing **Atomicity** and **Durability** from the [[CSE444/Transactions/Transaction Fundamentals|ACID properties]].

When a system crash occurs, the volatile state in RAM is lost. The DBMS must use the log on stable storage to reconstruct the state. The recovery process must be **idempotent** — if the system crashes again during recovery, re-starting the process must lead to the same consistent state.

## Core Pillars of Recovery

The recovery system rests on three foundational pillars:

### 1. Write-Ahead Logging (WAL)
The **[[CSE444/Transactions/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]** protocol ensures that the log always precedes the data page on stable storage. 
- **Rule 1**: All log records for a page must be flushed to disk before the page itself is written.
- **Rule 2**: The `COMMIT` record must be flushed to disk before the transaction is declared committed.

This allows the DBMS to use the log to reconstruct the state of the data if it was lost during a crash.

### 2. Buffer Management Policies
The interaction between the **[[CSE444/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]]** and the recovery system is defined by two dimensions:

- **Steal vs. No-Steal**:
  - **Steal**: Allows the buffer manager to flush a dirty page to disk even if the transaction that modified it hasn't committed. (Requires **Undo** logging to roll back those changes if the transaction aborts).
  - **No-Steal**: Pages cannot be flushed until the transaction commits.
- **Force vs. No-Force**:
  - **Force**: Requires all pages modified by a transaction to be flushed to disk at commit time.
  - **No-Force**: Allows a transaction to commit even if its modified pages are still only in RAM. (Requires **Redo** logging to re-apply changes if the system crashes before the page hits disk).

| Policy Combination | Logging Required |
|-------------------|-----------------|
| No-Steal / Force | No logging needed (simple but impractical) |
| Steal / Force | Undo logging only |
| No-Steal / No-Force | Redo logging only |
| **Steal / No-Force** | **Undo-Redo logging** (Industry Standard) |

### 3. Logging Types
Log records can be represented at different levels of abstraction:
- **Physical Logging**: Records exact byte-level changes (e.g., "Page 5, Offset 100 changed from 'A' to 'B'").
- **Logical Logging**: Records the high-level operation (e.g., "Insert tuple X into Table Y").
- **Physiological Logging**: A hybrid approach. Records changes within a specific page, but uses logical descriptions for the internal page structure (e.g., "Page 5, Insert tuple X into slot 2"). This is the standard in modern DBMSs.

## The ARIES Algorithm

Modern recovery is typically implemented using the **[[CSE444/Transactions/RecoveryComponents/ARIES|ARIES]]** (Algorithms for Recovery and Isolation Exploiting Semantics) algorithm. It is a **Steal/No-Force** protocol that operates in three phases:

1. **Analysis**: Scan the log forward from the last checkpoint to identify "dirty" pages and active transactions at the time of the crash.
2. **Redo**: Replay all logged operations (including those from uncommitted transactions) to restore the database to its exact state at the moment of failure.
3. **Undo**: Scan the log backward to roll back the changes of transactions that never committed ("losers").

---

## Industry Standard Terms
- **Recovery** $\rightarrow$ Crash Recovery / Restart Recovery
- **Idempotency** $\rightarrow$ Restart-safety
- **WAL** $\rightarrow$ Write-Ahead Log / Transaction Log
- **Steal** $\rightarrow$ Page stealing
- **Force** $\rightarrow$ Immediate write-on-commit

## Related
- [[CSE444/Transactions/RecoveryComponents/ARIES|ARIES Detail]]
- [[CSE444/Transactions/RecoveryComponents/Write-Ahead Logging (WAL)|WAL Details]]
- [[CSE444/Transactions/Transaction Fundamentals|Transaction Fundamentals]]
- [[CSE444/Transactions/Concurrency Anomalies|Concurrency Anomalies]]
- [[CSE444/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]]
