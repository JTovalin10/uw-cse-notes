- Often part of a device driver
- **Non-blocking**, run to completion
	- turn off all interrupts and work from start to end
		- think concurrency in action where all expensive actions should be done without a mutex (creating shared or unique ptrs) and then acquiring a mutex lock
	- Minimum necessary to allow device to take next interrupt
	- Any waiting must be limited duration
	- wake up other thread to do any real work
		- Linux: semaphore
	- rest of device driver runs as a kernel thread

# End of interrupt handler
- handler restores saved registers
- atomically return to interrupted process/thread
	- restore program counter, stack, status word/condition codes
	- switch to user mode