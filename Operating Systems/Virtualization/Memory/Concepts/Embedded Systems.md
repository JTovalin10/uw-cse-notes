# CSE451: Embedded Systems

**Embedded Systems**, in the context of early memory management history, only run one program at a time, which greatly simplifies memory management compared to systems supporting **[[Operating Systems/Virtualization/Memory/Concepts/Multiprogramming|Multiprogramming]]**.

## Historical Context: One-Job-at-a-Time Batch Processing

Before multiprogramming, systems used one-job-at-a-time batch processing:
- Programs used **physical addresses** directly — there was no translation layer, since only one program occupied memory at any given time and it could be given the entire physical address space.
- The OS loads a job (perhaps using a **relocating loader** to "offset" branch addresses so the program can run correctly no matter where in physical memory it happens to be loaded), runs it to completion, and then unloads it before loading the next job.
- If the program wouldn't fit into memory, the solution was **manual overlays**: the programmer had to explicitly divide the program into pieces and manage swapping those pieces in and out of memory themselves, since the OS provided no automatic mechanism for this.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Embedded Systems (single-program) | Single-tasking / bare-metal systems |
| Manual overlays | Overlay programming |
| Relocating loader | Relocatable loader |

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Multiprogramming|Multiprogramming]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]
- [[Operating Systems/Virtualization/Memory/Memory management|OS Memory Management]]
