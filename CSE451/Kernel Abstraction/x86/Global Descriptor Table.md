# what is it
it is a data structure in memory that defines memory segments and their access permissions for the CPU

# What it contains
an array of segment descriptors where each defines:
- base address
- limit
- [[Privilege Level]]
- flags
	- granularity, 32-bit vs 64-bit mode, etc

# Where it lives
- in kernel memory (RAM)
- CPU has GDTR register that points to it
- contains: base address of GDT + size