# Writing Multithreaded Code: Bank Account Traces

## Concrete Walkthrough & Execution Trace

### Scenario: Shared Bank Account Counter

Two concurrent threads (`Thread 1` and `Thread 2`) increment a shared variable `balance` initialized to 100. Each thread executes a high-level update `balance = balance + 10`.

At the assembly level, this update compiles into three distinct instructions:
1. `LOAD R, [balance]` (Read current balance into CPU register)
2. `ADD  R, 10`        (Add 10 to register value)
3. `STORE [balance], R` (Write updated register value back to memory)

---

### Trace 1: Unsynchronized Execution (Data Race & Lost Update)

```
Initial State:
  Memory: balance = 100
  Thread 1: R1 = undefined
  Thread 2: R2 = undefined

Execution Trace:
  t = 0: Thread 1 executes LOAD R1, [balance]       -> R1 = 100
  t = 1: Thread 1 executes ADD  R1, 10              -> R1 = 110
  t = 2: [OS Preemption: Timer interrupt fires. OS switches context to Thread 2]
  t = 3: Thread 2 executes LOAD R2, [balance]       -> R2 = 100 (Stale value!)
  t = 4: Thread 2 executes ADD  R2, 10              -> R2 = 110
  t = 5: Thread 2 executes STORE [balance], R2      -> Memory: balance = 110
  t = 6: [OS Preemption: OS switches context back to Thread 1]
  t = 7: Thread 1 executes STORE [balance], R1      -> Memory: balance = 110 (Overwrites Thread 2!)

Final State:
  Memory: balance = 110
  Post-condition Violation: Expected balance = 120, Actual balance = 110 (Lost update of 10 units).
```

---

### Trace 2: Synchronized Execution with Mutex Lock

```
Initial State:
  Memory: balance = 100, lock.state = UNLOCKED
  Thread 1: R1 = undefined, blocked = false
  Thread 2: R2 = undefined, blocked = false

Execution Trace:
  t = 0: Thread 1 invokes lock(&m)                  -> lock.state = LOCKED (Owned by T1)
  t = 1: Thread 1 executes LOAD R1, [balance]       -> R1 = 100
  t = 2: [OS Preemption: Timer interrupt fires. OS switches context to Thread 2]
  t = 3: Thread 2 invokes lock(&m)                  -> Lock held by T1!
         Thread 2 transitions to BLOCKED state, yields CPU.
  t = 4: [OS switches context back to Thread 1]
  t = 5: Thread 1 executes ADD  R1, 10              -> R1 = 110
  t = 6: Thread 1 executes STORE [balance], R1      -> Memory: balance = 110
  t = 7: Thread 1 invokes unlock(&m)                -> lock.state = UNLOCKED, T2 unblocked.
  t = 8: Thread 2 scheduled, acquires lock(&m)      -> lock.state = LOCKED (Owned by T2)
  t = 9: Thread 2 executes LOAD R2, [balance]       -> R2 = 110 (Fresh value!)
  t = 10: Thread 2 executes ADD  R2, 10             -> R2 = 120
  t = 11: Thread 2 executes STORE [balance], R2     -> Memory: balance = 120
  t = 12: Thread 2 invokes unlock(&m)               -> lock.state = UNLOCKED

Final State:
  Memory: balance = 120, lock.state = UNLOCKED
  Post-condition Preserved: Correct serialized execution.
```

---

### Trace 3: Coarse-Grained Synchronization with Barrier

Three worker threads (`T1`, `T2`, `T3`) process array partitions in Phase 1, wait at a barrier, and aggregate sums in Phase 2.

```
Initial State:
  Barrier: threshold = 3, count = 0, generation = 0

Execution Trace:
  t = 0: T1 finishes Phase 1 work (fast thread), calls barrier_wait(&b)
         Barrier count = 1. Count < 3 -> T1 blocks.
  t = 1: T2 finishes Phase 1 work (medium thread), calls barrier_wait(&b)
         Barrier count = 2. Count < 3 -> T2 blocks.
  t = 2: T3 continues executing Phase 1 (slow straggler thread). T1 and T2 remain blocked.
  t = 3: T3 finishes Phase 1 work, calls barrier_wait(&b)
         Barrier count = 3. Count == threshold!
         Barrier increments generation to 1, resets count = 0, awakens T1 and T2.
  t = 4: T1, T2, and T3 resume simultaneously into Phase 2.

Final State:
  All Phase 1 writes globally visible before Phase 2 reads commence.
```

## Related

- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code|Writing Multithreaded Code]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Memory Reordering and Fences|Memory Reordering and Fences]] — Compiler and hardware reordering
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Deadlock, double-locking, stragglers, and flag signaling (beyond lecture)
