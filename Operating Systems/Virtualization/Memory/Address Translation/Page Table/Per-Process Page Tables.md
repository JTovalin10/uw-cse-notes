# CSE451: Per-Process Page Tables

## Core Concept
Each process has its own page table, entirely separate from every other process's page table. This is not just an implementation detail — it is the mechanism that makes memory protection possible in the first place.

## Why This Enforces Isolation
Because each process only ever consults its own page table, and its page table only ever contains entries for frames the OS has explicitly assigned to it, a process has no way to even *name* another process's memory, let alone read or write it. Consider two processes:
- Process A's page table points its virtual pages at physical frame (PF) 50.
- Process B's page table points its virtual pages at physical frame (PF) 90.

There is no entry in Process A's table that points to frame 90. Therefore, it is physically impossible for Process A to touch Process B's memory — not merely forbidden by a permission check, but structurally unreachable, since Process A's virtual addresses can only ever be translated through entries that exist in Process A's own table. Even if Process A computed a virtual address that happened to be numerically identical to one of Process B's virtual addresses, the **[[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit (MMU)]]** would translate it through Process A's page table and land on Process A's own frame, never Process B's.

This is the concrete mechanism behind the memory protection guarantee described at a higher level in **[[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]**: the MMU itself is what performs each lookup, but it is the *existence of separate, per-process page tables* — switched by the OS on every context switch — that turns "the MMU checks permissions" into "isolation is structurally guaranteed." This is also why a context switch between processes must reload the MMU's notion of which page table is active (typically by reloading a base-address register such as CR3 on x86), and why the **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]** must be flushed or tagged on a context switch — its cached translations are only valid for the page table that was active when they were recorded.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Per-process page table | Address space / process address space |
| Page frame (PF) | Physical frame / page frame |

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
