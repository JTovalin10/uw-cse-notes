# CSE344: Locking and Atomicity

## Locking

**Locks** enforce atomicity at the element level:
- Each element has a unique lock
- Each transaction must acquire the lock before reading or writing that element
- When done, the transaction must release the lock(s)
- If the lock is already held by another transaction, the requesting transaction waits and retries later

Locks guarantee **atomicity**, not **isolation** — for isolation, see [[Atomic and Isolated Transactions in SQL|2-Phase Locking (2PL)]].

Locks in a DBMS serve the same conceptual role as OS-level locks — mutual exclusion over shared state. See [[CSE451/Processes/Synchronization/Locks/Locks|Locks (CSE451)]] for the OS-level mechanism.

## Related
- [[ACID Properties]] — atomicity as one of the four correctness properties
- [[Atomic and Isolated Transactions in SQL]] — 2PL, which builds on locks to also guarantee isolation
- [[Other Lock Modes and Lock Granularity]] — shared/exclusive locks and fine vs. coarse-grained locking
- [[Interleaving and Concurrency Control]] — why atomicity and isolation are needed
- [[CSE451/Processes/Synchronization/Locks/Locks|Locks (CSE451)]] — OS-level perspective on locking
- [[CSE451/Processes/Synchronization/Mutual Exclusion|Mutual Exclusion]] — the property locks provide
