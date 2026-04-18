# CSE 312: Chebyshev's Inequality

Let $X$ be a random variable. For any $t > 0$. Note that $t$ is the deviation threshold: e.g., to find $P(X \leq n)$, set $t = |n - E[X]|$.
$$\mathbb{P}(|X - \mathbb{E}[X]| \geq t) \leq \frac{Var[X]}{t^2}$$

For this we would need to know:
1. Its expectation
2. Its variance

When it's better to use:
1. For large deviations from the mean
2. When the variance is small
3. When you need a lower and upper bound

## Related
- [[Markov Inequality]]
- [[Variance]]
- [[Expectation]]
- [[Hoeffding's Inequality]]
