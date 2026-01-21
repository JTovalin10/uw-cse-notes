## What is facilities
- automatic mutual exclusion
	- only one thread can be executing inside at any time
		- thus, syn is implicity associated with the monitor - it comes for free
	- if a second thread tries to executre a monitor procedure, it blocks until the first has left the monitor
		- more restrictive than semaphores
		- but easier to use (most of the time)
