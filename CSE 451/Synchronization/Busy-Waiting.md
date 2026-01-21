# Busy-Waiting
also called "spinning"

a technique where a thread repeatedly checks a condition in a loop until it becomes true

```c
while (condition == false)
    ; // do nothing, just keep checking
```

## Characteristics
- consumes CPU cycles while waiting
- no context switch overhead
- useful for very short waits

## Used by
- [[Spinlock]]

## Alternative
- blocking/sleeping (used by [[Semaphores]], [[Monitors]])
