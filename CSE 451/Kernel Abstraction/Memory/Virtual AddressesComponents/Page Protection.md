# Page Protection
Each page table entry includes:
- Valid bit (is this page allocated?)
- Read/Write/Execute permissions
- Present bit (in RAM or swapped to disk?)

This provides fine-grained protection at the page level, unlike [[Base and Bounds]] which had no per-region permissions.
