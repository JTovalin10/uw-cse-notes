# CSE451: Code Segment

The **Code Segment (CS)** register is a 16-bit x86 register that holds a **segment selector** — a value that tells the CPU which memory segment the currently executing code belongs to.

## Core Purpose
The segment selector held in CS is an index into either the [[Global Descriptor Table]] or the [[Local Descriptor Table]]. That table entry (the segment descriptor) describes where the code segment lives in memory and what privileges apply to it. Flat memory models have made this indirection largely obsolete for defining memory layout, but the CS register is retained for backwards compatibility and still serves one critical purpose: it tells the CPU what [[Privilege Level]] the currently executing code is running at (encoded in the low 2 bits of the selector, the Requested Privilege Level).

## In Old Segmented Memory
In the original segmented memory model, the code segment descriptor defined where executable code could legally be fetched from:
- **Base address**: where the code segment starts in physical memory
- **Limit**: how large the code segment is — the CPU faults if the instruction pointer strays outside `[base, base + limit]`

## Modern (Flat Memory) Reality
Today, nearly all systems use a flat memory model with the code segment's base set to 0 and its limit set to cover the entire address space, effectively disabling segment-based bounds checking. The CS register survives purely to carry the current privilege level and to support legacy instructions.

## Related
- [[Global Descriptor Table]] — the table CS indexes into to find the segment descriptor
- [[Local Descriptor Table]] — the per-process alternative table
- [[Privilege Level]] — the ring encoded in the low bits of the CS selector
- [[Stack Segment]] — the analogous register for the stack segment
- [[Kernel Stack]] — CS is saved on the kernel stack during a trap/interrupt/exception

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Code Segment (CS) register | Code segment selector register (x86 architecture manual terminology) |
| Segment Selector | Segment selector / segment index |