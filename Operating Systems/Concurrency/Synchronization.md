# CSE451: Synchronization Primitives

**Synchronization** ensures that multiple threads can access shared resources without causing **[[Operating Systems/Concurrency/Synchronization/Mechanics/Race Conditions/Race Condition|Race Conditions]]** — situations where the result of an execution depends on the non-deterministic timing/interleaving of concurrently running threads.

### Mutex vs. Spinlock
The two most fundamental locking primitives differ in what a thread does while it waits for a held lock to become free:
- **Mutex (Mutual Exclusion)**: A blocking primitive. If the lock is held, the thread is put to sleep and removed from the CPU entirely, allowing the CPU to run other work while it waits. Ideal for long critical sections, since the cost of a context switch is small relative to the time that would otherwise be wasted spinning.
- **[[Operating Systems/Concurrency/Synchronization/Mechanics/Critical Sections/Critical SectionsComponents/Spinlock|Spinlock]]**: A busy-wait primitive. The thread continuously checks the lock in a loop without giving up the CPU. Ideal for very short critical sections or when sleeping is not allowed (e.g., inside an interrupt handler), since the overhead of putting a thread to sleep and waking it back up would exceed the time actually spent waiting.

### Condition Variables
A **[[Operating Systems/Concurrency/Synchronization/Mechanics/Condition Variables|Condition Variable]] (CV)** allows a thread to sleep until a specific condition becomes true, rather than busy-waiting or repeatedly polling. It must always be used in conjunction with a mutex: the mutex protects the shared state that the condition depends on, and the CV provides the mechanism for a thread to atomically release that mutex and go to sleep, then reacquire it upon waking. This pairing is necessary because checking the condition and going to sleep must happen as one atomic step — otherwise another thread could change the condition and signal in the gap between the check and the sleep, causing the waiting thread to miss the wakeup entirely (a **lost wakeup**).

### Low-Level Synchronization
Above the level of mutexes and condition variables, hardware provides indivisible building blocks that all higher-level primitives are ultimately implemented on top of:
- **Atomic Operations**: Hardware-guaranteed indivisible operations (e.g., `atomic_add`). No other thread can observe the operation half-completed.
- **[[Operating Systems/Concurrency/Synchronization/Mechanics/Locks/LocksComponents/compare_and_swap|Compare and Swap (CAS)]]**: An atomic instruction that compares the contents of a memory location to a given value and, only if they are the same, modifies the contents of that memory location to a new given value. This "check-then-act" behavior happening as a single atomic step is what makes it possible to build lock-free algorithms — a thread can attempt an update and detect, without a lock, whether another thread interfered in the meantime.
- **Memory Barrier**: An instruction that enforces an ordering constraint on memory operations issued before and after it, preventing the CPU or compiler from reordering reads/writes across the barrier in ways that would break the guarantees a lock is supposed to provide.
- **Read-Copy-Update (RCU)**: A lock-free synchronization mechanism used extensively in the Linux kernel for data structures that are read frequently but modified rarely. Readers never block, since writers create a new copy of the data and atomically swap in the pointer once the copy is ready, only reclaiming the old copy once no reader could still be using it.

### Futex (Fast Userspace Mutex)
A **Futex** is the building block for modern Linux locks, and its design directly reflects the mutex-vs-spinlock trade-off above: it avoids a kernel system call in the common uncontended case, but falls back to the kernel to sleep when there is genuine contention.
- **Fast Path**: If there is no contention, the lock is acquired via an atomic operation in userspace, with no kernel involvement at all — this is what makes futex-based locks cheap compared to always trapping into the kernel.
- **Slow Path**: If the lock is contested, a system call is made to put the thread to sleep in the kernel, exactly as a full mutex would, so the CPU is freed up for other threads instead of spinning.

### Deadlock
**[[Operating Systems/Concurrency/Problems/Deadlocks|Deadlock]]** occurs when a set of threads are blocked because each is holding a resource and waiting for another resource held by another thread in the set — see **[[Operating Systems/Concurrency/Problems/Deadlocks|Deadlocks]]** for the full analysis of the Coffman conditions, Resource Allocation Graphs, and prevention/avoidance/detection strategies. A related but distinct failure mode, where a thread is perpetually passed over rather than permanently blocked, is **[[Operating Systems/Concurrency/Problems/Starvation|Starvation]]**.

#### The 4 Coffman Conditions
All four must hold for a deadlock to occur:
1. **Mutual Exclusion**: Resources cannot be shared.
2. **Hold and Wait**: Threads hold resources while waiting for others.
3. **No Preemption**: Resources cannot be forcibly taken away.
4. **Circular Wait**: A chain of threads exists such that each holds a resource the next one needs.

#### Deadlock Management
- **Prevention**: Design the system so at least one Coffman condition cannot hold (e.g., lock ordering).
- **Avoidance**: Dynamically check for safe states before granting resources (e.g., **Banker's Algorithm**).
- **Detection and Recovery**: Allow deadlocks to happen, detect them with a resource graph, and kill/preempt a thread to break the cycle.

## Formal Definition

The Condition Variable wait pattern must always be expressed as a loop, not a single `if` check, because a thread can be woken spuriously or another thread may have already consumed the resource between the wakeup and the reacquisition of the lock:
```c
pthread_mutex_lock(&lock);
while (!condition) {
    pthread_cond_wait(&cv, &lock);
}
// Do work
pthread_mutex_unlock(&lock);
```

## Simplified Explanation

The mutex is the "bathroom key." The condition variable is the "waiting bench." You can't sit on the bench unless you have the key (briefly), and you give up the key while sitting so others can use the bathroom.

## Industry Standard Terms

| CSE451 Term | Industry / Standard Term |
| :--- | :--- |
| **Mutex** | Mutual exclusion lock / mutex |
| **Spinlock** | Busy-wait lock |
| **Condition Variable** | CV / monitor wait-notify mechanism |
| **Compare and Swap (CAS)** | Lock-free CAS primitive |
| **Read-Copy-Update (RCU)** | RCU (also used industry-wide, esp. Linux kernel) |
| **Futex** | Fast userspace mutex (Linux-specific, adopted industry-wide) |

### Related
- [[Operating Systems/Concurrency/Synchronization/Mechanics/Race Conditions/Race Condition|Race Conditions]]
- [[Operating Systems/Concurrency/Problems/Deadlocks|Deadlocks]]
- [[Operating Systems/Concurrency/Problems/Starvation|Starvation]]
- [[Systems Programming/Concurrency/Threads]]
