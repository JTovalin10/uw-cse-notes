# CSE451: Swap Space

**Swap Space** is a reserved area on disk for moving pages of memory back and forth between RAM and disk. This allows the OS to support the illusion of a large **[[Operating Systems/Virtualization/Memory/Virtual Memory|Virtual Memory]]** for multiple concurrently running [[Process|Processes]], even when the total memory demand of all processes exceeds the physical capacity of RAM.

## How It Works

When RAM is full, the OS must make room for new data. It does this through **swapping**, also called **paging out**:

1. **Selection**: The OS picks a victim page currently resident in RAM, typically using an LRU (Least Recently Used) policy, to decide which page is least likely to be needed again soon.
2. **Eviction**: The OS copies that victim page's data out to the swap space on disk.
3. **Updating**: The OS updates the page table entry for that process, marking the page as "not present" and recording its new location on disk instead of a physical frame number.
4. **Retrieval**: If the program later tries to access that evicted data, a **[[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]** [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception|Exception]] occurs, since the hardware finds the "not present" bit set. The OS then handles the fault by "swapping in" the page — reading it back from disk into a free physical frame in RAM — and updates the page table to mark it present again.

## Related
- [[Optimizing Fork|Optimizing Fork]] — allocating swap space for a naively-implemented fork is one reason a full address-space copy is expensive
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]
- [[Operating Systems/Virtualization/Memory/Virtual Memory|Virtual Memory]]
- [[Operating Systems/Virtualization/Memory/Memory management|Memory Management]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Swap Space | Swap partition / pagefile |
| Swapping out (paging out) | Page eviction |
| Swapping in (paging in) | Page-in / demand paging |
