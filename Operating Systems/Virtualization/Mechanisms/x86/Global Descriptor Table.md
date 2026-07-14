# CSE451: Global Descriptor Table

The **Global Descriptor Table (GDT)** is a data structure held in memory that defines the memory segments available on the system and their access permissions for the CPU. It is the primary segment descriptor table used by the [[Code Segment]] and [[Stack Segment]] registers when they resolve a segment selector.

## What It Contains
The GDT is an array of **segment descriptors**, where each descriptor defines:
- **Base address** — where the segment starts in physical memory
- **Limit** — how large the segment is
- **[[Privilege Level]]** — the ring required to access the segment
- **Flags** — additional attributes such as granularity (byte- vs. page-granular limits) and whether the segment operates in 32-bit or 64-bit mode

## Where It Lives
- The GDT itself resides in kernel memory (RAM), protected from user-mode modification.
- The CPU has a dedicated register, the **GDTR** (Global Descriptor Table Register), that points to it.
- The GDTR contains the base address of the GDT plus its size, so the CPU knows both where the table is and how far it extends.

## Related
- [[Local Descriptor Table]] — the per-process alternative to the GDT
- [[Code Segment]] — indexes into the GDT (or LDT) to resolve the current code segment
- [[Stack Segment]] — indexes into the GDT (or LDT) to resolve the current stack segment
- [[Privilege Level]] — the ring information stored in each segment descriptor
- [[Privileged Instructions]] — loading the GDTR (`LGDT`) is a privileged instruction restricted to kernel mode

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Global Descriptor Table (GDT) | Global Descriptor Table (standard x86 architecture term) |
| GDTR | GDT Register (standard x86 architecture term) |