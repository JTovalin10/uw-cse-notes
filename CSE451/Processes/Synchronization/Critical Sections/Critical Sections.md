# What is it
sequences of instructions that may get incorrect results if executed simultaneously
(also called [[Race Condition]] in reference when the result depends on the timing)

# How do we solve this
Forcing [[CSE451/Processes/Synchronization/Mutual Exclusion]] between two critical section executions is sufficient to ensure correct execution - guarantees ordering
## Mechanisms
- [[Spinlock]]
- [[Semaphores]]
- [[Monitors]]
- [[Messages]]
- [[Disabling Interrupts]]

## Requirements
see [[Critical Section Requirements]]

## How do they arise
see [[Critical Section Patterns]]

![[Pasted image 20260117080515.png]]

