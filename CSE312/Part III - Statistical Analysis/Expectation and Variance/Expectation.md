# CSE 312: Expectation (Expected Value)

#Definition The **expected value** of a random variable $X$ is the weighted average of all possible values it can take, weighted by their probabilities:
$$E[X] = \sum_{k \in \Omega_X} k \cdot P(X = k)$$

## Functions of a Random Variable (LOTUS)

The Law of the Unconscious Statistician (LOTUS) states that the expected value of a function $g(X)$ of a random variable $X$ is:
$$\mathbb{E}[g(X)] = \sum_{k \in \Omega_X} g(k) \cdot \mathbb{P}(X = k)$$

Notice that $\mathbb{E}[g(X)]$ might not be $g(\mathbb{E}[X])$.

## Related
- [[Variance]]
- [[Range]]
- [[Linearity of Expectation]]
- [[Conditional Expectation]]
- [[Law of Total Expectation]]
