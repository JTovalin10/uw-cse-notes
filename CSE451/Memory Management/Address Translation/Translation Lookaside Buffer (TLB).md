# Translation Lookaside Buffer (TLB)
- a hardware cache of recent virtual-to-physical address translations
- part of the chip's memory management unit (MMU)
- solves the performance problem of [[CSE451/Kernel Abstraction/Memory/Virtual Addresses]]: without a TLB, every memory access requires walking the page table (extra memory accesses per instruction)
- typically holds 32-256 entries

## see also
- [[Translation Lookaside Buffer (TLB) In Hardware]]
- [[Translation Lookaside Buffer (TLB) Exploits Locality]]
- [[Translation Lookaside Buffer (TLB) How It Works]]
- [[Translation Lookaside Buffer (TLB) Entry Contents]]
- [[Translation Lookaside Buffer (TLB) Entry Layout]]
- [[Translation Lookaside Buffer (TLB) Miss Handling]]
- [[Translation Lookaside Buffer (TLB) Context Switches]]
- [[Translation Lookaside Buffer (TLB) Replacement Policies]]
- [[Translation Lookaside Buffer (TLB) Why It Matters]]
- [[Translation Lookaside Buffer (TLB) Managing]]
- [[Translation Lookaside Buffer (TLB) What This Enhanced]]
