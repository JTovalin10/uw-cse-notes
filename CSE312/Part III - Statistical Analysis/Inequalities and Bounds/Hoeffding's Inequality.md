# CSE 312: Hoeffding's Inequality

Let $X_1, X_2, \ldots, X_n$ be *[[Independence|independent]]* [[Random Variables|random variables]], each with range $[0, 1]$. Let $\bar{X} = \frac{1}{n}\sum X_i$ be the **sample mean**, and $\mu = \mathbb{E}[\bar{X}]$. For any $t \geq 0$:
$$\mathbb{P}\left(|\bar{X} - \mathbb{E}[\bar{X}]| \geq t\right) \leq 2e^{-2nt^2}$$

Note: $\bar{X}$ (also written $X^C$ in some formulations) represents the sample mean $\frac{1}{n}\sum X_i$.

### Simplified Explanation

Hoeffding gives an *exponentially* small probability that the [[Expectation|sample mean]] strays from its true mean. Unlike [[Chebyshev's Inequality|Chebyshev]] — whose bound shrinks only polynomially — the $e^{-2nt^2}$ term collapses rapidly as the number of samples $n$ grows, making it a much tighter guarantee when the $X_i$ are bounded and independent.

## Related
- [[Chebyshev's Inequality]]
- [[Markov Inequality]]
- [[Chernoff Bound (Multiplicative)]]
- [[Central Limit Theorem]]

## Industry Standard Terms

- **Hoeffding's Inequality** → standard probability term; an "exponential concentration inequality" for sums of bounded independent random variables.

