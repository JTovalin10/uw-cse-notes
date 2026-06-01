# CSE 312: Conditional Probability

#Definition For any event $B$ with $P(B) > 0$, the **probability of $A$ conditioned on $B$** is:

$$P(A \mid B) = \frac{P(A \cap B)}{P(B)}$$

### Simplified Explanation

Conditioning on $B$ means we restrict our attention to the world in which $B$ already happened. We shrink the [[Sample Space and Events|sample space]] down to $B$ and ask what fraction of that smaller world also has $A$. Dividing by $P(B)$ renormalizes so that the restricted space again has total probability 1.

## Related

- [[Sample Space and Events]]
- [[Bayes Rule]]
- [[Independence]]
- [[Chain Rule]]
- [[Law of Total Probability]]

## Industry Standard Terms

- **Conditional Probability** → standard term across statistics; $P(A \mid B)$ is read "the probability of $A$ given $B$."
