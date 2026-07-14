# CSE451: Page Table

A **page table** is a data structure responsible for translating **virtual memory** addresses into **physical memory** addresses. It is the mapping consulted by the **[[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit (MMU)]]** on every memory access.

## Components
- **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Purpose|Page Table Purpose]]** — why a translation layer is needed between a process's virtual view of memory and physical RAM.
- **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Virtual Address Parts|Virtual Address Parts]]** — how a 32-bit virtual address is split into PDI, PTI, and offset fields.
- **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Translation Steps|Page Table Translation Steps]]** — the step-by-step multi-level lookup that turns a virtual address into a physical address.
- **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Storage|Page Table Storage]]** — why the page table lives in RAM, the performance cost this creates, and how the TLB solves it.
- **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]]** — the status bits (valid, protection, present, dirty, accessed) inside each entry.
- **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Per-Process Page Tables|Per-Process Page Tables]]** — how giving each process its own page table enforces memory protection.
- **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Structure Diagram|Page Table Structure Diagram]]** — a visual layout of the page table array and the translation path through it.

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Address Translation|Address Translation]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]
