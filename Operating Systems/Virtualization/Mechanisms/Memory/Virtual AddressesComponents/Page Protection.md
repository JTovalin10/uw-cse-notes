# CSE451: Page Protection

**Page protection** is one of the ways [[Virtual Addresses]] improve on [[Base and Bounds]]: each page table entry carries its own permission bits, providing fine-grained protection at the individual page level rather than a single set of permissions for an entire process's memory region.

Each page table entry includes:
- **Valid bit** — is this page currently allocated to the process at all?
- **Read/Write/Execute permissions** — what operations are permitted on this specific page (e.g., a code page can be marked read+execute but not write, preventing self-modifying code exploits; a data page can be marked read+write but not execute, preventing code injection attacks)
- **Present bit** — is the page currently resident in physical RAM, or has it been swapped out to disk? If the present bit is clear, accessing the page triggers a page fault so the OS can bring it back into memory

This is a major improvement over [[Base and Bounds]], which had no per-region permissions at all — a base and bounds process either could or could not access its entire contiguous region, with no way to mark part of it read-only or non-executable.

## Related
- [[Virtual Addresses]] — the parent mechanism enabling page-level protection
- [[Base and Bounds]] — the earlier mechanism with only coarse, all-or-nothing region permissions
- [[Demand Paging]] — the present bit is also used to implement demand paging
- [[General Protection Fault (GPF)]] — the exception raised when a permission check fails

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Page Protection | Page-level access control / page table permission bits |
| Present Bit | Present bit / valid bit (paging terminology) |
