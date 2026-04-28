# Windows Paging

Windows uses a demand-paging virtual memory system with a "working set" model.

## Characteristics
- **Working Set**: The set of pages in physical memory currently assigned to a process. 
- **Page Replacement**: Windows uses a global page replacement strategy but monitors per-process working sets to decide when to trim memory.
- **Paging File**: Typically `pagefile.sys`, used as the backing store for modified pages that are not backed by other files.

## Related
- [[Windows Kernel Heap]]
- [[CSE451/Memory Management/Memory Models/Paging|Paging]]
- [[Virtual Memory]]
