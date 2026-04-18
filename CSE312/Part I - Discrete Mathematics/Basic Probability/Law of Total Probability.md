# CSE 312: Law of Total Probability

Let $A_1, A_2, \ldots, A_n$ be a **partition** of the sample space (mutually exclusive and collectively exhaustive events). Then for any event $B$:

$$\mathbb{P}(B) = \sum_{i=1}^{n} \mathbb{P}(B \mid A_i)\,\mathbb{P}(A_i)$$

This allows computing the total probability of $B$ by conditioning on each part of the partition.

## Related

- [[Conditional Probability]]
- [[Bayes Rule]]
- [[Mutual Exclusion]]
