# CSE451: Process State

The **Process State** represents the current status of a [[Process|process]] as it executes and moves through the system. The OS tracks this state as part of the process's **[[Process Control Block|Process Control Block (PCB)]]**, and uses it to decide which **[[State Queues|state queue]]** the process's [[Process Control Block|PCB]] should currently be linked into.

## Common States
- **New**: The process is being created — its [[Process Control Block|PCB]] is being allocated and initialized (see [[Process Lifecycle Events|Process Lifecycle Events]]).
- **Ready**: Waiting to be assigned to a CPU. The process could run, but another process currently has the CPU. The [[Scheduling|scheduler]] chooses among Ready processes when the CPU becomes free.
- **Running**: Executing on a CPU. It is the process that currently controls the CPU, with its state loaded into the hardware registers (see [[CPU State|CPU State]]).
- **Waiting (Blocked)**: Waiting for an event (e.g., I/O completion or a message from another process). It cannot make progress until the event happens, so the OS does not consider it for scheduling until that event occurs.
- **Terminated**: The process has finished execution. Its [[Process Control Block|PCB]] may be retained briefly afterward before the OS deallocates it (see [[Process Lifecycle Events#When a Process Is Terminated|Process Lifecycle Events]]).

## State Transitions

As a process executes, it moves from state to state — for example, a Running process that issues a blocking I/O request moves to Waiting, and once that I/O completes, it moves to Ready rather than directly back to Running (since another process may currently hold the CPU). This state diagram illustrates the full set of transitions:
![[Pasted image 20260116004012.png]]

### User Process States (Diagram)
![[Screenshot 2026-01-14 at 6.06.24 PM.png]]

Each of these transitions corresponds to the process's [[Process Control Block|PCB]] being unlinked from one **[[State Queues|state queue]]** and relinked onto another — see [[State Queues|State Queues]] for the mechanics of that bookkeeping.

## Related
- [[Process|Process Overview]]
- [[CPU State#CPU Scheduling Information|CPU Scheduling]]
- [[Process Control Block|Process Control Block]]
- [[State Queues|State Queues]]
- [[Scheduling|Scheduling]]
- [[Process Lifecycle Events|Process Lifecycle Events]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Waiting (Blocked) | Blocked / sleeping |
| Ready | Runnable |

