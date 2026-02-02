## Condition Variables
used for threads to wait for specific conditions within the monitor

### Operations
```c
wait(condition)   // release lock and sleep until signaled
signal(condition) // wake up one waiting thread
broadcast(condition) // wake up all waiting threads
```
