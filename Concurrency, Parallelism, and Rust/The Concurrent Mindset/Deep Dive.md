# The Concurrent Mindset: Deep Dive

## Deep Dive

### Dennard Scaling Breakdown & Amdahl's Law
The historical inflection point highlighted in microprocessor trend charts occurred around 2005 with the collapse of **Dennard scaling**:
- Under Dennard scaling, as transistors shrunk, their power density remained constant because operating voltage scaled down proportionally with gate dimensions. This allowed clock frequencies to ramp from MHz to GHz without exceeding thermal limits.
- Below 90nm, leakage current and quantum tunneling prevented further supply voltage reductions, causing chip power consumption to explode with frequency (the "Power Wall").
- This shifted processor architecture to chip multiprocessing (CMP). According to **Amdahl's Law**, the theoretical speedup $S$ of a program on $N$ cores is strictly limited by its strictly sequential fraction $s$:
  $$S(N) = \frac{1}{s + \frac{1 - s}{N}}$$
  If just 5% of a program cannot be parallelized ($s = 0.05$), the maximum theoretical speedup on an infinite number of cores is bounded at $20\times$.

### Rust's Compile-Time Concurrency Primitives: `Send` and `Sync`
Rust codifies thread-safe concurrency directly into its type system via two core marker traits:
- **`Send`**: Indicates that ownership of the type can be transferred across thread boundaries safely.
- **`Sync`**: Indicates that it is safe for multiple threads to access references to the type (`&T`) concurrently.
- The language formalizes the invariant: `T: Sync \iff &T: Send`. If a type contains non-thread-safe internal mutability without synchronization (such as `Rc<T>`), the compiler marks it as `!Send` and `!Sync`, preventing data races before the code ever compiles.

## Related

- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset|The Concurrent Mindset]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/The Concurrent Mindset/Edge Cases and Hazards|Edge Cases and Hazards]] — Scheduling complexity and concurrency hazards (beyond lecture)
