If tuples are inserted/deleted then the phantom problem appears
![[Phantom Problem.png]]
A phantom is a tuple that is invisible during part of a transaction execution but not invisible during the entire execution
- in the example
	- T1 reads list of products
	- T2 inserts a new product
	- T1 re-reads: a new product appears
## Dealing with Phantoms
- lock the entire table
- lock the index entry for 'blue'
	- if index is avaliable
- or use predicate locks
	- a lock on an arbitrary predicate
- Dealing with phantom's is expensive