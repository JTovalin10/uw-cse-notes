# CSE451: Page Table Storage

## Where the Page Table Lives
The page table itself is stored in memory (RAM), not in some separate, faster piece of hardware. This is a deliberate consequence of its size: a page table needs one entry per virtual page (see **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Purpose|Page Table Purpose]]**), which for a large address space is far too much data to keep permanently in on-chip hardware.

## The Performance Problem This Creates
Storing the page table in RAM creates a performance problem. To fetch one piece of data, the CPU actually has to perform two memory lookups instead of one:
1. One lookup to read the page table, in order to find where the requested data physically lives.
2. One lookup to read the actual data itself, now that its physical address is known.

Since a RAM access is already relatively slow compared to CPU speeds, doubling the number of RAM accesses on every single memory reference would roughly halve effective performance — an unacceptable cost for something as fundamental as reading a variable.

## Solution: The TLB
To fix this slowness, the CPU uses a fast hardware cache called the **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]**, which remembers recent translations. Because programs exhibit locality (they tend to reuse the same pages repeatedly in a short window of time), a small TLB can satisfy the vast majority of translations without ever touching the in-RAM page table, reducing the "two lookups per access" cost back down to effectively one lookup on the common path.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Page table (in RAM) | In-memory page table |
| TLB | Translation Lookaside Buffer (standard term) |

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Translation Steps|Page Table Translation Steps]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]
