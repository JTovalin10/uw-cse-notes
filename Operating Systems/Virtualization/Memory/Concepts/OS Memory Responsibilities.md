# CSE451: OS Memory Responsibilities

The Operating System has several core responsibilities when managing memory on behalf of running processes:

- **Allocate memory space for programs**: The OS must find and assign physical memory to a process before it can run.
- **Deallocate space when needed by the rest of the system**: When a process no longer needs memory (e.g., it exits, or explicitly frees a region), the OS reclaims that memory so it can be reused by other processes.
- **Maintain mapping from physical to virtual memory**: The OS is responsible for setting up and maintaining the translation between the addresses a process uses (virtual) and where that data actually lives in RAM (physical), through the **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]**.
- **Decide how much memory to allocate to each process**: This is a policy decision — the OS must balance giving each process enough memory to run efficiently against the total memory available across all resident processes.
- **Decide when to remove a process from memory**: Also a policy decision, closely tied to [[Operating Systems/Virtualization/Memory/Concepts/Swapping|Swapping]] — the OS must choose which processes to evict from memory when space is needed for others.

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Operating Systems/Virtualization/Memory/Concepts/Swapping|Swapping]]
- [[Operating Systems/Virtualization/Memory/Concepts/Multiprogramming|Multiprogramming]]
- [[Operating Systems/Virtualization/Memory/Memory management|OS Memory Management]]
