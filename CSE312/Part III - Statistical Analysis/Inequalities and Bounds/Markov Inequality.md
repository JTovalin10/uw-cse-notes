# CSE 312: Markov's Inequality

Let $X$ be a random variable supported (only) on non-negative numbers. For any $t > 0$:
$$\mathbb{P}(X \geq t) \leq \frac{\mathbb{E}[X]}{t}$$

Furthermore, to apply this bound we need to know:
1. It's non-negative
2. It's expectation

When is this better to use:
1. When we only know the mean ($E[X]$)
2. When we have a small deviation from the mean
3. High variance situations

## Related
- [[Chebyshev's Inequality]]
- [[Expectation]]
- [[Hoeffding's Inequality]]
