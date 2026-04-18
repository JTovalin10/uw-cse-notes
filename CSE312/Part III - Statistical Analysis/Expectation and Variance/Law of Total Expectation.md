# CSE 312: Law of Total Expectation

This is analogous to the [[Law of Total Probability]], but for expectations.

Let $A_1, A_2, \ldots, A_n$ be a partition of the sample space, then:
$$\mathbb{E}[X] = \sum_{i=1}^n \mathbb{E}[X \mid A_i] \mathbb{P}[A_i]$$

Let $X, Y$ be discrete random variables, then:
$$\mathbb{E}[X] = \sum_{y \in \Omega_Y} \mathbb{E}[X \mid Y = y] \mathbb{P}[Y = y]$$

## Related
- [[Expectation]]
- [[Conditional Expectation]]
- [[Law of Total Probability]]
