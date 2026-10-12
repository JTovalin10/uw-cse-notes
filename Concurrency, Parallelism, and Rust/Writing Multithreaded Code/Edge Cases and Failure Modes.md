# Writing Multithreaded Code: Edge Cases and Failure Modes

## Edge Cases, Failure Modes & Mitigations

### 1. Deadlock via Lock Order Inversions
- **Failure Mode**: When multiple locks are acquired in inconsistent orders across threads (e.g., Thread 1 locks $L_1$ then $L_2$; Thread 2 locks $L_2$ then $L_1$), circular waiting produces complete system deadlock.
- **Mitigation**: Enforce a strict **Global Lock Acquisition Hierarchy**. All threads must acquire locks in a globally defined order (e.g., sorted by memory address or numerical ID). Alternatively, use lock ordering tools or language abstractions like RAII guards and `std::lock()` which acquire multiple locks atomically using deadlock-avoidance algorithms.

### 2. Double-Locking and Unreleased Locks
- **Failure Mode**: A thread holding a non-reentrant mutex attempts to acquire it a second time, immediately deadlocking with itself. Similarly, if an error path or early `return` exits a function before calling `unlock()`, all future threads requesting the lock block indefinitely.
- **Mitigation**: Rely on scoped RAII locks (such as Rust's `MutexGuard` or C++ `std::lock_guard`) where lock release is tied deterministically to stack unwinding and scope exit.

### 3. Barrier Stragglers & Thread Skew
- **Failure Mode**: If work is unevenly decomposed across threads, early-arriving threads spend excessive processor cycles idling at `wait(b)`. The throughput of the entire system collapses to the speed of the slowest thread (**Amdahl's bottleneck**).
- **Mitigation**: Implement dynamic load balancing or work-stealing task queues instead of static barrier phases when task durations exhibit high variance.

### 4. Memory Consistency Violations on Flag-Based Signaling
- **Failure Mode**: Implementing communication using raw shared flags (e.g., `while (!ready);`) without memory barriers or atomics. Compilers may optimize the loop into an infinite loop `if (!ready) while (true);`, or the CPU may reorder reads of data before the read of `ready`.
- **Mitigation**: Never use raw plain variables for cross-thread signaling. Use atomic types with explicit memory orderings (`acquire`/`release`) or condition variables.

## Related

- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code|Writing Multithreaded Code]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Bank Account Traces|Bank Account Traces]] — Unsynchronized, mutex, and barrier executions
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Deep Dive|Deep Dive]] — x86-64 TSO vs ARM memory models (beyond lecture)
