# Atomic and isolated Transactions in SQL

**Atomic and Isolated Transactions** are two of the core **ACID** properties in database systems.

## Definitions
- **Atomic**: Ensures an "all-or-nothing" execution. Either all operations within a transaction are successfully committed to the database, or none of them are, ensuring no partial updates.
- **Isolated**: Ensures that concurrent transactions do not interfere with each other. Each transaction should behave as if it is the only process running on the system, often achieved through locking mechanisms like **Two-Phase Locking (2PL)**.
