# Coroutines: Interleaving and Yield Traces

## Concrete Walkthrough & Execution Trace

### Walkthrough 1: Interleaving Permutations & Yield Trace

Consider a scenario where `main` spawns `my_routine`, and both functions alternate printing and yielding:

```rust
fn my_routine() {
    for i in 0..2 {
        print("!");
        yield();
    }
}

fn main() {
    let h = spawn(my_routine); // Enqueues my_routine to ready_q
    for i in 0..2 {
        print("?");
        yield();
    }
    join(h);
}
```

#### Output Permutations & Library Semantics
Under cooperative scheduling, the exact sequence of `?` and `!` printed depends on the runtime library's implementation policies:
- If `spawn()` uses **lazy spawn**, `main` prints `?` first.
- If `spawn()` uses **eager spawn**, `my_routine` prints `!` first.
- If both routines yield at each iteration, execution strictly interleaves.

#### Cycle-by-Cycle Execution Trace (Lazy Spawn Policy)

```
Initial State (t = 0):
  current_routine: Main (instruction pointer: line 8)
  ready_q: []

Trace:
  1. t = 1: Main calls spawn(my_routine).
     - Routine control block allocated on heap.
     - my_routine added to run queue.
     - ready_q: [my_routine]
  2. t = 2: Main prints "?" and calls yield().
     - Main enqueued to tail: ready_q: [my_routine, Main]
     - Head dequeued: my_routine.
     - routine_switch(Main -> my_routine).
  3. t = 3: my_routine prints "!" and calls yield().
     - my_routine enqueued to tail: ready_q: [Main, my_routine]
     - Head dequeued: Main.
     - routine_switch(my_routine -> Main).
  4. t = 4: Main prints "?" and calls yield().
     - Main enqueued to tail: ready_q: [my_routine, Main]
     - Head dequeued: my_routine.
     - routine_switch(Main -> my_routine).
  5. t = 5: my_routine prints "!" and terminates.
     - my_routine marked terminated; does not re-enqueue.
     - Head dequeued: Main.
     - routine_switch(my_routine -> Main).
  6. t = 6: Main calls join(h).
     - Target routine h is already terminated.
     - join() returns immediately. Main exits.

Final Output Sequence:
  ? ! ? !
```

---

### Walkthrough 2: Scheduling Interleavings: Lazy Spawn vs. Eager Spawn vs. Impossible Interleaving

Consider the following program:

```c
SendableData testRoutine(Channel* ch) {
    printf("*** testRoutine A\n");
    return (SendableData) 0;
}

int main() {
    coroutine_init();

    Channel* ch = spawn(testRoutine);
    printf("*** main A\n");
    printf("*** main B\n");
    yield();
}
```

#### Valid Interleaving 1: Lazy Spawn
If `spawn()` places `testRoutine` on `ready_q` and returns immediately to `main`:
```
Trace:
  1. main() calls spawn(testRoutine) -> testRoutine added to ready_q
  2. main() prints "*** main A\n"
  3. main() prints "*** main B\n"
  4. main() calls yield() -> main enqueued on ready_q, testRoutine dequeued
  5. testRoutine runs and prints "*** testRoutine A\n"
  6. testRoutine terminates
```
**Output**:
```
*** main A
*** main B
*** testRoutine A
```

#### Valid Interleaving 2: Eager Spawn
If `spawn()` enqueues `main` onto `ready_q` and immediately context-switches into `testRoutine`:
```
Trace:
  1. main() calls spawn(testRoutine) -> switches immediately to testRoutine
  2. testRoutine runs and prints "*** testRoutine A\n"
  3. testRoutine terminates -> switches back to main()
  4. main() resumes and prints "*** main A\n"
  5. main() prints "*** main B\n"
  6. main() calls yield() -> ready_q is empty, yield() returns false immediately
```
**Output**:
```
*** testRoutine A
*** main A
*** main B
```

#### Impossible Interleaving
The following output is **physically impossible** under cooperative scheduling:
```
*** main A
*** testRoutine A
*** main B
```

**Proof of Impossibility**:
Coroutines are strictly **non-preemptable**. Once `main()` begins executing after `spawn()`, it prints `*** main A\n`. Because there is no call to `yield()`, `send()`, or `receive()` between `main A` and `main B`, no context switch can trigger. In the absence of kernel timer preemption, user code executes uninterrupted until it cooperatively yields control.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Routine (`struct Routine`)** | Fiber / Green Thread / Stackful Coroutine / User Thread |
| **`ready_q`** | Run Queue / Task Scheduler / Ready Pool |

## Related

- [[Concurrency, Parallelism, and Rust/Coroutines|Coroutines]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Coroutines/Channel Flavors and Synchronization Patterns|Channel Flavors and Synchronization Patterns]] — Buffering, pointer ownership, and barriers
- [[Concurrency, Parallelism, and Rust/Coroutines/Assembly Context Switch Trace|Assembly Context Switch Trace]] — Step-by-step stack pivot
