# CSE 332: Concurrency And Locks

**Interleaving**: The sequence that operations occur across two threads. Due to time slicing, a thread can be interrupted at any time, leading to non-determinism.

**[[Race Condition]]**: Occurs when the computation result depends on scheduling (how threads are interleaved). Bad interleavings expose "bad" intermediate states.
**Data Race**: A specific type of race condition where two threads can access the same variable simultaneously, and at least one is a write.

To prevent race conditions, we need **[[Mutual Exclusion]]**, which ensures only one thread can be in a **Critical Section** at a time. This is implemented using a **Lock** (or Mutex).

Java provides `java.util.concurrent.locks.ReentrantLock`.
A **Reentrant Lock** remembers the thread that holds it and a count of how many times it was acquired, preventing a thread from deadlocking itself if it re-enters a locked method.

Always use a `try...finally` block to ensure locks are released even if exceptions occur!
```java
lk.lock();
try {
    // critical section
} finally {
    lk.unlock();
}
```

Java provides syntactic sugar via the `synchronized` keyword, using an object itself as a lock:
```java
synchronized(this) {
    // critical section
}
```
Or at the method level: `synchronized void push(E val) { ... }`.

**[[Deadlock]]**: Occurs when two or more threads are mutually blocking each other (e.g., $T_1$ blocked by $T_2$, $T_2$ blocked by $T_1$). Requirements for deadlock:
1. Multiple threads need multiple locks.
2. Locks held at the same time.
3. Locks acquired in multiple orders.
To fix deadlock, enforce a fixed order for lock acquisition or increase lock granularity.

Lock granularity is a tradeoff:
- **Coarse-Grained Locking**: One lock for an entire data structure. Easier to implement but reduces parallel performance.
- **Fine-Grained Locking**: Many locks, e.g., one per bucket in a hashtable. Allows more parallel access but is harder to implement (e.g., rehashing or tracking size without data races).

Memory categories in parallel programming:
1. **Thread Local**: Each thread has its own copy (no synchronization needed).
2. **Shared and Immutable**: Just one copy, but never written to (no synchronization needed).
3. **Shared and Mutable**: Requires synchronization!

## Related
- [[Fork-Join]]
- [[CSE333/Concurrency/Threads|CSE333: Threads]]
- [[CSE451/Threads/Thread|CSE451: Thread]]
- [[CSE451/Threads/Threads Overview|OS: Threads Overview]]
- [[CSE451/Processes/Synchronization/Synchronization|OS: Synchronization]]
- [[CSE451/Threads/Deadlocks|OS: Deadlocks]]
- [[CSE333/Process Management/Process Management|Systems: Process Management]]
