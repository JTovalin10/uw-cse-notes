# CSE 312: Central Limit Theorem (CLT)

The sum of any independent random variables approaches a normal distribution:

$$Y_n = \frac{X_1 + X_2 + \ldots + X_n - n\mu}{\sigma \sqrt{n}}$$

As $n \rightarrow \infty$, the CDF of $Y_n$ converges to the CDF of $N(0, 1)$.

When $Y_n = 0$ we can use **continuity correction**:

$$P(m.5 < X < n.5)$$

where $m + 1 = n$.

When we want the average, fraction, or proportion of outcomes:

$$Z = \frac{\dfrac{X_1 + X_2 + \ldots + X_n}{n} - \mu}{\sigma / \sqrt{n}}$$

The shortcut to finding the denominator is finding the variance of $\mathbb{P}(X < n)$ and then taking the square root.

We want to use simple distributions (non-sum) to find the variance, then apply the CLT to find the probability we are attempting to find.

## Related

[[Normal Random Variable]] · [[Expectation]] · [[Variance]] · [[Confidence Intervals]] · [[Hoeffding's Inequality]]
