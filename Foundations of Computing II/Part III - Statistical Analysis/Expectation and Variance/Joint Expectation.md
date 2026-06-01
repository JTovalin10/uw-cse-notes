# CSE 312: Joint Expectation

For a function $g(X, Y)$ of two [[Random Variables|random variables]], the [[Expectation|expectation]] can be written in terms of the joint PMF (see [[Joint Distributions]]):
$$\mathbb{E}[g(X, Y)] = \sum_{x \in \Omega_X} \sum_{y \in \Omega_Y} g(x, y) \cdot p_{X,Y}(x, y)$$

This is the two-variable form of LOTUS: instead of summing over one range, you sum $g(x,y)$ over every pair $(x,y)$, weighted by the joint probability $p_{X,Y}(x,y)$.

## Related
- [[Expectation]]
- [[Linearity of Expectation]]
- [[Joint Distributions]]
- [[Covariance]]

## Industry Standard Terms

- **Joint Expectation** → the two-dimensional case of LOTUS (Law of the Unconscious Statistician); $\mathbb{E}[XY]$ is a "mixed second moment."

