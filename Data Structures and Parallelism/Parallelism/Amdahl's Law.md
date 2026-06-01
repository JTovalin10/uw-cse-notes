# CSE 332: Amdahl's Law

**[[Amdahl's Law]]** characterizes the speedup limit imposed by the unparallelizable (sequential) portion of a program.

Suppose $T_1 = 1$, and let $S$ be the proportion of the program that cannot be parallelized. Then $T_1 = S + (1 - S) = 1$.
With $P$ processors, assuming perfect linear speedup on the parallel portion:
$$T_P = S + \frac{1 - S}{P}$$

The overall speedup with $P$ processors is:
$$\text{Speedup} = \frac{T_1}{T_P} = \frac{1}{S + \frac{1 - S}{P}}$$

The maximum possible speedup with infinite processors (parallelism) is:
$$\frac{T_1}{T_\infty} = \frac{1}{S}$$

Even with a massive number of processors, the sequential part becomes a bottleneck. If $S = 1/3$, the maximum speedup regardless of how many processors are added is $3$. Parallelizable code requires skill and insight to recognize where parallelism is possible, and how to minimize $S$.

## Related
- [[Work And Span]]
