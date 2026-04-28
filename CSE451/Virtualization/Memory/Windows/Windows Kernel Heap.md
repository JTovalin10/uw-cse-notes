# Windows Kernel Heap

The Windows kernel uses several different heap managers for dynamic memory allocation.

## Types of Heaps
- **Pools**: The primary kernel-mode heap managers.
  - **Non-paged pool**: Guaranteed to reside in physical memory at all times (used for ISRs and high-priority code).
  - **Paged pool**: Can be swapped to disk.
- **Segment Heap**: A modern heap manager (introduced in Windows 10) designed for better efficiency and security.

## Related
- [[Windows Paging]]
- [[CSE451/Memory Management/Memory Allocation|Memory Allocation]]
