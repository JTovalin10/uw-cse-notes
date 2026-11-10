# Concurrency, Parallelism, and Rust: Model Checking

## Model Checking

- Build a **model**: every state the program can be in, and the steps between them.
- Explore every state the model can reach from the start (within its bounds).
- Check a property in each one.
- If the property is false, report the path: a schedule that reproduces the bug.

### What a Model Needs

- A set of states.
- The initial state.
- Transitions: which state can follow which.
- A property: which states are bad.

---

## Safety

- **Safety**: something bad never happens.
  - No path from the start reaches a bad state.
  - An `assert` never fails, two threads are never in the critical section together, there is no [[Concurrency, Parallelism, and Rust/Deadlocks|deadlock]].

![[Which are safe.png]]

---

## Liveness

- **Liveness**: something good eventually happens.
  - Every execution eventually reaches it: no reachable cycle or dead end avoids it.
  - Every request is eventually granted; the program finishes.
  - Without liveness, we get a deadlock.
  - We also need **fairness**, or else threads can starve.

---

## Combinatorial Explosion

- If we had to consider every possible interleaving, $k$ threads with $N$ lines each have $\frac{(kN)!}{(N!)^k}$ of them (see [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Data Races and Interleavings|Data Races and Interleavings]]).

### Ways to Shrink This

- **Merge equal states**: different histories, same state, same future.
- **Threads, not cores**: which core runs a thread doesn't matter.
  - Can't always do this because of caches.
- **Symmetry**: threads running the same code are interchangeable.
- **Abstraction**: keep only what the property depends on.
- **Consider switches only at synchronization** (safe Rust has no data races).
- And more: partial order reduction, bounding preemption.
- The rule: drop an execution only if it can't change whether the property fails.

### Merge Equal States

![[Merge equal states.png]]

- The two orders end in the same state, with the same future: explore it once.
- Keep a hash table of states already seen.
- Needs states you can hash and compute; raw memory addresses can hide otherwise equal states.

### Threads, Not Cores

- A thread computes the same thing on any core.
- So model which thread runs next, not which core runs it.
- Caches and weak memory are left out.

### Symmetry

- With symmetry, if we would repeat work, we don't need to run a state that is a mirror image of one already explored.

### Abstraction

![[Abstraction.png]]

- A state is the variables' values, the locks' state, and where each thread is.

### Consider Switches Only at Synchronization

- No data races in safe Rust: another thread sees `c` and `d` only through their locks.
- Local work (`a`, `b`) can't affect another thread.
- So only the order of the `lock()` calls matters.

```rust
handles.push(thread::spawn(move || {
	let a = i * 10; // local work
	*c.lock().unwrap() = i;
	let b = a + 1; // local work
	*d.lock().unwrap() = i;
	b
}))
```

---

## N Orders, M Outcomes

- If we have different schedules with different outcomes, this is a **race condition**: the outcome differs based on interleaving.
- We declare what the bad state is. For example, a program where `c` can end as 0 or 1.
- Assertions say which outcomes are bad, so write them as `assert!(...)`.

---

## Loom

- **Loom** is a Rust model checker.
- `loom::model` runs the closure once per schedule.
- It doesn't rely on the OS for scheduling; it tries to find a race condition as we have defined them.
- The failing schedule is replayable, unlike a flaky test.

### What Loom Does and Doesn't Check

- **Checks**: schedules of Loom's own locks, atomics, channels, and threads; atomic memory ordering; leaks of Loom's `Arc` and allocations.
- **Bounds**: limits on preemption and branches keep big tests finishing, but skip some schedules.
- **Misses**: `std` types it doesn't replace, I/O and the OS, and some weak-memory behaviors.
- A passing test is evidence within this model, not proof. The code can still contain bugs.

---

## Shuttle: When Every Schedule Is Too Many

- Like Loom.
- Usually runs many random schedules instead of all of them (it can also search exhaustively within a bound).
- Can find bugs in much bigger programs, but also doesn't prove anything.

---

## Temporal Logic

- **Linear temporal logic (LTL)** states properties over paths.
  - Safety: always not bad.
  - Liveness: always (if requested, then eventually granted).
- Tools such as TLA+ and SPIN check a model written in their own language.
- **Bounded model checking** turns $k$ steps into a SAT or SMT formula: it finds a bug within $k$ steps, but finding none proves nothing beyond $k$.

---

## Related

- [[Concurrency, Parallelism, and Rust/Deadlocks|Deadlocks]]: a deadlock is a safety violation (a reachable state with no moves)
- [[Concurrency, Parallelism, and Rust/Writing Multithreaded Code/Data Races and Interleavings|Data Races and Interleavings]]
- [[Concurrency, Parallelism, and Rust/Threads and Shared State in Rust|Threads and Shared State in Rust]]
- [[Concurrency, Parallelism, and Rust/Threads and Cores/Non-Deterministic Interleaving Invariant|Non-Deterministic Interleaving Invariant]]

## Industry Standard Terms

- **Merge equal states** → state-space deduplication / visited-set (hashing)
- **Symmetry** → symmetry reduction
- **Consider switches only at synchronization** → partial order reduction
- **Bounding preemption** → context-bounded model checking
- **Loom / Shuttle** → systematic concurrency testing (exhaustive vs randomized schedule exploration)
- **Bounded model checking** → BMC
