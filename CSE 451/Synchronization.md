# Synchronization
coordinating the execution of multiple threads to ensure correctness when accessing shared resources

## Why do we need it?
- Single-threaded applications execute sequentially
- Absent synchronization, instructions executed by distinct threads must be considered unordered/simultaneous
- [[Temporal Relations]]

## Core Problems
- [[Race Condition]] - when program results depend on timing (non-deterministic)
- [[Interleaved Schedules]] - execution of multiple threads can be interleaved with preemptive scheduling

## Key Concepts
- [[Critical Sections]] - code sequences that may produce incorrect results if executed simultaneously
- [[Mutual Exclusion]] - ensuring operations are not simultaneous
- [[Atomic]] - operations that execute as though they cannot be interrupted

## Mechanisms
solving critical section problems requires mechanisms that enforce mutual exclusion:
- [[Locks]] - memory objects with acquire/release operations
- [[Spinlock]] - primitive lock using busy-waiting
- [[Semaphores]] - basic synchronization primitive with counter
- [[Monitors]] - higher-level construct requiring language support
- [[Messages]] - synchronization based on atomic data transfer across channels
