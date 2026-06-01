# CSE451: Monitors
A higher-level synchronization construct that combines mutual exclusion with condition variables. Requires language support — synchronization code is added by the compiler.

A monitor is essentially a class where every method automatically acquires a lock on entry and releases it on exit. It combines:
- **shared data** structures (object)
- **procedures** that operate on the shared data
- **synchronization** between concurrent threads that invoke those procedures

Data can only be accessed from within the monitor using the procedures, which protects it from unstructured access and prevents ambiguity about what the synchronization variables protect. Addresses the key usability issues that arise with [[Operating Systems/Concurrency/Synchronization/Mechanics/Semaphores]].

![[Screenshot 2026-01-20 at 3.57.31 PM.png]]

## Structure
```
monitor MonitorName {
    // shared data
    // condition variables

    procedure P1(...) { ... }
    procedure P2(...) { ... }
    ...

    initialization code { ... }
}
```

## Key Properties
- only one thread can be active inside the monitor at a time
- mutual exclusion is automatic (implicit lock on entry)
- condition variables for coordination between threads

## Condition Variables
Used for threads to wait for specific conditions within the monitor.

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

## Advantages
- easier to program correctly than semaphores
- mutual exclusion is automatic
- encapsulation of shared data

## Disadvantages
- requires language support
- less flexible than semaphores
- can still have deadlock with nested monitors

## Languages with Monitor Support
- Java (`synchronized` methods/blocks)
- C# (`lock` statement)
- Mesa (original implementation)

## Related
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Semaphores]]
- [[Critical Sections]]
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Mutual Exclusion]]
