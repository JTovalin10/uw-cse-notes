# Threads and Cores: Programmer View vs Processor View

## Concrete Walkthrough & Execution Trace

### Programmer View vs. Processor View
High-level code statements that appear single and atomic in source code decompile into multiple distinct assembly instructions (Read-Modify-Write sequence). Because the OS kernel can preempt a thread between *any* two assembly instructions, concurrent execution introduces schedule non-determinism.

Consider two threads concurrently executing increments on shared variables:

```c
// High-Level Source Statements
void thread_work() {
    x = x + 1;
    y = y + x;
    z = x + 5 * y;
}
```

At the assembly level, `x = x + 1` expands into three distinct instructions:
1. `MOV RAX, [x]` (Read `x` from shared memory into register)
2. `ADD RAX, 1`   (Modify register value)
3. `MOV [x], RAX` (Write updated value back to shared memory)

### Execution Interleaving Trace
Consider an initial state at $t = 0$ where shared memory holds $x = 0$, $y = 0$, $z = 0$.

```
Initial State (t = 0):
  Shared Memory: x = 0, y = 0, z = 0
  Thread 1: Ready
  Thread 2: Ready

Trace Scenario A: Sequential Execution (No Race)
  1. Thread 1 runs to completion:
     x = 1, y = 1, z = 6
  2. Thread 2 runs to completion:
     x = 2, y = 3, z = 17
  Final State: x = 2, y = 3, z = 17

Trace Scenario B: Interleaved Preemption (Data Race Hazard)
  1. Thread 1 executes: MOV RAX, [x]        (Reads x = 0 into Thread 1 RAX)
  2. Thread 1 executes: ADD RAX, 1          (Thread 1 RAX = 1)
     --- TIMER INTERRUPT: OS Preempts Thread 1 -> Switches to Thread 2 ---
  3. Thread 2 executes: MOV RBX, [x]        (Reads x = 0 into Thread 2 RBX)
  4. Thread 2 executes: ADD RBX, 1          (Thread 2 RBX = 1)
  5. Thread 2 executes: MOV [x], RBX        (Writes x = 1 to shared memory)
  6. Thread 2 executes: MOV RDI, [y]        (Reads y = 0)
  7. Thread 2 executes: ADD RDI, [x]        (RDI = 0 + 1 = 1)
  8. Thread 2 executes: MOV [y], RDI        (Writes y = 1 to shared memory)
     --- TIMER INTERRUPT: OS Preempts Thread 2 -> Resumes Thread 1 ---
  9. Thread 1 resumes: MOV [x], RAX         (Writes stale RAX = 1 to shared memory! Overwrites Thread 2's write!)
 10. Thread 1 executes: MOV RSI, [y]        (Reads y = 1)
 11. Thread 1 executes: ADD RSI, [x]        (RSI = 1 + 1 = 2)
 12. Thread 1 executes: MOV [y], RSI        (Writes y = 2 to shared memory)

Final State Scenario B: x = 1, y = 2 (Corrupted state due to lost update)
```

Because execution order depends on hardware timing, physical core count, and competing OS tasks, a correct concurrent program **must be synchronized to produce valid results across all possible schedule interleavings**.

## Industry Standard Terms

| Course Term | Industry / Standard Term | Real-World Context / Production Equivalent |
| :--- | :--- | :--- |
| **Thread** | Native Thread / Kernel Thread / OS Thread | POSIX Threads (`pthread_t`), Linux `task_struct`, Win32 Thread |

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Preemption and Time Quanta|Preemption and Time Quanta]] — Hardware timers and frequency trade-offs
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Cache Topology and Scheduler Queues|Cache Topology and Scheduler Queues]] — Thread migration, core-local queues, and work stealing
