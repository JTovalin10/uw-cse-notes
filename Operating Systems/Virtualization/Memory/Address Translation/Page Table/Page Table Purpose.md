# CSE451: Page Table Purpose

## The Core Illusion
Every process (application) believes it has a huge chunk of contiguous memory all to itself, usually starting at address 0. This is the **[[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]** abstraction, and it is only possible because of the page table:
- **Virtual memory**: the fake, perfect view of memory the process sees — a single flat address space it believes it owns exclusively.
- **Physical memory**: the messy, scattered reality of where data actually lives in RAM hardware, shared and fragmented across every running process.

## Why the Illusion Requires a Translation Layer
Because a process's virtual view and the physical reality of RAM disagree with each other, something has to reconcile the two on every single memory access. The OS chops memory into fixed-size blocks called **[[Operating Systems/Virtualization/Memory/What is a Page|Pages]]**, and maintains a mapping between the process's view of those blocks and where they actually sit in RAM:
- **Virtual page**: a block in the process's view of its own address space.
- **Physical frame**: the corresponding block in actual RAM where that virtual page's data is stored.
- The **page table** is the dictionary that records this mapping — for example, saying *virtual page 1 maps to physical frame 10*.

Without this dictionary, a process's virtual addresses would be meaningless to the actual hardware, since the CPU and memory bus only understand physical addresses. The page table is what the **[[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit (MMU)]]** consults on every access to bridge that gap — see **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Translation Steps|Page Table Translation Steps]]** for exactly how that lookup is performed, and **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Per-Process Page Tables|Per-Process Page Tables]]** for how this same mechanism is reused to keep processes isolated from one another.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Page table | Page table (standard term) |
| Virtual page | Virtual page / page |
| Physical frame | Page frame / physical frame |

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]
- [[Operating Systems/Virtualization/Memory/What is a Page|What is a Page]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]
