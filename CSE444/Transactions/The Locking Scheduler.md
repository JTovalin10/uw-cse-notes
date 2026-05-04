# CSE444: The Locking Scheduler

The scheduler operates in two main tasks:

### Task 1: Transaction Agent
Acts on behalf of the transaction by adding lock/unlock requests.
- Examine all `READ(A)` or `WRITE(A)` actions.
- Add appropriate lock requests.
- On **COMMIT** or **ROLLBACK**, release all locks.
- Ensure **Strict 2PL** (Two-Phase Locking).

### Task 2: System Agent
Acts on behalf of the system to execute the locks accordingly.
- Manages the **Lock Table**: A major critical structure in a DBMS.
- When a lock is requested:
	- Check the lock table.
	- Grant the lock if compatible.
	- Otherwise, add the transaction to the element's wait list.
- When a lock is released:
	- **Reactivate** a transaction from its wait list.
- When a transaction aborts, release all its locks.
- Check for **Deadlocks** periodically.

## Related
- [[Locking]]
- [[Lock Modes]]
- [[Deadlocks]]
