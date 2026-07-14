# CSE451: Memory Management Information

**Memory Management Information** is the details the OS keeps about the memory assigned to each process, so that it can correctly translate addresses and enforce protection between processes.

This information is part of a process's larger [[Operating Systems/Virtualization/Memory/Memory management|Memory Management]] bookkeeping, and typically includes:

- **Page tables**: The per-process data structure mapping the process's virtual pages to physical frames. See **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]** for the full structure.
- **Segment tables**: Analogous mapping structures used in segmentation-based memory schemes, tracking the base and length of each logical segment (e.g., code, stack, heap) of a process.
- **Base and limit registers**: Hardware registers used in simpler protection schemes, storing the start address and size of a process's allowed memory region so the hardware can check every access falls within bounds.

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Accounting Information|Accounting Information]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Operating Systems/Virtualization/Memory/Concepts/Address Space Contents|Address Space Contents]]
