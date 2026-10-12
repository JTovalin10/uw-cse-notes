# Decomposition: Scaling Laws

## Formal Analysis / Theoretical Limits

### 1. Amdahl's Law (Strong Scaling)

#### Formal Definition
Let $T_1$ be the execution time of an algorithm on a single worker, and let $f \in [0, 1]$ represent the strictly serial fraction of the computation that cannot be parallelized. Assuming the remaining parallel fraction $(1 - f)$ scales perfectly linearly across $N$ workers:

$$T_N = T_1 \left(f + \frac{1 - f}{N}\right)$$

The parallel speedup $S_N$ is:

$$S_N = \frac{T_1}{T_N} = \frac{1}{f + \frac{1 - f}{N}}$$

As the number of physical workers approaches infinity ($N \to \infty$):

$$\lim_{N \to \infty} S_N = \frac{1}{f}$$

#### Simplified Explanation
If 10% of a program must run sequentially (such as loading an image from disk or synchronizing a task queue), adding a million processors can never speed up the program by more than $10\times$. The serial bottleneck strictly caps maximum speedup for a fixed problem size.

---

### 2. Gustafson's Law (Weak Scaling / Scaled Speedup)

#### Formal Definition
Amdahl's law assumes a fixed problem size. In practice, programmers use more processors to tackle proportionally larger problems in the same total time. Let $f$ be the serial fraction of execution time on $N$ workers. The scaled speedup $S_{\text{scaled}}(N)$ is:

$$S_{\text{scaled}}(N) = f + (1 - f)N = N - f(N - 1)$$

#### Simplified Explanation
Instead of running a fixed-size job faster, increasing workers allows running a larger job in the same timeframe. Because the parallelizable portion scales upward with dataset size while serial setup overhead stays relatively fixed, the achievable speedup grows near-linearly with the number of processors.

---

### 3. Granularity Metric

#### Formal Definition
$$\text{Granularity } G = \frac{T_{\text{computation}}}{T_{\text{communication}}}$$

#### Simplified Explanation
A subproblem is only worth delegating to a separate worker thread if the time required to compute its result is significantly greater than the time spent packaging, transferring, and synchronizing that data.

---

### 4. Baseline Measurement Invariant

$$\text{Speedup } S = \frac{T_{\text{best serial}}}{T_{\text{parallel}}}$$

When reporting parallel speedup, the single-core execution time must always be measured using the **fastest known serial algorithm**, rather than running the parallel algorithm with a thread count of 1. Parallel algorithms incur coordination data structures and synchronization overhead that artificially slow down single-thread execution.

## Industry Standard Terms

| Course Term | Industry / Standard Term |
| :--- | :--- |
| **Amdahl's Law** | Strong Scaling Limit |
| **Gustafson's Law** | Weak Scaling / Scaled Speedup |

## Related

- [[Concurrency, Parallelism, and Rust/Decomposition|Decomposition]] — Hub for this topic
- [[Concurrency, Parallelism, and Rust/Decomposition/Domain Partitioning Trace|Domain Partitioning Trace]] — Comparing partitioning schemes
- [[Concurrency, Parallelism, and Rust/Decomposition/Edge Cases and Performance Hazards|Edge Cases and Performance Hazards]] — Performance pitfalls (beyond lecture)
