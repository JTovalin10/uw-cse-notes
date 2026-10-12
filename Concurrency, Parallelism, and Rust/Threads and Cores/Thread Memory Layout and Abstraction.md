# Threads and Cores: Thread Memory Layout and Abstraction

## Architecture & Core Mechanics

### Memory Layout: Shared vs. Private State
All threads belonging to the same process share a single virtual address space, enabling rapid data exchange but requiring strict synchronization.

| Memory Region | Access Scope | Ownership | Notes |
| :--- | :--- | :--- | :--- |
| **Global & Static Memory** | Shared | All Process Threads | Contains global variables, static constants, and compiled text segment. |
| **Heap Memory** | Shared | All Process Threads | Dynamic allocations (`malloc`, `Box::new`) accessible via pointers. |
| **Architectural Registers** | Private | Per Thread | Program Counter (PC/RIP), Stack Pointer (RSP), and general-purpose registers. |
| **Execution Stack** | Private | Per Thread | Local variables, function frame records, and return addresses allocated per thread. |

```
Virtual Address Space (Shared Process Memory)
+-------------------------------------------------------+
| Text Segment (Code) & Read-Only Data                  |
+-------------------------------------------------------+
| Global / Static Variables                             |
+-------------------------------------------------------+
| Dynamic Heap (Shared memory allocations)              |
|   |                                               ^   |
|   v                                               |   |
+-------------------------------------------------------+
| Thread 1 Stack (Private)  | Thread 2 Stack (Private)  |
| [Local Vars, Frame Ptrs]  | [Local Vars, Frame Ptrs]  |
+-------------------------------------------------------+
```

### The Thread Abstraction Model
Programmers structure concurrent code under the model of an unlimited pool of virtual cores.

![[Thread Abstraction.png]]

- **Abstraction Rules**:
  1. Software assumes an unlimited number of virtual cores (one per thread).
  2. Threads execute at variable, unpredictable speeds and may pause at any execution boundary.
  3. Correct concurrent software must produce valid results under **every possible scheduling interleaving**.

### Thread Lifecycle & Core Operations
Standard thread runtimes and OS kernel APIs provide four fundamental primitives for thread control:

```rust
// Spawns a new thread executing entry function `fn_ptr(arg)` with its own stack
fn thread_create(t: &mut ThreadID, fn_ptr: fn(*mut c_void), arg: *mut c_void);

// Voluntarily yields the remaining time quantum back to the OS scheduler
fn thread_yield();

// Blocks the calling thread until target thread `t` completes execution
fn thread_join(t: ThreadID);

// Terminates current thread execution and wakes any threads blocked in thread_join
fn thread_exit();
```

## Industry Standard Terms

| Course Term | Industry / Standard Term | Real-World Context / Production Equivalent |
| :--- | :--- | :--- |
| **Time Quantum** | Scheduler Time Slice | Linux EEVDF / CFS scheduler time slice |

## Related

- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Cores vs Threads|Cores vs Threads]] — Abstraction need, nondeterministic speed, and threads vs coroutines
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Preemption and Time Quanta|Preemption and Time Quanta]] — Hardware timers and frequency trade-offs
