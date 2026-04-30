# Transaction Fundamentals

A **transaction** is a sequence of database operations that executes as a single logical unit with the **all-or-nothing** property: either all operations complete successfully, or none do.

```sql
START_TXN; -- may be omitted if autocommit is off
  [...]
COMMIT;    -- make all changes permanent
-- or
ROLLBACK;  -- undo all changes (= ABORT)
```

- **`COMMIT`**: Makes all changes in the transaction permanent.
- **`ROLLBACK`** (= **ABORT**): Reverts the database to its state before the transaction began. Used for user-driven cancels, application errors, or system-level recovery.

## ACID Properties

To ensure data integrity, a DBMS must provide **ACID** properties:

- **A**tomicity: Either all changes performed by a transaction occur or none occur (**all-or-nothing**).
- **C**onsistency: A transaction as a whole does not violate database integrity constraints.
- **I**solation: Transactions appear to execute one after the other in sequence (as if they were sequential).
- **D**urability: Once a transaction commits, its changes will survive system failures (written to disk).

### Why ACID is Hard
- **Concurrent operations**: Lead to isolation problems.
- **System Failures**: Occur at any time, impacting atomicity and durability.
- **Aborts**: Transactions may need to be rolled back mid-way.

## Terminology: Buffer Management & Recovery

- **Steal or No-Steal**:
    - **Steal**: An uncommitted transaction can overwrite the most recent committed value on disk. (Highest performance).
    - **No-Steal**: Changes are kept in memory until the transaction commits.
- **Force or No-Force**:
    - **Force**: All updates must be written to disk *before* the transaction commits. (Easiest for recovery).
    - **No-Force**: A transaction can commit before all its data is on disk. (Highest performance).

| Setup | Difficulty | Performance |
|-------|------------|-------------|
| **No-Steal / Force** | Easiest for recovery | Poor |
| **Steal / No-Force** | Complex recovery (Undo/Redo) | Highest |
