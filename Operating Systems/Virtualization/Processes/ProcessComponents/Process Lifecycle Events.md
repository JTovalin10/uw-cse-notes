# CSE451: Process Lifecycle Events

A [[Process|process]]'s lifetime is bookended by two OS-managed events — creation and termination — with a long middle phase where the OS continuously tracks its progress. This file walks through what the OS does at each stage, using the same **proc** (the OS's internal data structure for tracking a process, i.e. the **[[Process Control Block|Process Control Block (PCB)]]**) introduced in [[Process Creation|Process Creation]].

## When a Process Is Created

1. The OS allocates a **proc** (a [[Process Control Block|Process Control Block (PCB)]]) for the new process.
2. The OS initializes that proc — filling in fields like the [[Process#Process Identification (PID)|Process ID]], initial [[CPU State|CPU State]], and address space information.
3. The OS performs other setup work not directly related to the proc itself (e.g., allocating an address space, setting up the initial page tables).
4. The OS places the new proc onto the correct **[[State Queues|state queue]]** — typically the Ready queue, so the [[Scheduling|scheduler]] can begin considering it for execution.

## As a Process Computes

As a process runs and its status changes — for example, moving from Running to Waiting because it blocked on I/O, or from Waiting back to Ready once that I/O completes — the OS moves its proc from queue to queue to reflect its current **[[Process State|Process State]]**. See [[State Queues|State Queues]] for the mechanics of how procs are unlinked from one queue and relinked onto another.

## When a Process Is Terminated

- The proc may be retained for a while even after the process finishes executing — for example, so it can still receive signals, or so its parent can retrieve its exit status via `wait()`.
- Eventually, once that bookkeeping information is no longer needed, the OS deallocates the proc, freeing the kernel memory it occupied.

## Related
- [[Process Creation|Process Creation]]
- [[State Queues|State Queues]]
- [[Process State|Process State]]
- [[Process Control Block|Process Control Block]]
- [[Scheduling|Scheduling]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| proc | Process Control Block (PCB) / task_struct (Linux) |

