# Coroutines: Edge Cases and Failure Modes

## Edge Cases, Failure Modes & Mitigations

Cooperative user-space runtimes introduce unique failure modes that differ fundamentally from preemptive kernel-threaded environments.

### 1. Non-Preemptive Starvation (Rogue Loops)
- **Failure Mode**: If any coroutine enters an infinite computation (`while(1) {}`) or executes a CPU-intensive loop without calling `yield()` or blocking on a channel, the entire application freezes on that thread. All other coroutines on `ready_q` starve indefinitely.
- **Mitigation**: Cooperative systems rely on the **programmer contract**: long-running computations must periodically insert cooperative yield points (`yield()`). Modern runtimes or compilers can insert automated yield checks at loop back-edges and function prologues.

### 2. Private Stack Overflow & Silent Heap Corruption
- **Failure Mode**: Unlike OS thread stacks, which are protected by virtual memory guard pages (`mprotect` with `PROT_NONE`), a coroutine's `private_stack` is a fixed-size buffer inside a heap object (`uint64_t private_stack[STACK_ENTRIES]`). Deep recursion or large stack allocations (`char buffer[65536]`) overflow past the stack boundary, silently corrupting adjacent heap metadata and neighboring coroutine structures.
- **Mitigation**:
  - Allocate stack buffers using `mmap()` with an unmapped guard page at the bottom boundary.
  - Keep stack frames compact by allocating large buffers on the heap rather than the stack.

### 3. Channel Deadlocks & Cyclic Wait Dependencies
- **Failure Mode**: When coroutines communicate over channels, the dependency relationships between senders and receivers form a directed communication graph:
  - If Coroutine $A$ waits to receive from $B$, and Coroutine $B$ waits to receive from $A$, both routines are placed into `blocked_receivers`.
  - Mutual blocking permanently stalls both routines.
- **Mitigation**: The communication graph across channels must remain a **Directed Acyclic Graph (DAG)**. System designs must establish strict channel ordering rules to prevent cyclic wait dependencies.

### 4. All Coroutines Blocked (System Idle / Runtime Deadlock)
- **Failure Mode**: If all active coroutines become blocked in channel wait queues (`blocked_senders` or `blocked_receivers`) or `join()` queues, `ready_q` becomes completely empty while unfinished routines remain.
- **Mitigation**: The runtime scheduler detects an empty `ready_q` while `total_active_routines > 0`, immediately halting execution and reporting a runtime deadlock rather than hanging in an infinite idle loop.

### 5. Pointer Ownership & Data Safety Across Channels
- **Failure Mode**: Transferring raw pointers (`void*`) over channels can lead to double-free or use-after-free bugs if both sender and receiver attempt to mutate or deallocate the referenced heap memory.
- **Mitigation**: Enforce strict linear ownership transfer or immutability (as guaranteed by Rust's ownership type system). Once sent, the sender relinquishes the pointer.

### 6. Channel Lifetime vs. Coroutine Lifetime
- **Failure Mode**: If a coroutine terminates and its memory (`struct Routine`) is freed immediately while another routine holds a pointer to its associated `Channel*`, subsequent channel accesses cause undefined behavior or use-after-free crashes.
- **Mitigation**: Decouple channel lifetime from coroutine lifetime. Channels remain allocated on the heap as long as references exist, allowing receivers to safely read the latched terminal return value even after the producer coroutine has exited.

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Formal State Model|Formal State Model]] — State transition function and invariants
- [[Concurrency, Parallelism, and Rust/Coroutines/Deep Dive|Deep Dive]] — Stackful vs stackless, symmetric vs asymmetric, and switch latency (beyond lecture)
