# what is it
signals that pause the CPU to handle urgent events which are ideally hidden to the user

Note: they can be temporarily deferred by the kernel which is curcial for implementing mutual exclusion (mutex)

This fixes [[polling]]
# Source of Interrupts
- timer: periodic interrupts for scheduling
- I/O devices: keyboard, disk, network card signaling completion
- software: sys calls (int 0x80, syscall)
- exceptions: page fault, divide by zero, [[General Protection Fault (GPF)]]

# How do Device Interrupts work?
- where does the CPU run after an interrupt
	- kernel
- what stack does it use
	- kernel stack
- is the work the PCU had been doing before the interrupt lost forever
	- no
- if not, how does the cpu know how to resume that work
	- ...
# How do we do interrupts safely
- [[Interrupt Vector]]
- [[Atomic Transfer of Control]]
- [[Transparent Restartable Execution]]

# Interrupt Stack
- its a per-processor stack located in kernel memory
	- usually a process/thread has both: kernel and user stack
![[Screenshot 2026-01-05 at 4.21.13 PM.png]]

# What happens if interrupts stay too long
- depends how os is set up
- the data held by the device might get lost or stay there if the os takes too long