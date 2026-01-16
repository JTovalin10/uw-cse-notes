- The OS maintains a collection of queues that represent the state of all [[Process]]es in the system
	- typically one queue for each state
		- [[Process State]]
	- each [[Process]] is queued onto a state queue according to the current state of the process it represents
	- as a process changes state, its proc is unlinked from one queue, and linked onto another
- procs are moved between queues, which are represented as linked lists
![[Pasted image 20260116004349.png]]
