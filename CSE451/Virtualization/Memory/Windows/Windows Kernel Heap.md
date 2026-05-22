# CSE451: Windows Kernel Heap

The **Windows Kernel Heap** uses several different heap managers for dynamic memory allocation.

## Types of Heaps
- **Pools**: The primary kernel-mode heap managers.
  - **Non-paged pool**: Guaranteed to reside in physical memory at all times (used for ISRs and high-priority code).
  - **Paged pool**: Can be swapped to disk.
- **Segment Heap**: A modern heap manager (introduced in Windows 10) designed for better efficiency and security.

## Related
- [[CSE451/Virtualization/Memory/Windows/Windows Paging|Windows Paging]]
- [[Memory Allocation|Memory Allocation (351)]]
- [[CSE451/Virtualization/Memory/Memory management|Memory Management (451)]]
