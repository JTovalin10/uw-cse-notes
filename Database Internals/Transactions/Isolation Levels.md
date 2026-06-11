# Database Internals: Isolation Levels

SQL standardizes several isolation levels that trade off consistency for performance. Each level is defined by which **[[Database Internals/Transactions/Concurrency Anomalies|concurrency anomalies]]** it permits and which it prevents, typically implemented via [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Two-Phase Locking (2PL)]] with varying lock durations.

## Isolation Levels in SQL

### 1. Read Uncommitted
- `SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED`
- **Writes**: Long duration write locks (**Strict 2PL**).
- **Reads**: No read locks.
- Read-only transactions are never delayed.
- **Problem**: **[[Database Internals/Definitions/Dirty Read|Dirty reads]]** (reading uncommitted data from another transaction).

### 2. Read Committed
- `SET TRANSACTION ISOLATION LEVEL READ COMMITTED`
- **Writes**: Long duration write locks (**Strict 2PL**).
- **Reads**: Short duration read locks (released immediately after reading).
- **Problems**:
	- **[[Database Internals/Definitions/Unrepeatable Read|Unrepeatable reads]]**: Reading the same element twice may return different values if another transaction committed in between.
	- **Inconsistent reads**: Reads within a transaction may see different snapshots of the database.

### 3. Repeatable Read
- `SET TRANSACTION ISOLATION LEVEL REPEATABLE READ`
- **Writes**: Long duration write locks (**Strict 2PL**).
- **Reads**: Long duration read locks (**Strict 2PL**).
- **Problem**: **[[Database Internals/Transactions/Phantom Problem|Phantoms]]** — newly inserted or deleted rows may appear or disappear between two queries that use the same predicate.

### 4. Serializable
- `SET TRANSACTION ISOLATION LEVEL SERIALIZABLE`
- Full **ACID** compliance.
- **Writes/Reads**: Long duration write and read locks (**Strict 2PL**).
- **Phantoms**: Uses **predicate locking** or index locking to prevent phantom rows.

## Summary Table
| Isolation Level | [[Database Internals/Definitions/Dirty Read|Dirty Read]] | [[Database Internals/Definitions/Unrepeatable Read|Unrepeatable Read]] | [[Database Internals/Transactions/Phantom Problem|Phantom]] |
| :--- | :---: | :---: | :---: |
| Read Uncommitted | Possible | Possible | Possible |
| Read Committed | No | Possible | Possible |
| Repeatable Read | No | No | Possible |
| Serializable | No | No | No |

## Industry Standard Terms
- **Read Uncommitted** $\rightarrow$ Dirty Read isolation (rarely used in production)
- **Read Committed** $\rightarrow$ Default isolation level in PostgreSQL, Oracle, SQL Server
- **Repeatable Read** $\rightarrow$ Default isolation level in MySQL InnoDB
- **Serializable** $\rightarrow$ Full serializability; maps to **Strict 2PL** or **SSI** (Serializable Snapshot Isolation) in modern systems

## Related
- [[Database Internals/Transactions/PessimisticComponents/Pessimistic Scheduler|Locking]]
- [[Database Internals/Transactions/Phantom Problem|Phantom Problem]]
- [[Database Internals/Transactions/Transaction Fundamentals|Transaction Fundamentals]]
- [[Database Internals/Transactions/OptimisticComponents/Snapshot Isolation|Snapshot Isolation]]
