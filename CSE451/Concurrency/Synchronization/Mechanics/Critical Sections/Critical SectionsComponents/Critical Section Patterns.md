# Critical Section Patterns
how critical sections commonly arise in code

## Common Pattern
- read-modify-write of
- a shared value (variable)
- in code that can be executed concurrently

## Shared Variables
variables that can be accessed by multiple threads:
- global variables
- heap-allocated variables

## NOT Shared
- local variables (automatic storage duration)
- thread-local storage

## Example
```c
// Shared counter - critical section pattern
int counter = 0;  // global, shared

void increment() {
    // This is a critical section:
    // 1. READ: temp = counter
    // 2. MODIFY: temp = temp + 1
    // 3. WRITE: counter = temp
    counter++;  // NOT atomic!
}
```

## Related
- [[Critical Sections]]
- [[Race Condition]]
- [[Interleaved Schedules]]
