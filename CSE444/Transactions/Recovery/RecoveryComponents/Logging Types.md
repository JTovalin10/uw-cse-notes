# CSE444: Logging Types

Databases use different logging strategies depending on the [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|buffer management policies]] in effect and the performance requirements of the system. The specific log type required is dictated by the Steal/No-Steal and Force/No-Force policy combination.

## Log Record Structure

A full log record contains all information needed to both undo and redo a change:

`<T, X, old_v, new_v>`

- `T`: Unique Transaction ID.
- `X`: The element (page or record) being modified.
- `old_v`: The value *before* the update (used for **Undo**).
- `new_v`: The value *after* the update (used for **Redo**).

Each log record is assigned a **Log Sequence Number (LSN)**. Records belonging to the same transaction are linked via LSN pointers, enabling efficient backward traversal during recovery and rollback.

## Specific Log Types

### Undo Log

An **Undo Log** is used when a system follows a **Steal** policy. It allows the DBMS to revert changes made by transactions that did not successfully commit, since those uncommitted changes may have already been written to disk.

- **Record Format**: `<T, X, v>` where `v` is the **old value** of element X before the modification.
- **Snapshots**: Undo logs can be used to create snapshots of the database state, allowing the system to restore data to a known-good point in time.

![[Undo Log Example.png]]

#### Protocol

1. `<START T>` is written when the transaction begins.
2. Before any data element `X` is modified on disk, `<T, X, old_v>` must be flushed to the log (**Rule U1**).
3. `<COMMIT T>` is only written *after* **all** changes by `T` have been flushed to disk (**Rule U2** — this enforces a Force-like guarantee at the per-record level).

#### Undo-Logging Rules

- **U1**: If transaction `T` modifies element `X`, then `<T, X, v>` must be written to disk *before* `OUTPUT(X)` (before the dirty page is flushed to disk).
- **U2**: If `T` commits, then `OUTPUT(X)` must be written to disk *before* `<COMMIT T>` is written to the log.

The consequence of U2 is that all disk writes happen **early**, before the transaction formally commits. This is the defining characteristic of Undo Logging and why it pairs naturally with Force-like behavior.

#### Recovery Process

After a system crash, the Recovery Manager determines the status of each transaction:

- **Complete**: log contains `<START T>` ... `<COMMIT T>` or `<START T>` ... `<ABORT T>`.
- **Incomplete**: log contains `<START T>` with no subsequent completion record.

**Undo Algorithm** — scan the log backwards from the end:

1. `<COMMIT T>` or `<ABORT T>`: Mark `T` as completed.
2. `<T, X, v>`: If `T` is **not** completed, write `X = v` to disk (undo the change). Otherwise, ignore.
3. `<START T>`: Ignore.

![[Recovery With Undo Log.png]]

Key properties of the Undo recovery process:
- **Which updates are undone**: Updates from incomplete (uncommitted) transactions — those that started but had no `<COMMIT>` or `<ABORT>` in the log.
- **How far back to read**: All the way to the beginning of the log (or the most recent checkpoint).
- **Crash during recovery**: Log records are **idempotent**, so the recovery algorithm can be safely restarted from scratch if a second crash occurs mid-recovery.

---

### Redo Log

A **Redo Log** is used when a system follows a **No-Force** policy. It allows the DBMS to replay changes that were committed but lost from the buffer pool during a crash, since committed pages may not have been flushed to disk before the failure.

- **Record Format**: `<T, X, v>` where `v` is the **new value** of element X after the modification. The record format is the same as the Undo Log, but the interpretation of `v` is inverted — here it stores what the element *should* be set to, not what it was before.
- **Recovery Process**: Scans the log **forwards** and re-applies the new value `v` for every update belonging to a committed transaction.

#### Recovery With Redo Log

After a system crash, the Recovery Manager runs two passes:

1. **Classify transactions**: Scan the log once to determine each transaction's outcome.
   - `<START T>` ... `<COMMIT T>` = committed.
   - `<START T>` ... `<ABORT T>` = not committed.
   - `<START T>` alone = not committed.
2. **Redo all committed updates**: Read the log from the beginning and re-apply the new values `v` for every update belonging to a committed transaction.

![[Recovery with Redo Logging.png]]

---
## Undo vs Redo
- Undo logging
	- OUTPUT must be done early
	- If `<COMMIT T>` is seen, T definitely has written all its data to disk (no need to redo) however it is inefficient
- REDO logging
	- OUTPUT must be done late
	- if `<COMMIT T>` is not seen, T has not written any of its data to risk, hence htere is not dirty data on disk, no need to redo. this is inflexibke
- Steal/No-force would be the ideal policy which is undo-redo log
### Undo-Redo Log
Log erecords, only one change
- `<T, X, u, v>` = T has updated element X, its old value was u and its new vlaue is V
The **Undo-Redo Log** is the industry standard and the basis for [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES]]. It stores **both** the old value and the new value, enabling support for both **Steal** and **No-Force** policies simultaneously.

- **Record Format**: `<T, X, old_v, new_v>`

This flexibility allows the buffer manager maximum freedom: dirty pages from uncommitted transactions can be flushed early (Steal), and committed pages are not required to be forced to disk at commit time (No-Force). The cost is larger log records, but the performance gains make it the universal choice in production systems.
### Rules
UR1: If T modifies X ,then `<T, X, u, v>` must be written to disk before OUTPUT(X)
### Crash
After system's crash, run recovery manager
- redo all committed transactions, top-down
- undo all uncommitted transactions, bottom-up
![[Undo, Redo crash.png]]
![[Recovery with UndoRedo Log.png]]

