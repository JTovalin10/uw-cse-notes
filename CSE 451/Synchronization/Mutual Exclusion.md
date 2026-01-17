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
- [[Locks]] - acquire/release semantics
- [[Spinlock]] - busy-waiting primitive
- [[Semaphores]] - counter-based
- [[Monitors]] - language-level support
- [[Disabling Interrupts]] - kernel only

# Related
- [[Critical Section Requirements]]
- [[Atomic]]
