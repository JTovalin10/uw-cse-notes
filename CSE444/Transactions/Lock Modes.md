# CSE444: Lock Modes

## Lock Modes
- **Shared lock (S)**: Used for reading.
- **Exclusive lock (X)**: Used for writing.

### Lock Compatibility Matrix
![[CSE444/screenshots/Lock compatibility matrix.png]]

## Lock Granularity
- **Fine granularity locking** (e.g., tuples/rows):
	- High concurrency.
	- High overhead in managing many locks.
- **Coarse grain locking** (e.g., tables, predicate locks):
	- Many false conflicts.
	- Less overhead in managing fewer locks.

## Lock Performance
![[CSE444/screenshots/Lock Performance.png]]

**Thrashing** in a DBMS can occur due to:
- False conflicts if using coarse grain locking.
- Excessive overhead if using fine grain locking.

## Related
- [[Locking]]
- [[The Locking Scheduler]]
- [[Phantom Problem]]
