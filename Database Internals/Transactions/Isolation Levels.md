# CSE444: Isolation Levels

SQL standardizes several isolation levels that trade off consistency for performance.

## Isolation Levels in SQL

### 1. Read Uncommitted
- `SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED`
- **Writes**: Long duration write locks (**Strict 2PL**).
- **Reads**: No read locks.
- Read-only transactions are never delayed.
- **Problem**: **Dirty reads** (reading uncommitted data).

### 2. Read Committed
- `SET TRANSACTION ISOLATION LEVEL READ COMMITTED`
- **Writes**: Long duration write locks (**Strict 2PL**).
- **Reads**: Short duration read locks (released immediately after reading).
- **Problems**: 
	- **Unrepeatable reads**: Reading the same element twice may return different values if another txn committed in between.
	- **Inconsistent reads**.

### 3. Repeatable Read
- `SET TRANSACTION ISOLATION LEVEL REPEATABLE READ`
- **Writes**: Long duration write locks (**Strict 2PL**).
- **Reads**: Long duration read locks (**Strict 2PL**).
- **Problem**: **Phantoms** (newly inserted/deleted rows may appear/disappear).

### 4. Serializable
- `SET TRANSACTION ISOLATION LEVEL SERIALIZABLE`
- Full **ACID** compliance.
- **Writes/Reads**: Long duration write and read locks (**Strict 2PL**).
- **Phantoms**: Uses **predicate locking** or index locking to deal with phantoms.

## Summary Table
| Isolation Level | [[CSE444/Definitions/Dirty Read|Dirty Read]] | [[CSE444/Definitions/Unrepeatable Read|Unrepeatable Read]] | [[CSE444/Transactions/Phantom Problem|Phantom]] |
| :--- | :---: | :---: | :---: |
| Read Uncommitted | Possible | Possible | Possible |
| Read Committed | No | Possible | Possible |
| Repeatable Read | No | No | Possible |
| Serializable | No | No | No |

## Related
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|Locking]]
- [[Phantom Problem|Phantom Problem]]
- [[Transaction Fundamentals|Transaction Fundamentals]]
- [[CSE444/Transactions/Optimistic Components/Snapshot Isolation|Snapshot Isolation]]

