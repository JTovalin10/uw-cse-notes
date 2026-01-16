# Process vs Thread
OSTEP: *"Each thread is very much like a separate process, except for one difference: they share the same address space and thus can access the same data."*

| Aspect             | Process                                   | Thread                                  |
| ------------------ | ----------------------------------------- | --------------------------------------- |
| Definition         | Independent program in execution          | Unit of execution within a process      |
| Address Space      | Own separate address space                | Shares address space with other threads |
| Memory             | Does not share memory (needs IPC)         | Shares heap, data, code with siblings   |
| Creation Cost      | Expensive (copy address space)            | Cheap (just new stack + registers)      |
| [[Context Switch]] | Slow (switch page tables, flush TLB)      | Fast (same address space)               |
| Communication      | IPC required (pipes, sockets, shared mem) | Direct memory access                    |
| Isolation          | Strong - crash doesn't affect others      | Weak - one thread crash can kill all    |
| Resources          | Own file descriptors, sockets             | Shares file descriptors, sockets        |

# What they share vs don't share

## Process has its own:
- Address space
- Global variables
- Open files
- Child processes
- Signal handlers

## Thread has its own:
OSTEP: *"Different threads differentiate with each other mainly in: Different PC register values... Separate stacks and SP."*
- [[Program Counter]]
- [[Registers]]
- Stack
- Thread ID

## Threads share (within same process):
- Code section
- Data section (global variables)
- Heap
- Open files and sockets
- Signal handlers

## What processes CAN share
Even though processes have separate address spaces, they can share memory in specific ways:

- **Code/text segment** - if two processes run the same program (e.g., two terminals running bash), the instruction pages are mapped read-only and shared (same physical frames)
- **Read-only static data** - constants and string literals can be shared since they never change
- **Shared libraries** - code pages for libc, etc. are mapped read-only into multiple processes (same physical frames, different virtual addresses)
- **Copy-on-write after [[Fork]]** - parent and child initially share all pages, only copied when one writes
- **Explicit shared memory**:
	- `mmap()` with `MAP_SHARED` - memory-mapped files or anonymous shared regions
	- `shmget()`/`shmat()` - System V shared memory segments
- **Memory-mapped files** - multiple processes can map the same file into their address space

**Key insight**: anything read-only can be safely shared between processes since no one can modify it.

This is how [[Easy Sharing]] works with [[Virtual Addresses]] - multiple virtual pages can point to the same physical frame.

# When to use which
- **Use processes when:**
	- Need strong isolation (security)
	- Tasks are independent
	- Crash tolerance is important

- **Use threads when:**
	- Tasks need to share data frequently
	- Low overhead switching is important
	- Tasks are tightly coupled

# Source
- OSTEP Chapter 26: Concurrency - An Introduction
- OSTEP Chapter 13: The Abstraction - Address Spaces
