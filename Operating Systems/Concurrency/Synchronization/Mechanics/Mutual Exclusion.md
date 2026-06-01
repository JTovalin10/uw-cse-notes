# What is it
- definition: not simultaneous
	- A < B or B < A
	- we dont care which

# Why it matters
- prevents [[Race Condition]]s
- ensures [[Critical Sections]] execute correctly
- guarantees ordering of operations

# How to achieve it
one way to guarantee mutually exclusive execution is using **locks**

## Mechanisms
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Locks]] - acquire/release semantics
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Spinlock]] - busy-waiting primitive
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Semaphores]] - counter-based
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Monitors]] - language-level support
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Disabling Interrupts]] - kernel only

# Related
- [[Critical Section Requirements]]
- [[Atomic]]
