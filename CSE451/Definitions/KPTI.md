# KPTI (Kernel Page Table Isolation)

**KPTI (Kernel Page Table Isolation)** is a security mitigation for the **Meltdown** vulnerability.

It works by separating user-space and kernel-space page tables to prevent user-mode processes from using speculative execution to read privileged kernel memory. While it significantly improves security, it can incur a performance penalty due to more frequent TLB flushes during context switches between user and kernel mode.
