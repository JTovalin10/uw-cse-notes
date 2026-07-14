# CSE451: Segment and Paging

We can combine **[[Operating Systems/Virtualization/Memory/Memory Models/Segmentation|Segmentation]]** and **[[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging]]** to get the logical structuring benefits of segments together with the fragmentation-free allocation benefits of pages.

## Mechanism
- Use segments to manage logical units.
	- Segments vary in size but are typically large (e.g. an entire code segment or heap segment).
- Use pages to partition each segment into fixed-size chunks.
	- Each segment has its own page table — there is a page table per segment, rather than one page table for the whole address space.
	- Memory allocation becomes easy once again: no contiguous allocation is required, and there is no external fragmentation, because every unit being allocated (a page) is the same fixed size.

![[Pasted image 20260213135817.png]]
![[Pasted image 20260213135837.png]]

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Segment and Paging | Segmented paging / two-level (segment + page) address translation |

## Related
- [[Operating Systems/Virtualization/Memory/Memory Models/Segmentation|Segmentation]] — supplies the logical-unit structure (segment table, base and bounds per segment)
- [[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging]] — supplies the fixed-size-chunk allocation scheme applied within each segment
- [[Operating Systems/Virtualization/Memory/Memory Models/Page Table Entries|Page Table Entries]] — the entries populating each segment's page table
