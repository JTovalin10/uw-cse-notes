# CSE 312: Bayes' Rule

Reversing the condition — if we know $P(A \mid B)$ and want to find $P(B \mid A)$, we use **Bayes' Rule**:

$$P(B \mid A) = \frac{P(A \mid B)\,P(B)}{P(A)}$$

## Applications and Terminology

In applications like medical testing, the following terms are common:
- **Prevalence:** The baseline probability of having the disease, $\mathbb{P}(D)$.
- **Sensitivity:** The probability of a positive test given the disease is present, $\mathbb{P}(T \mid D)$ (true positive rate).
- **Specificity:** The probability of a negative test given the disease is absent, $\mathbb{P}(\overline{T} \mid \overline{D})$ (true negative rate). Note that $1 - \text{specificity}$ is the false positive rate.

**Bayes Factor** (or Likelihood Ratio) provides an intuitive approximation for updating beliefs after a positive test (especially when the prior is very small):
$$\text{Bayes Factor} = \frac{\text{Sensitivity}}{\text{False Positive Rate}} = \frac{1 - \text{False Negative Rate}}{\text{False Positive Rate}}$$

## Related

- [[Conditional Probability]]
- [[Law of Total Probability]]
- [[Chain Rule]]
