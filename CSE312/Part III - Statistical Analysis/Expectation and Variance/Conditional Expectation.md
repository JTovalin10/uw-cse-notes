# CSE 312: Conditional Expectation

#Definition The **conditional expectation** of $X$ given an event $E$ (or given the value of another random variable) is the expected value of $X$ computed using only the conditional probability distribution — i.e., restricting to the outcomes consistent with the condition.

Given an event $E$:
$$\mathbb{E}[X \mid E] = \sum_{x \in \Omega_X} x \cdot \mathbb{P}(X = x \mid E)$$

Given that $Y = y$:
$$\mathbb{E}[X \mid Y = y] = \sum_{x \in \Omega_X} x \cdot \mathbb{P}(X = x \mid Y = y)$$

## Related
- [[Expectation]]
- [[Law of Total Expectation]]
- [[Conditional Probability]]
