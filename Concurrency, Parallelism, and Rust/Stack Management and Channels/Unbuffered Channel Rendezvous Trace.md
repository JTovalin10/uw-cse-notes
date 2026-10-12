# Stack Management and Channels: Unbuffered Channel Rendezvous Trace

## Concrete Walkthrough & Execution Trace

### Unbuffered Channel Rendezvous Trace

Consider two coroutines: **Producer (Routine 1)** sending value `42` and **Consumer (Routine 2)** receiving on unbuffered Channel `C`.

```
Initial State (t = 0):
  ready_queue = [Routine 1 (Active), Routine 2]
  Channel C: buffer = [], send_waiters = [], recv_waiters = []

Trace:
  1. Routine 1 calls send(C, 42):
     - Channel C is unbuffered (k = 0). No receiver is currently waiting on recv_waiters.
     - Routine 1 places payload 42 into Channel C rendezvous slot.
     - Routine 1 enqueues itself to C.send_waiters and calls block_on().
     - run_next() pops Routine 2 from ready_queue and executes context_switch.

  2. Routine 2 runs (Active):
     - Routine 2 calls recv(C).
     - Routine 2 inspects C.send_waiters and dequeues Routine 1.
     - Routine 2 extracts payload 42 from Channel C rendezvous slot.
     - Routine 2 unblocks Routine 1 by moving Routine 1 to ready_queue.
     - Routine 2 returns 42 to caller.

  3. Routine 2 calls yield():
     - Routine 2 enqueues to ready_queue.
     - run_next() pops Routine 1 and switches context back to Routine 1.
     - Routine 1 returns cleanly from send(C, 42).

Final State:
  Value 42 successfully transferred. Both routines active and ready.
```

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Unbuffered Channel** | Synchronous Channel / Zero-Capacity Rendezvous Channel |
| **Buffered Channel** | Asynchronous Bounded Channel / Circular Queue Channel |

## Related

- [[Concurrency, Parallelism, and Rust/Stack Management and Channels|Stack Management and Channels]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Context Switching and Assembly Trampoline|Context Switching and Assembly Trampoline]] — Scheduler interface, register saving, and the switch
- [[Concurrency, Parallelism, and Rust/Stack Management and Channels/Channel Formal Specification|Channel Formal Specification]] — Formal definition and intuition
