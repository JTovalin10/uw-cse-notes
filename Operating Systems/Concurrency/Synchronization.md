# CSE451: Synchronization Primitives

Synchronization ensures that multiple threads can access shared resources without causing **[[Race Conditions]]**.

### Mutex vs. Spinlock
- **[[Mutex (Mutual Exclusion)]]**: A blocking primitive. If the lock is held, the thread is put to sleep and removed from the CPU. Ideal for long critical sections.
- **[[Operating Systems/Concurrency/Synchronization/Mechanics/Spinlock]]**: A busy-wait primitive. The thread continuously checks the lock in a loop. Ideal for very short critical sections or when sleeping is not allowed (e.g., inside an interrupt handler).

### Condition Variables
A **[[Condition Variable (CV)]]** allows a thread to sleep until a specific condition becomes true. It must always be used in conjunction with a **[[Mutex]]**.

#### Formal Pattern
```c
pthread_mutex_lock(&lock);
while (!condition) {
    pthread_cond_wait(&cv, &lock);
}
// Do work
pthread_mutex_unlock(&lock);
```

#### Simplified Explanation
The Mutex is the "bathroom key." The Condition Variable is the "waiting bench." You can't sit on the bench unless you have the key (briefly), and you give up the key while sitting so others can use the bathroom.

### Low-Level Synchronization
- **[[Atomic Operations]]**: Hardware-guaranteed indivisible operations (e.g., `atomic_add`).
- **[[Compare and Swap (CAS)]]**: An atomic instruction that compares the contents of a memory location to a given value and, only if they are the same, modifies the contents of that memory location to a new given value.
- **[[Memory Barrier]]**: An instruction that enforces an ordering constraint on memory operations issued before and after it.
- **[[Read-Copy-Update (RCU)]]**: A lock-free synchronization mechanism used extensively in the Linux kernel for data structures that are read frequently but modified rarely.

### Futex (Fast Userspace Mutex)
A **[[Futex]]** is the building block for modern Linux locks.
- **[[Fast Path]]**: If there is no contention, the lock is acquired via an atomic operation in userspace.
- **[[Slow Path]]**: If the lock is contested, a system call is made to put the thread to sleep in the kernel.

### Deadlock
**[[Deadlock]]** occurs when a set of threads are blocked because each is holding a resource and waiting for another resource held by another thread in the set.

#### The 4 Coffman Conditions
All four must hold for a deadlock to occur:
1. **Mutual Exclusion**: Resources cannot be shared.
2. **Hold and Wait**: Threads hold resources while waiting for others.
3. **No Preemption**: Resources cannot be forcibly taken away.
4. **Circular Wait**: A chain of threads exists such that each holds a resource the next one needs.

#### Deadlock Management
- **[[Prevention]]**: Design the system so at least one Coffman condition cannot hold (e.g., lock ordering).
- **[[Avoidance]]**: Dynamically check for safe states before granting resources (e.g., **[[Banker's Algorithm]]**).
- **[[Detection and Recovery]]**: Allow deadlocks to happen, detect them with a resource graph, and kill/preempt a thread to break the cycle.

### Related
- [[CSE451/Concurrency/Race Conditions]]
- [[Systems Programming/Concurrency/Threads]]
