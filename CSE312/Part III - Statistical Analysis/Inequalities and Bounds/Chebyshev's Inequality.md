# CSE 312: Chebyshev's Inequality

Let $X$ be a [[Random Variables|random variable]]. For any $t > 0$ — note that $t$ is the deviation threshold: e.g., to find $P(X \leq n)$, set $t = |n - E[X]|$.
$$\mathbb{P}(|X - \mathbb{E}[X]| \geq t) \leq \frac{Var[X]}{t^2}$$

### Simplified Explanation

Chebyshev says a random variable rarely lands far from its mean, and "far" is measured in units related to the [[Variance|variance]]. The more spread out $X$ is, the larger its variance, and the looser the guarantee. Unlike [[Markov Inequality|Markov]], it bounds *both* tails at once because it uses the absolute deviation $|X - E[X]|$.

To apply this bound we need to know:
1. Its expectation $E[X]$.
2. Its variance $Var(X)$.

When it's better to use:
1. For large deviations from the mean
2. When the variance is small
3. When you need a lower and upper bound

## Related
- [[Markov Inequality]]
- [[Variance]]
- [[Expectation]]
- [[Hoeffding's Inequality]]
- [[Confidence Intervals]]

## Industry Standard Terms

- **Chebyshev's Inequality** → standard probability term; a "two-sided concentration inequality" derived by applying Markov's inequality to $(X - E[X])^2$.

