# Course: Process State

The **Process State** represents the current status of a process as it executes and moves through the system.

## Common States
- **New**: The process is being created.
- **Ready**: Waiting to be assigned to a CPU. The process could run, but another process currently has the CPU.
- **Running**: Executing on a CPU. It is the process that currently controls the CPU.
- **Waiting (Blocked)**: Waiting for an event (e.g., I/O completion or a message from another process). It cannot make progress until the event happens.
- **Terminated**: The process has finished execution.

## State Transitions
As a process executes, it moves from state to state:
![[Pasted image 20260116004012.png]]

### User Process States (Diagram)
![[Screenshot 2026-01-14 at 6.06.24 PM.png]]

## Related
- [[CSE451/Virtualization/Processes/Process|Process Overview]]
- [[CSE451/Virtualization/Processes/CPUState/CPU State#CPU Scheduling Information|CPU Scheduling]]
