# CSE451: Process Creation

New [[Process|processes]] are created by existing processes, forming a **Parent**/**Child** relationship:
- **Parent**: the process doing the creating.
- **Child**: the newly created [[Process|process]]. On UNIX, you can see this relationship by running `ps` and looking at the PPID (Parent Process ID) field.

## Semantics of Inheritance

Depending on the OS, a child process inherits certain attributes from its parent. Examples include:
- The **open file table** — this is why a child implicitly inherits stdin, stdout, and stderr from its parent rather than starting with no I/O streams at all.
- On some systems, the resource allocation granted to the parent may be divided among its children rather than each child getting a fresh allotment.

### When a Child Is Created

On UNIX, once a child is created, the parent may either *wait for the child to finish* (blocking until the child terminates) or *continue running in parallel* with the child. This choice is made explicitly by the parent's code (e.g., whether it calls `wait()` immediately or not).

### Policies: Kernel vs. User Mode

On UNIX, the rules governing what a child inherits are **policies implemented by the kernel** itself as part of the `fork()` syscall. On Windows, by contrast, inheritance is not built into a single privileged operation — it is done explicitly in user mode by the `CreateProcess` library routine, which is not a system call. This is a meaningful architectural difference: UNIX bakes inheritance semantics into the kernel's process-creation mechanism, while Windows leaves the details to a user-level library.

## The Background (Idle) Process

Every OS needs to guarantee that the CPU always has *some* process ready to run — otherwise the [[Scheduling|scheduler]] would have nothing to dispatch when every other process is blocked. To guarantee this, systems maintain a **background process** (sometimes called the **NULL process** or **idle process**):
- It runs at the lowest possible priority.
- It only executes when nothing else is ready to run.
- It doesn't actually do any useful work — its sole purpose is to be a process that's always available to occupy the CPU, so the CPU is never left with literally nothing to schedule.

## UNIX Process Creation

On UNIX, process creation is performed with the **[[Fork|fork()]]** syscall.

## Creating a New Program

If the goal is not just to create a copy of the current process, but to run an entirely different program, forking the old program alone isn't enough — the child would just be a duplicate of the parent, running the same code. Instead, the standard two-step pattern is:
1. **[[Fork|Fork]]**: create a new child process (a copy of the parent).
2. **[[Exec|Exec]]**: within that child, replace its program image with the new program's code.

This separation of "create a process" from "load a program into it" is discussed further in [[exec vs fork|exec vs fork]].

## Related
- [[Process|Process]]
- [[Fork|Fork]]
- [[Exec|Exec]]
- [[exec vs fork|exec vs fork]]
- [[Process Lifecycle Events|Process Lifecycle Events]]
- [[Scheduling|Scheduling]]
- [[Process State|Process State]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Background/NULL process | Idle process / idle task |
| proc | Process Control Block (PCB) |

