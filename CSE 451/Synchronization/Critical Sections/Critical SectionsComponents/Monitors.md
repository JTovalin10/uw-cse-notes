# Monitors
a higher-level synchronization construct that combines mutual exclusion with condition variables

requires language support for implicit operations

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
used for threads to wait for specific conditions within the monitor

### Operations
```c
wait(condition)   // release lock and sleep until signaled
signal(condition) // wake up one waiting thread
broadcast(condition) // wake up all waiting threads
```

## Semantics: Hoare vs Mesa
### Hoare Monitors (original)
- signal immediately transfers control to waiting thread
- signaling thread blocks
- condition guaranteed to hold when waiter runs

### Mesa Monitors (practical)
- signal is a hint, waiter may not run immediately
- signaling thread continues
- waiter must recheck condition (use `while`, not `if`)

```c
// Mesa-style (correct)
while (!condition) {
    wait(cv);
}

// Hoare-style (would work but not in Mesa)
if (!condition) {
    wait(cv);
}
```

## Example: Bounded Buffer
```c
monitor BoundedBuffer {
    item buffer[N];
    int count = 0;
    condition not_full, not_empty;

    void insert(item x) {
        while (count == N)
            wait(not_full);
        buffer[count++] = x;
        signal(not_empty);
    }

    item remove() {
        while (count == 0)
            wait(not_empty);
        item x = buffer[--count];
        signal(not_full);
        return x;
    }
}
```

## Advantages
- easier to program correctly than semaphores
- mutual exclusion is automatic
- encapsulation of shared data

## Disadvantages
- requires language support
- less flexible than semaphores
- can still have deadlock with nested monitors

## Languages with Monitor Support
- Java (synchronized methods/blocks)
- C# (lock statement)
- Mesa (original implementation)

## Related
- [[Semaphores]]
- [[Critical Sections]]
- [[Mutual Exclusion]]
