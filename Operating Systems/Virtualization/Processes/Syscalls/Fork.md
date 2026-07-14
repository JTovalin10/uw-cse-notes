# CSE451: Fork

## What Is It

The **`fork()`** syscall creates a new [[Process|process]] that is a **complete copy** of the calling process — except for its **[[Process#Process Identification (PID)|PID]]**. Conceptually, `fork()` means "clone me": everything about the calling process, from its code to its data to its open files, is duplicated into a brand-new process.

`fork()` does this by:
- **Creating and initializing a new proc** ([[Process Control Block|Process Control Block (PCB)]]):
	- Initializing the kernel resources of the new process with the resources of the parent (e.g., copying the open file table, so the child inherits the parent's stdin/stdout/stderr — see [[Process Creation#Semantics|Process Creation]]).
	- Initializing the child's [[CPU State#Program Counter (PC)|Program Counter (EIP)]] and [[CPU State#Stack Pointer (SP)|Stack Pointer (ESP)]] to be the same as the parent's, so the child resumes execution at the exact same point in the code as the parent.
- **Creating a new address space**: initializing the new address space with a copy of the entire contents of the parent's address space.
- **Placing the new proc on the ready queue** (see [[State Queues|State Queues]]), so the [[Scheduling|scheduler]] can eventually run it.

## fork() "Returns Twice"

Unlike a normal function call, `fork()` returns once into the parent, and once into the child:
- Returns the child's PID to the parent.
- Returns 0 to the child.

### The Register-Level Trick

When `fork()` is called, the OS clones the entire process state, including all registers. To allow the two processes to distinguish themselves, the OS manually modifies the **return value register** (e.g., `%rax` on x86-64 or `%eax` on x86-32) in the child's saved context:
- In the **Parent**: The OS places the PID of the new child into the return register.
- In the **Child**: The OS places **0** into the return register.

When both processes resume (pop their registers and return to user space), they see different values from the same function call — this single register modification is the entire mechanism by which the same line of code (`pid = fork();`) can produce two different observable outcomes.

## Calling fork (Copy-on-Write Implementation)

A naive implementation of `fork()` would copy the entire address space contents immediately, which is slow (see [[Optimizing Fork|Optimizing Fork]] for why). Real implementations instead use **[[Operating Systems/Virtualization/Memory/Concepts/Copy-on-Write|Copy-on-Write]]**:

1. Creates a new address space for the child.
2. Initializes the child's page tables with the same mappings as the parent's — no copying of address space contents has occurred at this point, with the sole exception of the top page of the stack.
3. Sets both the parent's and child's page tables to make all pages read-only, even pages that were previously writable (like the stack or heap).
4. If either the parent or the child then writes to memory, this read-only marking causes a hardware exception rather than a silent write.
5. When this **[[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception|Exception]]** occurs, the OS copies just that one page, adjusts the faulting process's page tables to point at the new private copy, and marks it writable again — so only pages that are actually modified ever get duplicated.

## Image
![[Pasted image 20260116005901.png]]

## Related
- [[Exec|Exec]]
- [[exec vs fork|exec vs fork]]
- [[Optimizing Fork|Optimizing Fork]]
- [[vfork|vfork]]
- [[clone|clone]]
- [[Process Creation|Process Creation]]
- [[Operating Systems/Virtualization/Memory/Concepts/Copy-on-Write|Copy-on-Write]]
- [[State Queues|State Queues]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| fork() | POSIX `fork()` |
| proc | Process Control Block (PCB) |
