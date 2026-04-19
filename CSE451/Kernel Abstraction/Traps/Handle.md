# CSE451: Handle (Kernel Object Reference)

A **handle** is an opaque identifier used to reference a kernel object from user space, without exposing the kernel's internal address or data structure.

## Core Idea
We never want to expose the kernel address of an object to the user, as this would allow user code to manipulate kernel data structures directly. Instead, the kernel assigns each object a handle — which can be as simple as an assigned integer or a seemingly arbitrary number.

In the kernel, a **handle table** maps each handle to its corresponding kernel data structure.

**Example:**
- [[Process ID]] (PID) — a handle for a process

![[Pasted image 20260116002710.png]]

## Related
- [[Process ID]] — the PID is the most common example of a handle
- [[Kernel Mode]] — kernel internals are protected from user access
- [[System Call]] — syscalls take handles as arguments to identify kernel objects
