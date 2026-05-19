# CSE 312: Chain Rule of Probability

The **chain rule** expresses the probability of a joint event as a product of conditional probabilities.

$$P(A_1 \cap A_2 \cap \cdots \cap A_n) = P(A_1)\,P(A_2 \mid A_1)\,P(A_3 \mid A_2 \cap A_1) \cdots P(A_n \mid \bigcap_{i=1}^{n-1} A_i)$$

### Simplified Explanation

The chain rule builds a joint probability one event at a time. You start with the probability of the first event, then multiply by the probability of the second event given the first already happened, then the third given the first two, and so on. It is just the [[Conditional Probability]] definition $P(A \cap B) = P(A)P(B \mid A)$ applied repeatedly.

## Related

- [[Conditional Probability]]
- [[Bayes Rule]]
- [[Law of Total Probability]]

## Industry Standard Terms

- **Chain Rule of Probability** → "general product rule" / "multiplication rule for probabilities." Not to be confused with the calculus chain rule.
