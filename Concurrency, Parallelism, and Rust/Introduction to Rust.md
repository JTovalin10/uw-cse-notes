# Concurrency, Parallelism, and Rust: Introduction to Rust

**Rust** is a systems language that keeps the strengths of C (control over memory and predictable performance) while moving a large class of bugs, especially memory errors and data races, from runtime testing to compile time. This note motivates Rust by looking at what C gets right and wrong, then builds up the rules the Rust compiler enforces: mutable and immutable references, then ownership, then the stronger type system that ties them together.

---

## Why Rust

### What C Does Well

- **Direct control over how data is laid out in memory.**
- **Direct mapping from the language to machine language**, which gives predictable performance.
- **Explicit memory allocation and deallocation**, so there are no garbage-collection pauses at unexpected times.

### What C Does Badly

These are the same features seen from the other side:

| C feature | The downside |
| :--- | :--- |
| Direct control over data layout | Nothing stops you from misusing it |
| Direct mapping to machine instructions | No high-level constructs such as iterators or data structures |
| Explicit allocation and deallocation | Nothing checks that you got it right |
| **Undefined behavior** | The C standard places no requirement on what happens: the program may crash, print garbage, or seem to work |

### Concurrency Is Exceptionally Difficult

- Concurrency bugs are often **runtime errors** and need extensive test suites to catch.
- They are hard to avoid, since concurrency matters for performance.
- In C, nothing protects you from **data races**.
- Testing gives weak guarantees for concurrent systems, because a bad interleaving may simply never occur during the test.
- We want all the help we can get.

---

## Categories of Code

Every program falls into one of three categories:

- **Invalid**: syntax errors and type errors.
- **Valid, unsafe**: undefined behavior, data races, null dereferences.
- **Valid, safe**: valid syntax, concurrency with carefully reasoned locking, and every exception and edge case handled.

### Who Checks Each Category

| Category | C | Rust |
| :--- | :--- | :--- |
| Invalid | The compiler | The compiler |
| Valid, unsafe | Tests, maybe | The compiler (in safe mode) |
| Valid, safe | Tests | Tests |

```mermaid
flowchart LR
    subgraph C_LANG [C]
        C1[Invalid] ==>|compiler| C2[Valid, unsafe]
        C2 ==>|tests, maybe| C3[Valid, safe]
    end
    subgraph RUST_LANG [Rust]
        R1[Invalid] ==>|compiler| R2[Valid, unsafe]
        R2 ==>|compiler, safe mode| R3[Valid, safe]
    end
```

- Rust **moves the line between unsafe and safe from the tests to the compiler**.
- The compiler still cannot check that the program does what you meant: deadlocks and logic bugs are still yours.

---

## A Stronger System

The goal is to let the compiler rule out races instead of hoping tests find them.

- Problems arise when data is accessed and modified at the same time.
- So we disallow creating multiple ways of mutating one piece of data, and we want the compiler to detect any attempt.
- We give up some freedom (the freedom to be unsafe) to get a safer program.

The following pseudocode has a race: both threads increment `a` through the same reference.

```rust
fn incr(&val) {
    val += 1;
}

fn main() {
    a = 0;
    t1 = thread_run(incr, &a);
    t2 = thread_run(incr, &a);
    join(t1); join(t2);
    assert a == 2;
}
```

### Data Race

A **data race** occurs when two instructions from different threads access the same memory, at least one is a write, and no synchronization orders them.

- To rule out data races forever: data cannot be shared if at least one of the references will write.

---

## Mutable and Immutable References

Multiple access is only a problem if someone writes through a reference. Rust therefore splits references into two kinds:

- **Mutable reference**: `&mut`
- **Immutable reference**: `&`

Rules:

- Multiple immutable references are fine, as nobody writes.
- You cannot write through an immutable reference.
- Only one mutable reference to a piece of data may exist at a time.

```rust
fn incr(&mut val) { // tell the compiler we will write
    val += 1;
}

fn main() {
    a = 0;
    t1 = thread_run(incr, &mut a);
    t2 = thread_run(incr, &mut a); // 2 mutable references is a compiler error
    join(t1); join(t2);
    assert a == 2;
}
```

- A `&mut` can be passed where only a `&` is expected, because a function that only reads is satisfied by a reference that could also write.

```rust
fn incr(& val) { // tell the compiler we will only read
    val += 1;    // compiler error: cannot write through an immutable reference
}

fn main() {
    a = 0;
    t1 = thread_run(incr, &mut a);
    join(t1);
}
```

---

## Ownership

- Idea: associate memory with a **single owner variable**, which is responsible for freeing it.
- Observation: when `a` goes out of scope, nothing can reach its memory anymore, so it can be cleaned up at that point.
- We do not need `free` anymore: the memory is freed automatically at the end of `main`.

---

## A Stronger Type System

- Types are how programmers communicate with the compiler.
  - Binaries have no types: the processor just reads memory at an address, with an expected size.
- Strong types enforce **invariants**.
- If you create a reference, the compiler must prove that the reference goes out of scope before the thing it points to does.
- There is no reinterpreting memory as an unrelated type, and no undefined behavior (in safe Rust).

---

## Protocol Specification

### Formal Definition

Two memory accesses $a_1$ (thread $T_1$) and $a_2$ (thread $T_2$) form a data race iff:

$$\text{addr}(a_1) = \text{addr}(a_2) \;\wedge\; T_1 \neq T_2 \;\wedge\; (\text{write}(a_1) \vee \text{write}(a_2)) \;\wedge\; \neg(a_1 \prec a_2 \vee a_2 \prec a_1)$$

where $\prec$ is the happens-before order established by synchronization.

### Simplified Explanation

Two threads touch the same spot, at least one changes it, and nothing makes one wait for the other. Rust's rule (many readers or exactly one writer) makes this combination impossible to write in safe code.

---

## Related

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Deep Dive|The Concurrent Mindset: Deep Dive]]: Rust `Send` and `Sync`
- [[Concurrency, Parallelism, and Rust/Synchronization Primitives|Synchronization Primitives]]
- [[Concurrency, Parallelism, and Rust/Threads and Cores|Threads and Cores]]
- [[Systems Programming/Smart Pointers/Shared Pointer|Shared Pointer]]: ownership in C++

## Industry Standard Terms

- **Mutable / immutable reference** → exclusive (`&mut`) / shared (`&`) borrow
- **Single owner variable** → ownership (RAII-style deterministic destruction)
- **Valid, unsafe** → memory-unsafe or undefined behavior
- **Data race** → data race (as defined by the C11 / C++11 memory models)
