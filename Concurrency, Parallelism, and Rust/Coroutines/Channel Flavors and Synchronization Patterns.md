# Coroutines: Channel Flavors and Synchronization Patterns

## Channel Flavors & Synchronization Patterns

### 1. Buffered vs. Unbuffered Channels
- **Unbuffered (Rendezvous)**: Direct synchronous handoff (`send` blocks until `receive`, `receive` blocks until `send`). Used in HW1.
- **Buffered Channels**: The channel maintains an internal circular ring buffer. `send` writes into the buffer without blocking until capacity is full; `receive` reads from the buffer without blocking until capacity is empty.

### 2. Channel Data Safety & Pointer Ownership
In C runtimes, `SendableData` is defined as `void*`. While this allows arbitrary data transmission, it introduces severe memory safety risks:
- **Dangling Pointers & Double-Free**: If a sender transfers a heap pointer over a channel and both sender and receiver subsequently call `free()`, memory corruption occurs.
- **Linear Ownership Transfer**: Systems must enforce strict ownership transfer: once a pointer is sent via `send()`, the sender must relinquish ownership and never dereference or deallocate it again.

### 3. Barrier Synchronization Across Many Coroutines
- **Problem**: Suppose an application spawns 100 worker coroutines, but requires that none of them begin processing until `main()` finishes initialization and signals a global release.
- **Solution (Barrier Channel Pattern)**:
  - Create a single shared barrier channel `barrier_ch` and pass it to all 100 coroutines during `spawn()`.
  - At the start of each worker routine, invoke `receive(barrier_ch)`. All 100 workers suspend into `barrier_ch->blocked_receivers`.
  - When `main()` is ready to release all 100 routines:
    - *Iterative Release*: `main()` executes a loop running `send(barrier_ch, NULL)` 100 times, unblocking each worker sequentially.
    - *Constant-Space $O(1)$ Broadcast via Latching*: Instead of sending 100 discrete messages, `main()` closes or terminates the channel (or returns from a coordinator routine). Because the channel transitions to `has_terminated = true`, all 100 suspended receivers are immediately moved to `ready_q`, and all future calls to `receive(barrier_ch)` pass without blocking, achieving barrier release in $O(1)$ space and $O(1)$ synchronization complexity.

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Latching Return Values and Generators|Latching Return Values and Generators]] — Endless return streams
- [[Concurrency, Parallelism, and Rust/Coroutines/Interleaving and Yield Traces|Interleaving and Yield Traces]] — Output permutations and lazy vs eager spawn
