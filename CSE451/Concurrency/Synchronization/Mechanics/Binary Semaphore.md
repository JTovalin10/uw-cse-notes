- value is 0 or 1
- Guarantees [[CSE451/Concurrency/Synchronization/Mechanics/Mutual Exclusion]] access to resource
- only one [[CSE451/Concurrency/Threads/Thread|Thread]]/[[CSE451/Virtualization/Processes/Process|Process]] allowed entry at a time
	- uses a queue
- logically equivalent to a lock with blocking rather than spinning
- **initialized to 1**
# Usage
From the programmer's perspective, P and V on a binary semaphore are just like acquire and release on a lock![[Screenshot 2026-01-20 at 3.41.05 PM.png]]
however, same lack of programming language support for correct usage
# Examples
[[Bounded Buffer Problem]]
