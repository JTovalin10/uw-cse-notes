# CSE451: Sequential Process and What Is a Proc

A **proc** is a data structure, dynamically allocated inside OS memory, that the kernel uses to track everything it needs to know about a process (this is the same structure referred to as the **[[Process Control Block|Process Control Block (PCB)]]** elsewhere in these notes). The **[[Process|Process]]** itself is the OS's abstraction for execution — a process is a program in execution, as opposed to the program's static code sitting on disk.

## The Sequential Process

The simplest case of this abstraction is the **Sequential Process**, which consists of just:
- An address space.
- A single thread of execution.

A sequential process is:
- **The unit of execution**: it is what actually runs on the CPU.
- **The unit of scheduling**: the [[Scheduling|scheduler]] decides which sequential process gets the CPU next.
- **The dynamic (active) execution context**: this is what distinguishes a process from a program — the program is static, just a bunch of bytes sitting on disk, while the process is the live, changing state of that program actually being executed (registers, stack, program counter, etc., i.e. its [[Process#Execution Context|Execution Context]]).

This "sequential" model — one address space, one thread — is the baseline case. Once a process has *multiple* threads of execution sharing that one address space, the distinction between the process (the address space and resources) and the thread (the unit of execution within it) becomes important; see [[Process vs Thread|Process vs Thread]].

## Related
- [[Process|Process]]
- [[Process Control Block|Process Control Block]]
- [[Process vs Thread|Process vs Thread]]
- [[Scheduling|Scheduling]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| proc | Process Control Block (PCB) / task_struct (Linux) |
| Sequential Process | Single-threaded process |

