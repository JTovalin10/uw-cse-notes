# Synchronization
coordinating the execution of multiple threads to ensure correctness when accessing shared resources

## Why do we need it?
- Single-threaded applications execute sequentially
- Absent synchronization, instructions executed by distinct threads must be considered unordered/simultaneous
- [[Temporal Relations]]

## Core Problems
- [[Race Condition]] - when program results depend on timing (non-deterministic)
	- [[Heisenbug]] - bugs that disappear when observed
- [[Interleaved Schedules]] - execution of multiple threads can be interleaved with preemptive scheduling
- [[Critical Section Patterns]] - how these problems commonly arise

## Key Concepts
- [[Critical Sections]] - code sequences that may produce incorrect results if executed simultaneously
	- [[Critical Section Requirements]] - mutual exclusion, progress, bounded waiting, performance
- [[Mutual Exclusion]] - ensuring operations are not simultaneous
- [[Atomic]] - operations that execute as though they cannot be interrupted

## Mechanisms
solving critical section problems requires mechanisms that enforce mutual exclusion:
- [[Locks]] - memory objects with acquire/release operations
	- [[test_and_set]] - atomic read-and-set instruction
	- [[compare_and_swap]] - atomic compare-and-exchange instruction
- [[Spinlock]] - primitive lock using busy-waiting
- [[Semaphores]] - basic synchronization primitive with counter
- [[Monitors]] - higher-level construct requiring language support
- [[Messages]] - synchronization based on atomic data transfer across channels
- [[Disabling Interrupts]] - kernel-only mechanism
