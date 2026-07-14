# CSE451: Page Table Translation Steps (Multi-level)

## Overview
When a process tries to access a variable, the CPU must translate the **Virtual Address (VA)** into a **Physical Address (PA)**. This section walks through that process concretely for a standard x86 32-bit system with 4KB pages, which uses a two-level (multi-level) page table rather than a single flat table.

## The Translation Walkthrough
1. **Split the VA**: The 32-bit address is split into three parts — see **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Virtual Address Parts|Virtual Address Parts]]** for the full bit-width breakdown: **PDI** (10 bits), **PTI** (10 bits), and **Offset** (12 bits).
2. **Page Directory Lookup**: The CPU uses the **PDI** as an index into the **Page Directory**, whose base physical address is stored in the **CR3** register (on x86; this register is reloaded on every context switch, which is part of why per-process page tables work — see **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Per-Process Page Tables|Per-Process Page Tables]]**).
3. **Get Page Table Address**: The entry in the Page Directory (the PDE) provides the physical address of the second-level **Page Table**.
4. **Page Table Lookup**: The CPU uses the **PTI** as an index into that Page Table.
5. **Get Frame Number**: The entry in the Page Table (the PTE — see **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]]** for its full contents) provides the **Physical Frame Number (PFN)**.
6. **Final PA Calculation**: The CPU concatenates the **PFN** with the original **Offset** from the VA to form the final Physical Address.

This is exactly the walk that the **[[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit (MMU)]]** performs on a **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|TLB]] miss** — see **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Storage|Page Table Storage]]** for why this two-step, in-RAM lookup is slow enough that the MMU tries hard to avoid it via the TLB.

## Why Multi-Level Instead of a Single Flat Table
Splitting the address into a directory index and a table index (rather than one giant flat index) exists to avoid wasting memory on unused regions of the address space. A single-level table sized for the full 32-bit space would need one entry for every possible page whether or not the process actually uses that region; a two-level table only needs to allocate second-level Page Tables for the portions of the address space the process actually occupies, leaving the Page Directory entries for unused regions empty.

## Formal Definition
Given a 32-bit virtual address $VA$ split as $VA = \text{PDI} \,\|\, \text{PTI} \,\|\, \text{Offset}$ (10, 10, 12 bits respectively), and letting $\text{CR3}$ denote the base physical address of the current process's Page Directory:

$$
\begin{aligned}
\text{PDE} &= \text{PageDirectory}[\text{CR3} + \text{PDI}] \\
\text{PTE} &= \text{PageTable}[\text{PDE.base} + \text{PTI}] \\
PA &= \text{PTE.PFN} \,\|\, \text{Offset}
\end{aligned}
$$

where $\|$ denotes bit concatenation, subject to the validity and protection checks on the PDE and PTE described in **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]]** (a fault is raised instead of returning $PA$ if either entry is invalid or the access violates its protection bits).

## Simplified Explanation
Think of it like a two-level phone book lookup: the top ten bits of the address (PDI) tell you which *chapter* of the phone book to open (the Page Directory entry gives you the location of that chapter, which is itself a smaller Page Table), and the next ten bits (PTI) tell you which *entry within that chapter* to read (the PTE gives you the actual physical frame). The last twelve bits (the offset) aren't looked up at all — they just tell you exactly where within that frame the byte you want sits, since a frame is 4KB and 12 bits can address every byte within it.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| PDI (Page Directory Index) | Page directory index / first-level index |
| PTI (Page Table Index) | Page table index / second-level index |
| CR3 | Page table base register (x86-specific name) |
| Multi-level page table | Hierarchical / multi-level paging |

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Virtual Address Parts|Virtual Address Parts]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Storage|Page Table Storage]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
