# OS bookkeeping
- the OS maintains a data structure to keep track of a process's state
	- [[Process Control Block]] or process descriptor
	- identified by the [[Process ID]]
- The OS keeps all of a process's execution state in (or linked from) the proc when the process isn't running
	- [[Registers]]
	- when a process is unscheduled, the execution state is transferred out of the hardware register into the proc
	- (when a process is running, its state is spread between the proc and the CPU)