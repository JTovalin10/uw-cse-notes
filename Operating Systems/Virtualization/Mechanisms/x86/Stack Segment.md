# CSE451: Stack Segment

The **Stack Segment (SS)** register tells the CPU which segment the stack is in — for example, whether it is in the code, data, or stack segment.

Note: modern x86-64 segments are mostly ignored but kept for backwards compatibility.

## Related
- [[ESP]] — the stack pointer register that tracks the current top of the stack
- [[Kernel Stack]] — the per-process kernel-mode stack
- [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception]] — how the stack segment is saved during exception handling
- [[Code Segment]] — the analogous register for the code segment
- [[Global Descriptor Table]] — the table the stack segment selector indexes into

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Stack Segment (SS) register | Stack segment selector register (x86 architecture manual terminology) |