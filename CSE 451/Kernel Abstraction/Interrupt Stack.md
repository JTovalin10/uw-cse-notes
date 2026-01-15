- Per-processor, located in kernel (not user) memory 
	-  Usually a process/thread has both: kernel and user stack 
- Why can’t the interrupt handler run on the stack of the interrupted user process?
	- the user stack may be corrupted
![[Screenshot 2026-01-07 at 12.01.34 PM.png]]
