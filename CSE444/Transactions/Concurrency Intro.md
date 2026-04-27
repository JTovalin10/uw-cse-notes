# CSE444: Transactions

## What is a Transaction?

A **transaction** is a sequence of database operations that executes as a single logical unit with the **all-or-nothing** property: either all operations complete successfully, or none do.

```sql
START TRANSACTION;
  -- SQL statements
COMMIT;    -- make all changes permanent
-- or
ROLLBACK;  -- undo all changes (= ABORT)
```

- **`COMMIT`**: Makes all changes in the transaction permanent.
- **`ROLLBACK`** (= **ABORT**): Reverts the database to its state before the transaction began — used for fail-safety or to undo an accidentally executed query.

---

## Related

- [[CSE444/Index|CSE444 Index]]
- [[CSE344 Index|CSE344 — Transactions]] — introductory coverage of transactions and serializability
