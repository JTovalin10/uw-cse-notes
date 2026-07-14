# CSE451: Swapping

**Swapping** saves a program's entire state to disk (including its memory image), which allows another program to run in its place, and then the first program can later be swapped back in and restart right where it left off.

## Core Concept

Swapping is a coarse-grained technique for supporting **[[Operating Systems/Virtualization/Memory/Concepts/Multiprogramming|Multiprogramming]]**: when physical memory cannot hold every process that wants to run, the OS moves an entire process's memory image out to disk to free up RAM for another process. This differs from more fine-grained mechanisms like **[[Operating Systems/Virtualization/Memory/Page Fault Lifecycle|paging]]**, which move individual pages rather than a whole process at once.

## Mechanism

1. **Selection**: The OS chooses a resident process (usually one that is blocked or has been idle) to swap out.
2. **Write to Disk**: The entire memory image of the process — its **[[Operating Systems/Virtualization/Memory/Concepts/Address Space Contents|address space contents]]** (stack, heap, static data, code) — is written to a reserved area of disk, the swap space.
3. **Reclaim RAM**: The physical memory frames previously used by the swapped-out process are freed and made available to other processes.
4. **Swap Back In**: When the OS later decides to run the swapped-out process again, it reads the entire memory image back from disk into (possibly different) physical frames.
5. **Resume**: Because the entire state — including the saved [[Operating Systems/Virtualization/Processes/Process|Process]]'s registers and memory image — was preserved, the process resumes exactly where it was interrupted, with no visible discontinuity to the program itself.

## Trade-offs

- **Coarse granularity**: Swapping moves an entire process's memory image at once, which can mean writing and reading far more data than is actually needed if only a small part of the process is used before it's swapped out again — this is one motivation for finer-grained **[[Operating Systems/Virtualization/Memory/Page Fault Lifecycle|page-level]]** approaches instead of whole-process swapping.
- **Disk I/O cost**: Because disk access is orders of magnitude slower than RAM, both swapping a process out and swapping it back in are expensive operations, so the OS must be selective about which processes it swaps.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Swapping | Process swapping / swap space paging |
| Swap Space | Pagefile (Windows) / swap partition or swap file (Linux) |

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Multiprogramming|Multiprogramming]]
- [[Operating Systems/Virtualization/Memory/Page Fault Lifecycle|Page Fault Lifecycle]]
- [[Operating Systems/Virtualization/Memory/Memory management|OS Memory Management]]
- [[Operating Systems/Virtualization/Processes/Memory/swap space|Swap Space]]
- [[Operating Systems/Virtualization/Memory/Virtual Memory|Virtual Memory]]
