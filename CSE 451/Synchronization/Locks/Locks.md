# What is it
a lock is a memory object with two operations
```c
acquire() // obtain the right to enter the critical section
release() // give up the right to be in the critical section
```
Note: acquire prevents progress of the thread until the lock can be acquired

![[Pasted image 20260117081754.png]]

# Key property
- operations must be [[Atomic]]

# Implementation
locks require hardware support for atomic operations:
- [[test_and_set]]
- [[compare_and_swap]]

# Related
- [[Critical Sections]]
- [[Mutual Exclusion]]
- [[Spinlock]]
