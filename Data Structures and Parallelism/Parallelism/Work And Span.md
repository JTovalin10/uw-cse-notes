# CSE 332: Work And Span

To analyze parallel algorithms, we use two key measures of running time, letting $T_P(n)$ be the running time with $P$ processors.

**Work**: How long it would take 1 processor, denoted $T_1(n)$. It is the cumulative work all processors must complete. For an array sum, $T_1(n) = \Theta(n)$.
**Span**: How long it would take an infinite number of processors, denoted $T_\infty(n)$. This represents the longest "dependence chain" or the "critical path length" / "computation depth". For array sum using divide-and-conquer, span is $\Theta(\log n)$.

**Work Law**: States that $P \cdot T_P(n) \ge T_1(n)$. $P$ processors can do at most $P$ things in parallel.
**Span Law**: States that $T_P(n) \ge T_\infty(n)$. A finite number of processors cannot outperform an infinite number.

The expected time guarantee for the ForkJoin Framework is asymptotically optimal:
$$T_P(n) \in O\left(\frac{T_1(n)}{P} + T_\infty(n)\right)$$

**Speedup**: How much faster we get for more processors: $T_1(n) / T_P(n)$.
**Perfect Linear Speedup**: The ideal speedup where $T_1 / T_P = P$.
**[[Parallelism]]**: The maximum possible speedup, given by $T_1 / T_\infty$. At some point, adding more processors won't be helpful, and that point is determined by the span.

Dependencies in computation can be visualized using a **Directed Acyclic Graph** (DAG), where span is the longest path.

## Related
- [[Fork-Join]]
- [[Amdahl's Law]]