### ARIES (UNDO/REDO protocol)
#### Recovery Manager
Log Entries
- Start T: when T begins
- update: (T, X, u, v)
	- T updates X, old value=u and new value = v
	- logical description of the change
- COMMIT or ABORT T then END
  CLR
- Rule
	- if T modifies X, then `<T, X, u, v>` , must be written to disk before OUTPUT(X)
	- wee are free to OUTPUT early or late w.r.t committs
#### Log Sequence Number (LSN)
- LSM = identitifer of a log entry
	- Log entries belonging to the same TXN are linked with extra entry for previous LSN
	- pointer to Log Entry
- Each page contains a pageLSN
	- LSN of log record for latest update to that page
	- all pages also keep this when loaded into memory
	- what log entry did the last modification
	- ARIES keeps track of a bynch of LSN's
#### ARIES Data Structures
- ACtive Transaction Table
	- List all active TXN's
	- For each TXN: lastLSN = its most recent udpate LSN
- Dirty Page Tabke
	- lists all dirty pages
	- for each dirty page: recoveryLSN (recLSN) = first LSN taht caused dirty page to becopme ditrty
- Write Ahead Log
	- tail of the log may be in memory
	- LSN, prevLSN = prev LSN for same TXN
	- contains pointer of prevLSN which points to entry in dirty page table
![[ARIES Data Structures.png]]
#### Normal Operations
T writes page P
- write `<T, P, u, v>` in the log
	- no need to flush to disk yet
- pageLSN = LSN
- prevLSN = lastLSN
- lastLSN = LSN
- recLSN = if isNull then LSN
Buffer manager wants to OUTPUT(P)
- FLush log up to pageLSN
- remove P from dirty page tabler
Buffer manager wants INPUT(P)
- create entry in Dirty Page table recLSN = null
Transaction T starts
- write `<START T>` in the log
- new entry T in active TXN; lastLSN = null
Transaction T commits/aborts
- write `<COMMIT T>` in the log
- Flush log up to this entry
- write `<END>` and remove T from the active transaction table
#### Checkpoiunts
write intot he log
- entire active trsnactgions tbale
- entrie dirty pages table
- recovery always starts by analuzing latest checkpoint
- background process periodically flushes dirty pages to disk
	- this is a costly tranasction
#### ARIES Recovery
![[ARIES Method Illustration.png]]
##### Analysis Phase
- goal
	- determine point in log where to start REDO
	- determine set of dirty pages when crashed
		- conservative estimate of dirty pages
	- identify active transactions when crashes
- approach
	- rebuild active transactions table and dirty pages table
	- reprocess the log fron the checkpoint
		- only update the two data structures
	- compute: firstLSN = smallest of all recoveryLSN
![[ARIES Analysis Phase.png]]
##### Redo Phase
Main principle: replay history
- process log forward, starting from firstLSN
- read every log record, sequentially
- Redo actions are not recorded in the log
- Needs the dirty page table

---
## Checkpointing

Checkpointing periodically marks a known-good state in the log, bounding how far back the Recovery Manager must read after a crash.

**Basic (Quiescent) Checkpoint** procedure:
1. Stop accepting new transactions.
2. Wait until all current transactions complete.
3. Flush all dirty pages to disk.
4. Write a `<CKPT>` log record and flush the log to disk.
5. Resume accepting transactions.

![[Undo Recovery with Checkpointing.png]]

The limitation of basic checkpointing is that it **freezes the entire database** during the checkpoint window. For a high-traffic DBMS, this is unacceptable throughput overhead.

## Non-Quiescent Checkpointing

**Non-Quiescent Checkpointing** solves the freeze problem by allowing checkpoints to be taken while the database remains fully operational, with transactions continuing to run throughout.

**Procedure**:
1. Write `<START CKPT(T1, ..., Tk)>`, where T1, ..., Tk are **all currently active transactions**. Flush the log to disk.
	1. it means theyve bene written to disk
2. Begin flushing dirty pages from **already-committed** transactions (e.g., dirty blocks from a transaction T0 that committed before the START CKPT). Normal operations continue during this flush.
3. When all those dirty pages have been written to disk, write `<END CKPT>` and flush.

`<END CKPT>` means that previously committed transactions (like T0) are fully on disk. It does **not** mean that the active transactions T1, ..., Tk have completed — those are still in-flight.

![[Undo with Nonquiescent Checkpointing.png]]

![[Nonquiescent Checkpointing 2.png]]

## Implementing Rollback

A transaction can end in either `COMMIT` or `ROLLBACK`. The undo log is used to implement `ROLLBACK` directly without a full recovery scan:

1. Each log record has an **LSN** (Log Sequence Number).
2. Log entries for the same transaction are **linked** via LSN back-pointers, forming a per-transaction chain through the log.
3. To roll back transaction `T`, traverse the chain in **reverse** using LSN pointers, undoing each of T's changes until `<START T>` is reached.

## Abstraction Levels

The choice of what is recorded in each log record affects both log size and recovery performance:

| Type | Description | Pros/Cons |
|------|-------------|-----------|
| **Physical Logging** | Records exact byte-level changes (e.g., "In page 50, change bytes 10–20 to `'ABC'`"). | **Pros**: Fast to replay. **Cons**: Produces massive log files. |
| **Logical Logging** | Records high-level operations (e.g., "Insert tuple `'John'` into Users"). | **Pros**: Compact. **Cons**: Hard to make idempotent; slow and complex to replay. |
| **Physiological Logging** | Records logical changes *within* a specific physical page (page-level physical, intra-page logical). | **Pros**: The industry standard used in [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES]]. Compact and efficient to replay. |

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
- [[CSE444/Transactions/Recovery/Recovery|Recovery Overview]]
