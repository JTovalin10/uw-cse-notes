# What is it
sequences of instructions that may get incorrect results if executed simultaneously
(also called [[Race Condition]] in reference when the result depends on the timing)

# How do we solve this
Forcing [[Mutual Exclusion]] between two critical section executions is sufficient to ensure correct execution - guarantees ordering
## Requirements
- [[Mutual Exclusion]]
	- at most one thread is in the critical section
- progress
	- if [[Thread]] T is outside the critical section, then T cannot prevent thread S from entering the critical section
- bounding waiting (no starvation)
	- if thread T is waiting on the critical section, then T will eventually enter the critical section
		- assumes threads eventually leave critical sections
- performance
	- the overhead of entering and exiting the critical section is small with respect to the work being done within it
## Mechanisms
- [[Spinlock]]
	- primitive, minimal semantics; used to build others
- [[Semaphores]] (and non-spinning locks)
	- basic, easy to get the hang of, somewhat hard to program with
- [[Monitors]]
	- higher level, requires language support implicit operations
	- easier to program with
- [[Messages]]
	- simple model of communication and synchronization based on (atomic) transfer of data across a channel
	- direct application to distributed systems
- Disabling interrupts
	- PROBLEMS:
		- only avaliable to kernel
			- cant allow user-lvel to disbale interrupts
		- insufficient on a multiprocessor
			- each processor has its own interrupt mechanism
		- long periods with interrupts disabled can wreak havoc with devices
# How do they arise
- common patterns
	- read-modify-write of
	- a shared value (variable)
	- in code that can be executed concurrently
- Shared variable
	- global and heap-allocated variables
	- NOT local variables (automatic storage duration,k .  )

![[Pasted image 20260117080515.png]]
