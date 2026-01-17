# Semaphores
a synchronization primitive consisting of an integer counter and a queue of waiting threads

introduced by Dijkstra in 1968

The following operations are done **[[Atomic]]ally**
## Operations
```c
wait(S)    // also called P() or down()
signal(S)  // also called V() or up()
```

### wait(S) / P() / down()
```c
void wait(semaphore *S) {
    S->value--;
    if (S->value < 0) {
        // add this thread to S->waiting_queue
        block();
    }
}
```

### signal(S) / V() / up()
```c
void signal(semaphore *S) {
    S->value++;
    if (S->value <= 0) {
        // remove a thread T from S->waiting_queue
        wakeup(T);
    }
}
```

## Types
### Binary Semaphore (Mutex)
- value is 0 or 1
- used for mutual exclusion
- initialized to 1

### Counting Semaphore
- value can be any non-negative integer
- used to control access to a resource with multiple instances
- initialized to number of available resources

## Usage Pattern for Mutual Exclusion
```c
semaphore mutex = 1;

// Thread code
wait(&mutex);
// critical section
signal(&mutex);
```

## Advantages over Spinlocks
- threads block instead of busy-waiting
- does not waste CPU cycles
- suitable for longer critical sections

## Disadvantages
- easy to make mistakes (forgetting to signal, wrong order)
- no ownership - any thread can signal
- deadlock prone if not careful

## Classic Problems Solved with Semaphores
- Producer-Consumer (bounded buffer)
- Readers-Writers
- Dining Philosophers

## Related
- [[Critical Sections]]
- [[Mutual Exclusion]]
- [[Spinlock]]
