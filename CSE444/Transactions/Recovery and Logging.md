# Course: Recovery and Logging

Database recovery systems ensure that the **Atomicity** and **Durability** (from ACID) of transactions are maintained even in the event of a system crash or power failure.

## Write-Ahead Logging (WAL)

The **Write-Ahead Logging (WAL)** rule is the fundamental principle of database durability.

### Formal Definition
1. All log records for a page must be written to non-volatile storage before the data page itself is allowed to be written to disk.
2. A transaction is not considered committed until all its log records have been successfully flushed to stable storage.

### Simplified Explanation
Write down what you are going to do before you do it, so if you crash mid-way, you can remember where you left off.

## Buffer Management Policies

The interaction between the buffer pool and the recovery manager is defined by two policy dimensions:

| Policy | Description | Recovery Requirement |
|--------|-------------|----------------------|
| **Steal** | Allows the buffer manager to flush dirty pages of an uncommitted transaction to disk. | Requires **Undo** logging to roll back partial changes. |
| **No-Steal**| Dirty pages of uncommitted transactions cannot be flushed. | Simplifies recovery but limits transaction size to RAM. |
| **Force** | Requires all pages modified by a transaction to be flushed to disk at commit time. | Ensures durability but creates massive random I/O overhead. |
| **No-Force**| Pages are not required to be flushed at commit; they can stay in the buffer pool. | Requires **Redo** logging to replay changes if a crash occurs. |

**Standard Implementation**: Most modern high-performance databases use a **Steal / No-Force** policy.

## ARIES Recovery Algorithm

**Algorithms for Recovery and Isolation Exploiting Semantics (ARIES)** is the industry-standard recovery algorithm.

### Log Sequence Number (LSN)
Every log record is assigned a monotonically increasing **Log Sequence Number (LSN)**. Each data page stores the LSN of the last update that modified it (**pageLSN**).
- **Rule**: A page can only be flushed to disk if the log up to its **pageLSN** has been flushed to disk.

### The Three Phases of ARIES

1. **Analysis Phase**
   - Scans the log forward from the last **Checkpoint**.
   - Identifies "Dirty" pages in the buffer pool at the time of the crash.
   - Identifies "Active" (uncommitted) transactions.

2. **Redo Phase**
   - Replays all log records starting from the oldest dirty page.
   - Restores the database to the exact state it was in at the moment of the crash (Repeating History).

3. **Undo Phase**
   - Scans the log backward.
   - Rolls back all "loser" transactions (those that were active at the time of the crash).
   - Writes **Compensation Log Records (CLR)** during the rollback to ensure the undo itself is idempotent.

## Idempotence and Logging Types

- **Idempotent Recovery**: The property that executing the recovery process multiple times (due to crashes during recovery) results in the same final state.
- **Physical Logging**: Records the exact byte-level changes to a page (e.g., "Change bytes 10-20 to 'X'").
- **Logical Logging**: Records the high-level operation (e.g., "Insert tuple into Table A").
- **Physiological Logging**: A hybrid approach recording logical changes within a specific physical page. This is the most common form in modern DBMS.

## Related
- [[CSE444/Transactions/Transaction Fundamentals|Transaction Fundamentals]]
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture]]
