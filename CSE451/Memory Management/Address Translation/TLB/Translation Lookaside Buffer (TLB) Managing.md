# Managing TLBs
Address translations are handled by the TLB >99% of the time. On a miss, the translation is fetched and a cached entry is evicted to make room.

## who manages misses

| | hardware-managed | software-managed |
|--|-----------------|-----------------|
| who handles miss | [[Memory Management Unit]] directly | OS trap handler |
| page table format | must be hardware-defined | OS chooses freely |
| speed | automatic | 20–1000 cycles typically |
| ISA support | — | CPU provides TLB manipulation instructions |

## consistency
The OS must keep the TLB and page tables in sync:
- when protection bits in a PTE change, the OS must invalidate that TLB entry if it is currently cached

## context switches
- each process has its own page tables
- on a switch, the TLB must be flushed — a significant cost of process context switches
- **mitigation**: tag entries with an ASID (address space ID + virtual address) to let multiple processes coexist without flushing

## replacement
When a miss occurs and a new PTE is loaded, an existing entry must be evicted. Choosing which entry to evict is the **TLB replacement policy** — determined by hardware.
