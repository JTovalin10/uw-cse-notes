# Course: Logging Types

Databases use different logging strategies depending on the level of abstraction and the performance requirements of the system.

## Log Record Structure
A typical log record includes: `<T, X, old_v, new_v>`
- `T`: Unique Transaction ID.
- `X`: The element (page or record) being modified.
- `old_v`: The value *before* the update (used for **Undo**).
- `new_v`: The value *after* the update (used for **Redo**).

## Specific Log Types

### Undo Log
An **Undo Log** is used when a system follows a **Steal** policy. It allows the DBMS to revert changes made by transactions that did not successfully commit.
- **Record Format**: `<T, X, v>` where `v` is the **old value** of element X.
- **Recovery Process**: Scans the log **backwards** from the end. For every transaction that hasn't committed or aborted, it restores element X to value `v`.
- **Snapshots**: Undo logs can be used to create "snapshots" of the database state, allowing the system to set the data back to a known-good point in time.

![[Undo Log Example.png]]

- **Protocol**: 
    1. `<START T>` is written.
    2. Before any data `X` is modified on disk, `<T, X, old_v>` must be flushed to the log.
    3. `<COMMIT T>` is only written after all changes by `T` have been flushed to disk (**Force** policy often paired here).

### Redo Log
A **Redo Log** is used when a system follows a **No-Force** policy. It allows the DBMS to replay changes that were committed but lost from the buffer pool during a crash.
- **Record Format**: `<T, X, v>` where `v` is the **new value** of element X.
- **Recovery Process**: Scans the log **forwards**. Re-applies the new value `v` for every transaction that successfully committed.

### Undo-Redo Log
The industry standard (used in ARIES). It stores both the old and new values to support both **Steal** and **No-Force** policies simultaneously.

## Abstraction Levels

| Type | Description | Pros/Cons |
|------|-------------|-----------|
| **Physical Logging** | Records exact byte-level changes (e.g., "In page 50, change bytes 10-20 to 'ABC'"). | **Pros**: Fast to replay. **Cons**: Massive log files. |
| **Logical Logging** | Records high-level operations (e.g., "Insert tuple 'John' into Users"). | **Pros**: Compact. **Cons**: Hard to make idempotent; slow to replay. |
| **Physiological Logging** | Records logical changes *within* a specific physical page. | **Pros**: The industry standard (used in ARIES). Compact and efficient. |

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
