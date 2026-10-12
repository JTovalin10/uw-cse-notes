# Coroutines: Latching Return Values and Generators

## Latching Return Values & Endless Return Streams

Consider the following program pattern:

```c
SendableData func(Channel* ch) {
    int64_t val = (int64_t) receive(ch); // Receives 6 sent by main()
    assert(val == 6);
    return (SendableData) 7;             // Routine finishes and returns 7
}

int main() {
    coroutine_init();

    Channel* ch = spawn(func);
    send(ch, (SendableData) 6);          // Blocks until func consumes 6

    int64_t val = (int64_t) receive(ch); // Receives 7
    assert(val == 7);

    val = (int64_t) receive(ch);         // Receives 7 again!
    assert(val == 7);
}
```

### The Latching Return Mechanism Explained
1. **Preventing Deadlocks on Terminated Coroutines**:
   When `func` finishes and executes `return (SendableData) 7;`, the coroutine terminates. Its execution stack is discarded, and it will never execute instructions again. If `receive(ch)` required an active sender to rendezvous, any subsequent call to `receive(ch)` would block forever, deadlocking `main()` because the terminated routine can never issue another `send()`.
2. **Channel Latching**:
   To prevent deadlocks, the runtime wraps every coroutine entry point in a stub. When the function returns:
   - The runtime records the return value: `ch->return_val = 7`.
   - The runtime sets a permanent completion flag: `ch->has_terminated = true`.
   - Any routines suspended in `ch->blocked_receivers` are moved to `ready_q`.
3. **Endless Stream Semantics**:
   All future calls to `receive(ch)` take the fast-path: they observe `ch->has_terminated == true` and immediately return `ch->return_val` (`7`) without blocking. The channel acts as a permanent result latch (equivalent to a resolved Promise or Future), broadcasting the final value indefinitely.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Latching Return Value** | Channel Completion Latch / Promise / Future Result |

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Channel Queue Mechanics|Channel Queue Mechanics]] — send, receive, and yieldOnto
- [[Concurrency, Parallelism, and Rust/Coroutines/Channel Flavors and Synchronization Patterns|Channel Flavors and Synchronization Patterns]] — Buffering, pointer ownership, and barriers
