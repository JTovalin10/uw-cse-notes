# CSE 312: Union Bound

For any events $E, F$:

$$\mathbb{P}(E \cup F) \leq \mathbb{P}(E) + \mathbb{P}(F)$$

We use this to find the probability of dependent events — to find what could go wrong. Or more accurately:

$$\mathbb{P}(E) = \mathbb{P}\!\left(\bigcup_{i=1}^n A_i\right) \leq \sum_{i=1}^n \mathbb{P}(A_i)$$

### Simplified Explanation

The probability that at least one of several events happens is never more than the sum of their individual probabilities. Summing the probabilities counts every overlap multiple times, so the sum overshoots the true union — making it a safe upper bound. The bound is exact only when the events are [[Mutual Exclusion|mutually exclusive]]; it is the inequality counterpart of the exact [[Principle of Inclusion-Exclusion]].

## Related

- [[Mutual Exclusion]]
- [[Conditional Probability]]
- [[Principle of Inclusion-Exclusion]]

## Industry Standard Terms

- **Union Bound** → "Boole's inequality." Widely used in algorithm analysis to bound the probability that any one of several bad events occurs.
