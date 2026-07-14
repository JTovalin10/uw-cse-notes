# CSE451: Process Operations

The OS provides the following kinds of operations on [[Process|processes]] — together, these form the **process abstraction interface** that the kernel exposes to user programs:

- **Create**: bring a new process into existence, allocating a [[Process Control Block|PCB]] and an address space for it. See [[Process Creation|Process Creation]] and [[Fork|Fork]].
- **Delete**: terminate a process, eventually deallocating its [[Process Control Block|PCB]]. See [[Process Lifecycle Events|Process Lifecycle Events]].
- **Suspend**: temporarily halt a process's execution without destroying it, moving it out of contention for the CPU (e.g., into a Waiting/Blocked [[Process State|state]]).
- **Resume**: return a suspended process to a runnable [[Process State|state]] so the [[Scheduling|scheduler]] can dispatch it again.
- **Clone**: create a copy of a process — on UNIX, this is exactly what [[Fork|Fork]] does.
- **Inter-process communication**: mechanisms that let separate processes exchange data despite having isolated address spaces (pipes, sockets, shared memory).
- **Inter-process synchronization**: mechanisms that let processes coordinate their execution (e.g., to avoid race conditions when accessing shared resources).
- **Create/delete a child process (subprocess)**: a specialization of create/delete where the new process is explicitly tied to its creator in a parent-child relationship. See [[Process Creation|Process Creation]] for the semantics of this relationship.

## Related
- [[Process|Process]]
- [[Process Creation|Process Creation]]
- [[Fork|Fork]]
- [[Exec|Exec]]
- [[Process State|Process State]]
- [[Process Control Block|Process Control Block]]
- [[Process Lifecycle Events|Process Lifecycle Events]]
- [[Scheduling|Scheduling]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Clone | Process duplication (fork) |
| Inter-process synchronization | IPC synchronization primitives (mutexes, semaphores) |
