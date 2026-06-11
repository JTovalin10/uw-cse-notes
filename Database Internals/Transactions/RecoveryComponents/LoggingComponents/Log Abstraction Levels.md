# Database Internals: Log Abstraction Levels

The **abstraction level** of a log record determines what information is stored and how it is replayed during recovery. Choosing the right level is a trade-off between log size (storage/IO) and recovery speed (CPU/complexity).

## Comparison of Logging Levels

| Type | Description | Pros | Cons |
|------|-------------|------|------|
| **Physical Logging** | Records exact byte-level changes (e.g., "In page 50, change bytes 10–20 to `'ABC'`"). | Fast to replay; idempotent by nature. | Produces massive log files; sensitive to physical layout changes. |
| **Logical Logging** | Records high-level SQL-like operations (e.g., "Insert tuple `'John'` into Users"). | Very compact log records. | Hard to make idempotent (e.g., `x = x + 1`); extremely complex to replay correctly during recovery. |
| **Physiological Logging** | Records logical changes *within* a specific physical page (e.g., "In page 50, insert record `X`"). | Compact and efficient to replay; industry standard. | Requires more CPU than physical logging to interpret the intra-page logic. |

## Examples of Log Records
Consider the operation: **Insert "Bob" into the `Users` table**.

- **Physical Log Record**:
  - `[Page: 102, Offset: 512, Length: 8, Data: 0x426F620000000000]`
  - *Effect*: Directly overwrites the binary data at a specific memory address on the disk page.
- **Logical Log Record**:
  - `[INSERT INTO Users (Name) VALUES ('Bob')]`
  - *Effect*: Re-executes the SQL engine's insertion logic, including index updates and constraint checks.
- **Physiological Log Record**:
  - `[Page: 102, Op: InsertRecord, Slot: 5, Data: 'Bob']`
  - *Effect*: Navigates the internal structure of Page 102 (e.g., the slot array) to insert the record logically within that specific physical page.

## The Idempotency Problem

An operation is **Idempotent** if applying it multiple times has the same effect as applying it once ($f(x) = f(f(x))$). During recovery, a system may crash and restart multiple times, causing the same log records to be replayed.

### Physical Logging: Naturally Idempotent
Physical logging is idempotent because it uses "state" rather than "transition."
- **Operation**: `Set bytes 10-20 to 'ABC'`.
- If you perform this once, the bytes are `'ABC'`.
- If you perform it ten times, the bytes are still `'ABC'`.

### Logical Logging: The Non-Idempotent Trap
Logical logging often records transitions, which are dangerous to replay.
- **Scenario**: A transaction increments a counter: `UPDATE Counters SET val = val + 1 WHERE id = 1`.
- **Log Record**: `[T1, Increment val for ID 1]`
- **The Failure**:
  1. Recovery starts, reads the record, and increments `val` from 10 to 11.
  2. The system crashes before the next log record is processed.
  3. Recovery restarts, reads the same record again, and increments `val` from 11 to 12.
- **Outcome**: The database state is now incorrect ($12$ instead of $11$) because the operation was re-applied.

## Physiological Logging and PageLSN

Modern DBMSs like [[Database Internals/Transactions/RecoveryComponents/ARIES|ARIES]] use **Physiological Logging** combined with a **PageLSN** to achieve idempotency for non-idempotent logical operations.

### Mechanism Walkthrough: Ensuring Idempotency
Every data page on disk contains a **PageLSN** header, which stores the **Log Sequence Number (LSN)** of the latest update applied to that page.

1. **Analyze Log Record**: The recovery manager reads a log record: `[LSN: 500, Page: 10, Op: Add 10 to Balance]`.
2. **Fetch Page**: Page 10 is fetched from disk into the buffer pool.
3. **Compare LSNs**:
    - **Case A (`PageLSN < 500`)**: The change in the log record (LSN 500) has **not** been applied to this physical page yet (or was lost in a crash). The system applies the "Add 10" operation and updates the header to `PageLSN = 500`.
    - **Case B (`PageLSN >= 500`)**: The change was already written to disk before the crash. The system **skips** the operation.
4. **Result**: Even if the "Add 10" operation is replayed multiple times, the `PageLSN` check ensures it is only executed once against the actual data.

## Why Physiological?
1. **Concurrency**: It allows for page-level physical consistency while supporting high-level database operations.
2. **Idempotency**: It solves the transition problem via the `PageLSN` check.
3. **Efficiency**: It is much smaller than physical logging (does not log every byte) but much easier to implement than pure logical logging.
4. **Structural Flexibility**: Unlike pure physical logging, it can handle intra-page re-organizations (e.g., vacuuming or slot compaction) as long as the logical record insertion remains consistent within the page.

## Industry Standard Terms
- **Physical Logging** $\rightarrow$ Value Logging / State Logging
- **Logical Logging** $\rightarrow$ Operation Logging / Command Logging
- **Physiological Logging** $\rightarrow$ Page-Oriented Logical Logging
- **PageLSN** $\rightarrow$ Page Version / Timestamp

## Related
- [[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Undo-Redo Logging|Undo-Redo Logging]]
- [[Database Internals/Transactions/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
- [[Database Internals/Transactions/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]
