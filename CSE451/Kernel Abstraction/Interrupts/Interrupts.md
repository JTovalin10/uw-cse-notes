# what is it
signals that pause the CPU to handle urgent events, which are ideally hidden from the user

Note: they can be temporarily deferred by the kernel which is crucial for implementing mutual exclusion (mutex)

This fixes [[polling]]

# Components
- [[Source of Interrupts]]
- [[How Device Interrupts Work]]
- [[Safe Interrupts]]
- [[Interrupt Types Summary]]
- [[Interrupt Timeout]]

# Interrupt Stack
- its a per-processor stack located in kernel memory
	- usually a process/thread has both: kernel and user stack
![[Screenshot 2026-01-05 at 4.21.13 PM.png]]

# Related
- [[Interrupt Handler]]
- [[Interrupt Vector]]
- [[Interrupt Masking]]
- [[Traps]]
- [[CSE351/System Programming/Exceptions]]
