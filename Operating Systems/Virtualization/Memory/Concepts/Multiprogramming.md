# CSE451: Multiprogramming

**Multiprogramming** is the practice of keeping multiple [[Operating Systems/Virtualization/Processes/Process|Process]]es in memory at once, in order to overlap I/O and computation between processes, easing the task of the application programmer — while one process is blocked waiting on I/O, the CPU can be given to another resident process instead of sitting idle.

Supporting multiple processes resident in memory simultaneously requires the memory management system to satisfy three requirements:

1. **Protection**: Restricts which addresses processes can use so they don't stomp on each other. This is enforced through per-process **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Tables]]**, where each **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry (PTE)]]** carries protection bits and a valid bit, so a process attempting to access memory outside its own mappings (or violating a page's permissions) is stopped by the hardware rather than being allowed to corrupt another process's memory.
2. **Fast translation**: Memory lookups must be fast in spite of the protection scheme, since every single memory access a process makes has to be translated from a virtual to a physical address. This is why the **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]** exists — it caches recent virtual-to-physical translations so the CPU doesn't have to walk the full page table structure in RAM on every access, which would otherwise be prohibitively slow.
3. **Fast context switching**: When switching between jobs, updating memory hardware must be quick. Since each process has its own page table and thus its own virtual address mappings, the hardware's cached translations from the previous process are no longer valid for the next one — this is why mechanisms like TLB flushing (invalidating stale entries) or tagging entries with an **Address Space Identifier (ASID)** exist, so that a context switch doesn't have to pay the full cost of re-walking the page table for every memory access immediately afterward.

## Related
- [[Operating Systems/Virtualization/Processes/Process|Process]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
- [[Operating Systems/Virtualization/Memory/Concepts/Swapping|Swapping]]
- [[Operating Systems/Virtualization/Memory/Concepts/Embedded Systems|Embedded Systems]]
