# CSE451: Local Descriptor Table

The **Local Descriptor Table (LDT)** is structured like the [[Global Descriptor Table]], but it is defined **per-process/thread** instead of being shared globally across the whole system.

## What It Was Designed For
- Let each process define its own custom set of segments, separate from the segments used by other processes
- Useful in old segmented memory models where processes wanted isolated memory regions with their own base addresses and limits
- Could define process-specific code/data segments distinct from the ones described in the GDT

## Modern Reality
- **Rarely used** in modern operating systems
- Linux does not use the LDT by default
- The flat memory model makes per-process segments unnecessary, since address space isolation is instead achieved through paging (see [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses]])
- Most systems just use the GDT for everything, leaving the LDT mechanism present in hardware but effectively unused

## Related
- [[Global Descriptor Table]] — the global counterpart that has replaced the LDT in practice
- [[Code Segment]] — can index into either the GDT or the LDT to resolve a segment
- [[Stack Segment]] — likewise resolves against either table
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses]] — the modern paging-based mechanism that replaced per-process segmentation

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Local Descriptor Table (LDT) | Local Descriptor Table (standard x86 architecture term) |