# CSE444: Deadlocks

## How to find if a deadlock occurred
- Lock requests create a **wait-for graph** (precedence graph) where a **deadlock** $\rightarrow$ cycle.
- Cycle detection over a graph is somewhat expensive, so we check the graph only periodically.
- ![[CSE444/screenshots/DeadLock cycle.png]]

### What to do after detection
- If the DBMS finds a cycle:
	- Roll back transactions (txns).
	- (Hopefully) make progress.
	- Eventually retry the rolled-back txns.

## Deadlocks
A **deadlock** is a cycle in the wait-for graph:
- $T_1$ waits for $T_2$
- $T_2$ waits for $T_3$
- $T_3$ waits for $T_4$
- $T_4$ waits for $T_1$

### Deadlock Detection
- **Timeouts**: Assume deadlock if a transaction waits too long.
- **Wait-for graph**: Periodically check for cycles.
- ![[CSE444/screenshots/2PL Deadlocks.png]]

### Deadlock Avoidance
- Acquire locks in pre-defined order.
- Acquire all locks at once before starting.

## Related
- [[Locking]]
- [[The Locking Scheduler]]
- [[CSE451/Concurrency/Synchronization/Deadlock|Deadlocks (CSE451)]]
