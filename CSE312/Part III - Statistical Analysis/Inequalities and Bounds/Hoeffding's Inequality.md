# CSE 312: Hoeffding's Inequality

Let $X_1, X_2, \ldots, X_n$ be *independent* RVs, each with range $[0, 1]$. Let $\bar{X} = \frac{1}{n}\sum X_i$ be the **sample mean**, and $\mu = \mathbb{E}[\bar{X}]$. For any $t \geq 0$:
$$\mathbb{P}\left(|\bar{X} - \mathbb{E}[\bar{X}]| \geq t\right) \leq 2e^{-2nt^2}$$

Note: $\bar{X}$ (also written $X^C$ in some formulations) represents the sample mean $\frac{1}{n}\sum X_i$.

## Related
- [[Chebyshev's Inequality]]
- [[Markov Inequality]]
- [[Chernoff Bound (Multiplicative)]]
- [[Central Limit Theorem]]
