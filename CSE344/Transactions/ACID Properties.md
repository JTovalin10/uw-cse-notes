# Transactions: ACID Properties

**ACID** is the set of properties a transaction must have to correctly interact with a database.

## The Four Properties

- **A = Atomic**
	- An operation on the database is atomic if everything works or nothing happens
	- If the operation does multiple updates and the system crashes in between, atomicity may be violated
	- Enforced with [[Atomic Transactions in SQL|locks]]

- **C = Consistent**
	- Consists of constraints on the data to ensure its integrity and compliance with the application's specifications
	- An operation is consistent if the database is valid both at the start and at the end
	- What can go wrong:
		- The application is buggy
		- The database system corrupts the update — this will not happen if the operation is atomic and isolated

- **I = Isolated**
	- Isolation is how we manage concurrency
	- An isolated operation behaves as if it were the only one running on the system
	- Enforced with [[Atomic and isolated Transactions in SQL|2PL]]

- **D = Durable**
	- The update must persist even after the application terminates
	- Involves writing to disk and recovering from crashes or partial loss

## Why ACID Matters

- DBMSes can provide ACID properties for individual tables and rows — reading and writing a row is atomic
- DBMSes **cannot** provide ACID for database applications without help from the application (e.g., showing order history while fulfilling an order)
- DBMSes give developers **transactions** to define their own application-specific blocks
	- The DBMS promises these blocks will be atomic and isolated regardless of any possible interleaving
	- Developers use these blocks to ensure consistent reads and writes

## Transactions in SQL

An application's logical operation may involve multiple DBMS operations. To ensure safe execution, we group them into a transaction:

```SQL
BEGIN TRANSACTION;
-- SQL statements
COMMIT;   -- finalizes everything

ROLLBACK; -- undoes everything
```

A **transaction** is a sequence of database operations executed together as a single unit, isolated from all other operations.

## Related
- [[Interleaving and Concurrency Control]] — concurrency conflicts that motivate ACID
- [[Schedules and Serial Schedules]] — how serializability relates to isolation
- [[Atomic Transactions in SQL]] — how atomicity is enforced with locks
- [[Atomic and isolated Transactions in SQL]] — how isolation is enforced with 2PL
- [[Isolation Levels]] — weaker ACID guarantees and their trade-offs
