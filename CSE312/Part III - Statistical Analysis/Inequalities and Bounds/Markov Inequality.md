# CSE 312: Markov's Inequality

Let $X$ be a random variable supported (only) on non-negative numbers. For any $t > 0$:
$$\mathbb{P}(X \geq t) \leq \frac{\mathbb{E}[X]}{t}$$

Furthermore, to apply this bound we need to know:
1. It's non-negative
2. It's expectation

## Examples
- **Example 1**: If the average height is 60 inches, what is the maximum fraction of people who can be at least 120 inches tall?
  - $\mathbb{P}(X \geq 120) \leq \frac{60}{120} = 1/2$.
- **Example 2**: If the average grade is 80, what is the maximum fraction of students who can have at least a 100?
  - $\mathbb{P}(G \geq 100) \leq \frac{80}{100} = 0.8$.

## When is this better to use:
1. When we only know the mean ($E[X]$)
2. When we have a small deviation from the mean
3. High variance situations

Compared to **Chebyshev's Inequality**, Markov is much looser because it only uses the first moment (mean). Chebyshev uses the second moment (variance) to provide a tighter bound.

## Related
- [[Chebyshev's Inequality]]
- [[Expectation]]
- [[Hoeffding's Inequality]]
