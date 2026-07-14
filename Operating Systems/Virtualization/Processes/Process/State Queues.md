# CSE451: State Queues

The OS maintains a collection of queues that represent the state of all **[[Process|Processes]]** in the system — typically one queue for each **[[Process State|Process State]]** (e.g., a Ready queue, one or more Waiting/Blocked queues, and so on).

Each process is queued onto a state queue according to its current [[Process State|state]]. As a process changes state — for example, moving from Running to Waiting when it blocks on I/O — its **[[Process Control Block|proc]]** is unlinked from one queue and linked onto another to reflect the transition. This is the concrete data-structure mechanism underlying the state transitions described in [[Process Lifecycle Events#As a process computes|Process Lifecycle Events]].

Procs are moved between queues, which are represented as linked lists — this makes insertion and removal from any queue an efficient, constant-time pointer operation, since the OS only has to adjust a few `next`/`prev` pointers rather than shift or search through an array.

![[Pasted image 20260116004349.png]]

## Related
- [[Process|Process]]
- [[Process State|Process State]]
- [[Process Control Block|Process Control Block]]
- [[Process Lifecycle Events|Process Lifecycle Events]]
- [[Scheduling|Scheduling]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| State Queues | Run queue / wait queue |
| proc | Process Control Block (PCB) |

