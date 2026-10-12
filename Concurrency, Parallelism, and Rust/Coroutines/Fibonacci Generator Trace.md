# Coroutines: Fibonacci Generator Trace

## Walkthrough 4: Infinite Generator Stream (Fibonacci Producer-Consumer)

An infinite stream producer generating Fibonacci numbers via an unbuffered channel:

```rust
fn numbers(c: Channel) {
    let mut x = 0;
    let mut y = 1;
    loop {
        let sum = x + y;
        send(c, sum); // Blocks until main calls recv(c)
        x = y;
        y = sum;
    }
}

fn main() {
    let (h, c) = spawn(numbers);
    for i in 0..3 {
        let val = recv(c); // Unblocks numbers, receives sum
        print(val);
    }
    // Main exits loop and terminates without joining h.
}
```

```
Execution Trace:
  1. Main spawns numbers(c). numbers added to ready_q.
  2. Main calls recv(c) -> Channel has no sender waiting. Main blocks on c->blocked_receivers and yields CPU.
  3. numbers runs: calculates sum = 1, calls send(c, 1).
  4. Channel matches Rendezvous: 1 is delivered to Main. Main moved to ready_q.
  5. Main prints 1, loops, calls recv(c) -> blocks again.
  6. numbers proceeds: sum = 2, send(c, 2) matches Main's recv.
  7. Main prints 2, loops, calls recv(c) -> blocks again.
  8. numbers proceeds: sum = 3, send(c, 3) matches Main's recv.
  9. Main prints 3, finishes loop, and terminates.
  10. numbers remains permanently blocked on send(c, 5) because no receiver exists.
```

> **Producer Termination Note**: If `main()` had called `join(h)`, the program would deadlock permanently because `numbers` runs an infinite loop and never terminates. In generator architectures, producer lifecycles must be bounded by channel closing signals or cancellation tokens.

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Assembly Context Switch Trace|Assembly Context Switch Trace]] — Step-by-step stack pivot
- [[Concurrency, Parallelism, and Rust/Coroutines/Formal State Model|Formal State Model]] — State transition function and invariants
