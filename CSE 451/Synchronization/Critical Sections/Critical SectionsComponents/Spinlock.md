# What is it
a lock that uses busy-waiting (spinning) to wait for the lock to become available

primitive, minimal semantics; used to build other synchronization primitives

# How it works
```c
void acquire(lock_t *lock) {
    while (test_and_set(&lock->flag) == 1)
        ; // spin - keep trying
}

void release(lock_t *lock) {
    lock->flag = 0;
}
```

# Implementation challenge
problem is that implementation of spinlocks has [[Critical Sections]] too
- acquire/release must be [[Atomic]]
- needs help from hardware

## Hardware support
- atomic instructions
	- [[test_and_set]]
	- [[compare_and_swap]] (cmpxchg)
- disable/reenable interrupts
	- to prevent context switches

# Advantages
- simple implementation
- no context switch overhead
- good for short critical sections
- necessary for kernel synchronization

# Disadvantages
- wastes CPU cycles (busy-waiting)
- not fair - no guarantee of ordering
- bad for long critical sections
- cache line bouncing on multiprocessors

# When to use
- very short critical sections
- when sleeping is not an option (interrupt handlers)
- building other synchronization primitives

# Related
- [[Locks]]
- [[Atomic]]
- [[Semaphores]]
- [[Critical Sections]]
