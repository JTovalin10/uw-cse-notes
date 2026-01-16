# what is it
it is a data structure in memor that defines memory segments and their access permissions for the CPU

# What is contains
an array of segment descriptors where each define:
- base address
- limit
- [[Privilege Level]]
- flags
	- granularity, 32-bit vs 64-bit mode, etc

# Where it lives
- in kernel memory (RAM)
- CPU has GDTR register that points to it
- contains: base address of GDT + size