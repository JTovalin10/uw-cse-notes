A unique number (like SSN) that distinguishes this process from all others
- the name for a process is called a process ID (PID)
	- an integer
- the PID namespace is global to the system
	- only one process at a time has a particular PID
- Operations that create processes return a PID
	- fork
- operations on processes take PIDs as an argument
	- kill, wait, nice