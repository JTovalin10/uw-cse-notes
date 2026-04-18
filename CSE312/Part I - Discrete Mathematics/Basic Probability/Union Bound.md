# CSE 312: Union Bound

For any events $E, F$:

$$\mathbb{P}(E \cup F) \leq \mathbb{P}(E) + \mathbb{P}(F)$$

We use this to find the probability of dependent events — to find what could go wrong. Or more accurately:

$$\mathbb{P}(E) = \mathbb{P}\!\left(\bigcup_{i=1}^n A_i\right) \leq \sum_{i=1}^n \mathbb{P}(A_i)$$

## Related

- [[Mutual Exclusion]]
- [[Conditional Probability]]
- [[Principle of Inclusion-Exclusion]]
