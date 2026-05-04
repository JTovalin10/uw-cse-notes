![[2PL Deadlocks.png]]
## How to find if a deadlock occurred
- lock requests create a precedence/wait-for graph where deadlock $\rightarrow$ cycle (2PL is dong its job!)
- Cycle detection over a graph is somewhat expensive, so we check the graph only preiodically
- ![[DeadLock cycle.png]]
### what to do after
- If the DBMS finds a cycle
	- we rollback txns
	- (hopefully) make progress
	- eventually retry the rolledback txns
## Deadlocks
- cycle in the wait-for graph
	- T1 waits for T2
	- T2 waits for T3
	- T3 waits for T4
	- T4 waits for T1
- Deadlock detection
	- timeouts
	- wait-for graph
- Deadlock avoidance
	- acquire locks in pre-defined order
	- acquire all locks at once before starting