# CSE444: Transaction Fundamentals

A **Transaction** is a sequence of database operations that executes as a single logical unit with the **All-or-Nothing** property: either all operations complete successfully, or none do.

```sql
START_TXN; -- Starts the transaction (may be implicit)
[...]
COMMIT;    -- Make all changes permanent
-- or
ROLLBACK;  -- Undo all changes (= ABORT)
```

- **`COMMIT`**: Finalizes the transaction, making all changes permanent and visible to others.
- **`ROLLBACK`** (or **ABORT**): Reverts the database to its state before the transaction began. This occurs during user-driven cancels, application errors, or system-level recovery.

## ACID Properties

To ensure data integrity, a DBMS must provide the **ACID** properties:

- **Atomicity**: Either all changes performed by a transaction occur, or none occur (**All-or-Nothing**).
- **Consistency**: A transaction as a whole does not violate database integrity constraints (schema rules, keys, etc.).
- **Isolation**: Transactions appear to execute as if they were in a serial sequence, even when running concurrently.
- **Durability**: Once a transaction commits, its changes survive system failures (persisted to stable storage).

### Technical Challenges
- **Concurrency**: Multiple transactions accessing the same data lead to **Isolation** violations.
- **Failures**: System crashes can happen at any time, threatening **Atomicity** and **Durability**.
- **Rollbacks**: The system must be able to undo changes from partially completed transactions.

## Pessimistic vs. Optimistic Concurrency Control

Databases adopt one of two primary philosophies to manage concurrency:

- **Pessimistic Concurrency Control (Locking)**:
  - Prevents unserializable schedules *before* they occur.
  - Transactions wait for **[[CSE444/Transactions/Pessimistic Components/Lock Modes|Locks]]** before proceeding.
  - Best for workloads with **High Contention** (many writers on the same data).
- **Optimistic Concurrency Control (Timestamp, Validation)**:
  - Assumes schedules will likely be serializable.
  - Conflicts are detected at **Commit Time**, resulting in an abort if a violation occurred.
  - Best for workloads with **Low Contention** (mostly reads or non-overlapping writes).

## Buffer Management & Recovery Policies

The interaction between the **[[CSE444/DBMS Architecture and Deployments/Subsystems/Buffer Manager|Buffer Pool]]** and the **Recovery Manager** determines the implementation of Atomicity and Durability.

- **Steal vs. No-Steal**:
  - **Steal**: An uncommitted transaction can "steal" a slot in the buffer pool and overwrite the most recent committed value on disk. Requires an **Undo Log** to revert the change if the transaction aborts.
  - **No-Steal**: Changes are kept in memory until the transaction commits, ensuring disk values are always committed.
- **Force vs. No-Force**:
  - **Force**: All updates must be flushed to disk *before* the transaction is allowed to commit.
  - **No-Force**: A transaction can commit before all its modified pages are on disk. Requires a **Redo Log** to re-apply changes after a crash.

| Policy Combination      | Required Logging     | Performance / Trade-offs                  |
|:------------------------|:---------------------|:------------------------------------------|
| **Force / No-Steal**    | None                 | Poor performance; very simple recovery.   |
| **Force / Steal**       | **Undo Log**         | Efficient memory use; slow commit phase.  |
| **No-Force / No-Steal** | **Redo Log**         | Fast commit; limited transaction size.    |
| **No-Force / Steal**    | **Undo-Redo Log**    | **Highest Performance** (e.g., ARIES).    |

---

## Industry Standard Terms
- **Steal** $\rightarrow$ Undo-required Buffer Management
- **Force** $\rightarrow$ Synchronous Commit / Eager Write
- **Isolation** $\rightarrow$ Concurrency Control
- **Rollback** $\rightarrow$ Abort / Revert

## Related
- [[CSE444/Transactions/Recovery/Recovery|Recovery and Logging]] — ARIES and WAL details
- [[CSE444/Transactions/Concurrency Anomalies|Concurrency Anomalies]] — WR, RW, and WW conflicts
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|Locking]] — 2PL and lock table
- [[CSE444/Transactions/Isolation Levels|Isolation Levels]] — SQL Standard levels
- [[CSE444/Transactions/Optimistic Components/Timestamps|Timestamps]] — T/O concurrency control
- [[CSE452/Consistency/Strong Consistency|CSE452 Strong Consistency]]
