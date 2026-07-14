# CSE451: Process vs Thread

A **[[Process|Process]]** is an independent program in execution with its own private address space, while a **Thread** is a unit of execution *within* a process that shares that address space with its sibling threads. OSTEP: *"Each thread is very much like a separate process, except for one difference: they share the same address space and thus can access the same data."*

| Aspect             | Process                                   | Thread                                  |
| ------------------ | ----------------------------------------- | --------------------------------------- |
| Definition         | Independent program in execution          | Unit of execution within a process      |
| Address Space      | Own separate address space                | Shares address space with other threads |
| Memory             | Does not share memory (needs IPC)         | Shares heap, data, code with siblings   |
| Creation Cost      | Expensive (copy address space)            | Cheap (just new stack + registers)      |
| [[CPU State#Context Switch|Context Switch]] | Slow (switch page tables, flush TLB)      | Fast (same address space)               |
| Communication      | IPC required (pipes, sockets, shared mem) | Direct memory access                    |
| Isolation          | Strong - crash doesn't affect others      | Weak - one thread crash can kill all    |
| Resources          | Own file descriptors, sockets             | Shares file descriptors, sockets        |

# What They Share vs Don't Share

## Process has its own:
- Address space
- Global variables
- Open files
- Child processes
- Signal handlers

## Thread has its own:
OSTEP: *"Different threads differentiate with each other mainly in: Different PC register values... Separate stacks and SP."*
- [[CPU State#Program Counter (PC)|Program Counter]]
- [[CPU State#Registers|Registers]]
- Stack
- Thread ID

## Threads share (within same process):
- Code section
- Data section (global variables)
- Heap
- Open files and sockets
- Signal handlers

## What Processes CAN Share

Even though processes have separate address spaces, they can still share memory in specific, controlled ways:

- **Code/text segment**: if two processes run the same program (e.g., two terminals running bash), the instruction pages are mapped read-only and shared, meaning both processes' page tables point at the same physical frames.
- **Read-only static data**: constants and string literals can be shared since they never change, so there is no risk of one process's writes corrupting another's view of the data.
- **Shared libraries**: code pages for libc, etc. are mapped read-only into multiple processes — same physical frames, but potentially different virtual addresses in each process.
- **[[Operating Systems/Virtualization/Memory/Concepts/Copy-on-Write|Copy-on-Write]] after [[Fork|Fork]]**: parent and child initially share all pages read-only, and a page is only copied privately for whichever process first tries to write to it. See [[Optimizing Fork#COW|Optimizing Fork]] for the mechanism (shared mapping, read-only protection, write-triggered fault, and copy).
- **Explicit shared memory**:
	- `mmap()` with `MAP_SHARED` - memory-mapped files or anonymous shared regions.
	- `shmget()`/`shmat()` - System V shared memory segments.
- **Memory-mapped files**: multiple processes can map the same file into their address space.

**Key insight**: anything read-only can be safely shared between processes since no one can modify it, so there's no correctness risk in mapping the same physical frame into multiple address spaces.

This sharing is possible because of how the **[[Operating Systems/Virtualization/Mechanisms/Memory/Virtual Addresses|Virtual Addresses]]** system works — multiple virtual pages (potentially in different processes, at different virtual addresses) can point to the same underlying physical frame.

# When to Use Which
- **Use processes when:**
	- Need strong isolation (security)
	- Tasks are independent
	- Crash tolerance is important

- **Use threads when:**
	- Tasks need to share data frequently
	- Low overhead switching is important
	- Tasks are tightly coupled

## Related
- [[Process|Process]]
- [[CPU State|CPU State]]
- [[Optimizing Fork|Optimizing Fork]]
- [[Fork|Fork]]
- [[Operating Systems/Virtualization/Memory/Concepts/Copy-on-Write|Copy-on-Write]]
- [[Operating Systems/Virtualization/Mechanisms/Memory/Virtual Addresses|Virtual Addresses]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Thread | Lightweight process / kernel thread |
| IPC | Inter-Process Communication |

# Source
- OSTEP Chapter 26: Concurrency - An Introduction
- OSTEP Chapter 13: The Abstraction - Address Spaces
