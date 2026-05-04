Task 1: act on behalf of the transaction, Add lock/unlock requests to transactions
- examine all READ(A) or WRITE(A) actions
- add appropriate lock requests
- On COMMIT/ROLLBACK release all locks
- Ensure Strict 2PL
Task 2: act on behalf of the system, execute the locks accordingly
- lock table: a big critical structure in a DBMS
- When a lock is requested, check the lock table, grant, or add the transaction to the element's wait list
- when lock is released reactive transaction from its wait list
- when a transaction aborts, release all its locks
- Check for deadlocks occasionally
