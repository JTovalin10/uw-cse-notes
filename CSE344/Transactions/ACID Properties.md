# CSE344: ACID Properties

**ACID** is the set of properties a transaction must have to correctly interact with a database.

## The Four Properties

- **A = Atomic**
	- An operation on the database is **atomic** if everything works or nothing happens
	- If the operation does multiple updates and the system crashes in between, atomicity may be violated
	- Enforced with [[Atomic Transactions in SQL|locks]]

- **C = Consistent**
	- **Consistency** consists of constraints on the data to ensure its integrity and compliance with the application's specifications
	- An operation is consistent if the database is valid both at the start and at the end
	- What can go wrong:
		- The application is buggy
		- The database system corrupts the update — this will not happen if the operation is atomic and isolated
	- See [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] for how the database enforces consistency declaratively
	- Analogous to [[CSE331/Part II - Software Engineering/Software Engineering/Representation Invariants|Representation Invariants]] in program design — invariants the data must satisfy before and after each operation

- **I = Isolated**
	- **Isolation** is how we manage concurrency
	- An isolated operation behaves as if it were the only one running on the system
	- Enforced with [[Atomic and Isolated Transactions in SQL|2PL]]

- **D = Durable**
	- **Durability** means the update must persist even after the application terminates
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

See [[CSE344/SQL/Basics|SQL Basics]] for the underlying SQL statement syntax that goes inside a transaction.

## Related
- [[Interleaving and Concurrency Control]] — concurrency conflicts that motivate ACID
- [[Schedules and Serial Schedules]] — how serializability relates to isolation
- [[Atomic Transactions in SQL]] — how atomicity is enforced with locks
- [[Atomic and Isolated Transactions in SQL]] — how isolation is enforced with 2PL
- [[Isolation Transactions in SQL]] — conflict-serializability as a way to verify isolation
- [[Isolation Levels]] — weaker ACID guarantees and their trade-offs
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — declarative consistency enforcement
- [[CSE451/Processes/Synchronization/Synchronization|Synchronization]] — OS-level concurrency control that underlies DBMS locking
