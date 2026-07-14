# CSE451: Address Translation

To go from virtual to physical addresses, the OS and hardware add a level of indirection: the **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]**, which translates a virtual page to a physical frame.

## Translating Virtual Addresses
- A virtual address has two parts: the **virtual page number (VPN)** and the **offset**.
- The VPN is an index into a page table.
- The page table entry contains the **page frame number (PFN)**.
- The physical address is `PFN::offset` (the two parts concatenated together).

## Page Tables
- Managed by the OS.
- One page table entry (PTE) per page in the virtual address space — one PTE per VPN.
- Maps the virtual page number (VPN) to the page frame number (PFN); the VPN is simply an index into the page table.

![[Screenshot 2026-02-11 at 12.15.47 PM.png]]
![[Pasted image 20260213132600.png]]
![[Pasted image 20260213132621.png]]

## How the Pieces Fit Together
This translation is carried out by the **[[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit (MMU)]]**, the hardware component that performs the lookup, enforces protection, and manages caching. To avoid the cost of a full page table walk in RAM on every memory access, the MMU checks the **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]** first, a small, fast cache of recent translations.

For the detailed mechanics of each piece, see:
- **[[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]** — the hardware unit and its three core functions (translation, protection, cache control).
- **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]** — the data structure the MMU consults, including entry anatomy, storage, and multi-level translation steps.
- **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]** — the hardware cache that makes translation fast.

## Related
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]
- [[Operating Systems/Virtualization/Memory/What is a Page|What is a Page]]
