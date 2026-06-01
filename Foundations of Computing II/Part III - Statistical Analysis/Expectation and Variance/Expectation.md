# CSE 312: Expectation (Expected Value)

#Definition The **expected value** of a [[Random Variables|random variable]] $X$ is the weighted average of all possible values it can take, weighted by their probabilities:
$$E[X] = \sum_{k \in \Omega_X} k \cdot P(X = k)$$

The sum ranges over the [[Range|range]] $\Omega_X$, and each value is weighted by its [[Probability Mass Function|PMF]] probability.

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
- [[Joint Expectation]]

## Industry Standard Terms

- **Expectation** $E[X]$ → "expected value" / "mean" / "first moment" of a distribution.
- **LOTUS** → "Law of the Unconscious Statistician" (also "change-of-variable formula for expectation").

