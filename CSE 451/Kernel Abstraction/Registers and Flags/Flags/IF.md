# What is it
a single bit in the x86 processors EFLAGS register that controls whether the CPU responds to maskable hardware interrupts

# States
- IF = 1: interrupt enabled
	- CPU will respond to interrupt requests from devices
- IF = 0: interrupt disabled
	- CPU ignores maskable interrupt requests