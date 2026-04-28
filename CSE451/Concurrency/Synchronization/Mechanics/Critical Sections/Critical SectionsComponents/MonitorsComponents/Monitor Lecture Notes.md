# Lecture
#define monitors - a programming language construct that supports controlled access to shared data
- synchronization code is added by the compiler
A monitor is (essentially) a class in which every method automatically acquires a lock on entry and releases it on exit
- it combines:
	- **shared data** structures (object)
	- **procedures** that operate on the shared data
	- **synchronization** between concurrent threads that invoke those procedures
- Data can only be accessed from within the monitor using the procedures
	- protects the data from unstructured access
	- prevents ambiguity about what the synchronization variables protect
- addresses the key usability issues that arise with [[Semaphores]]
![[Screenshot 2026-01-20 at 3.57.31 PM.png]]

![[Monitor Facilities]]
