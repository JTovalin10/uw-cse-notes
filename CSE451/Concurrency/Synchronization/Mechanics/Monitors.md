## Lecture Notes
[[Monitor Lecture Notes]]

# Monitors
a higher-level synchronization construct that combines mutual exclusion with condition variables

requires language support for implicit operations

## Structure
[[Monitor Structure]]

## Key Properties
- only one thread can be active inside the monitor at a time
- mutual exclusion is automatic (implicit lock on entry)
- condition variables for coordination between threads


## Condition Variables
used for threads to wait for specific conditions within the monitor

### Operations
```c
wait(condition)   // release lock and sleep until signaled
signal(condition) // wake up one waiting thread
broadcast(condition) // wake up all waiting threads
```


## Semantics: Hoare vs Mesa
[[Monitor Semantics Hoare vs Mesa]]

## Example: Bounded Buffer
[[Monitor Bounded Buffer Example]]

## Advantages of monitors
[[Monitor Advantages]]

## Disadvantages of monitors
[[Monitor Disadvantages]]

## Languages with Monitor Support
[[Languages with Monitor Support]]

## Related
- [[Semaphores]]
- [[Critical Sections]]
- [[CSE451/Processes/Synchronization/Mutual Exclusion]]
