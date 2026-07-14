# CSE451: Representation of Processes by the OS

## OS Bookkeeping

The OS maintains a data structure to keep track of each process's state: the **[[Process Control Block|Process Control Block (PCB)]]**, also called a **process descriptor**, identified uniquely by the **[[Process#Process Identification (PID)|Process ID]]**.

The OS keeps all of a process's execution state in (or linked from) this proc whenever the process isn't currently running:
- **[[CPU State#Registers|Registers]]**: when a process is unscheduled (taken off the CPU), its execution state is transferred out of the hardware registers and into the proc, so nothing is lost.
- When a process **is** running, by contrast, its state is spread between the proc (for the parts not actively in use, such as scheduling info) and the CPU itself (for the live register values). This split-location model is the same one described in [[How does the CPU interact with proc|How does the CPU interact with proc]].

## Related
- [[Process Control Block|Process Control Block]]
- [[CPU State|CPU State]]
- [[How does the CPU interact with proc|How does the CPU interact with proc]]
- [[Process|Process]]
- [[Process State|Process State]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| proc / process descriptor | Process Control Block (PCB) / task_struct (Linux) |
