# Per-Process vs Global Page Tables
each single process has its own page table

This is how memory protection works
- Proc A page table points to PF 50
- Proc B page table points to PF 90
- there is no entry in Proc A table that points to frame 90. Therefore, it is physically impossible for Proc A to touch Proc B memory
