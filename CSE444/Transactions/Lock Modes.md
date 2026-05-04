## Lock Modes
S = shared lock (for read)
X = exclusive lock (for write)
![[Lock compatibility matrix.png]]
## Lock Granularity
- fine granularity locking (tuples)
	- high concurrency
	- high overhead in managing locks
- coarse grain locking (tables, predicate locks)
	- many false conflicts
	- less overhead in managing locks
## Lock Performance
![[Lock Performance.png]]
thrashing in DBMS: could be false conflicts if using corase grain or overhead if using fine grain