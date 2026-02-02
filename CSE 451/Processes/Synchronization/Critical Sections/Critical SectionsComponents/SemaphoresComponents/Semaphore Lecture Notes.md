# Lecture Notes
#define Semaphores - a synchronization primitive where:
a variable that is manipulated through two operations **P** and **V**
- P (sem, wait)
	- block until sem > 0, then subtract 1 from sem and proceed
- V (sem, signal)
	- add 1 to sem
- operations are done atomically
