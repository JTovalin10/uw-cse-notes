# Coroutines: Deep Dive

## Deep Dive

### Stackful vs. Stackless Coroutines
Modern languages implement coroutines using one of two primary architectural models:

| Dimension | Stackful Coroutines (Fibers / Green Threads) | Stackless Coroutines (`async`/`await`) |
| :--- | :--- | :--- |
| **Stack Allocation** | Each coroutine allocates a dedicated stack buffer in heap/user memory (e.g., 8KB–32KB). | No dedicated stack; state is saved in an auto-generated struct frame on the heap. |
| **Yield Capability** | Can suspend execution from arbitrarily deep nested function calls (`foo() -> bar() -> yield()`). | Can only yield (`await`) at explicit top-level async function boundaries. |
| **Compiler Transformation** | Minimal; relies on assembly stack-pointer swap (`routine_switch.S`). | Heavy; the compiler rewrites the function into an enum state machine. |
| **Memory Overhead** | Fixed per routine (kilobytes per pre-allocated stack). | Proportional to live local variables across `await` points (bytes to words). |
| **Implementations** | This lecture design, Go goroutines, Lua coroutines, Windows Fibers. | Rust `Future`/`async`, JavaScript `Promises`, C# `async`/`await`, Python `asyncio`. |

### Symmetric vs. Asymmetric Coroutines
- **Asymmetric Coroutines**: Feature asymmetric control operations: an invoker resumes/spawns a routine, and the routine yields back to the scheduler or invoker. Execution always returns to the central run queue or caller.
- **Symmetric Coroutines**: Feature a symmetric control operation (`yield_to(target_routine)`). Coroutines explicitly pass execution directly to another named coroutine without returning to a central scheduler.

### Context Switch Latency: User-Space Assembly Swap vs. Kernel Interrupt
The performance disparity between cooperative coroutine switches and OS thread switches is substantial:

- **Coroutine Context Switch (`routine_switch.S`)**:
  - Requires saving/restoring 6 callee-saved registers and pivoting `%rsp`.
  - Executes approximately 12–16 machine instructions entirely in user-space L1 CPU cache.
  - Cost: **~5–10 nanoseconds**.
- **OS Kernel Thread Context Switch**:
  - Requires timer interrupt or system call trap, transitioning CPU privilege from Ring 3 (User) to Ring 0 (Kernel).
  - Saves full architectural register state, updates kernel process control blocks, flushes memory management state if crossing process boundaries, and triggers CPU branch target buffer and cache line evictions.
  - Cost: **~1,000–2,000 nanoseconds (1–2 microseconds)**.

Coroutines are approximately two orders of magnitude faster to switch than OS threads, allowing programs to handle massive concurrent connection volumes on a single CPU core.

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Starvation, stack overflow, deadlocks, and lifetime hazards (beyond lecture)
