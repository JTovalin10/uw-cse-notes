# CSE 312: Confidence Intervals

#Definition A **confidence interval** tells you the probability that your random variable fell within a certain range (interval):

$$\mathbb{P}(|X - \mu| < \epsilon) \geq 1 - \alpha$$

- $\mu$ = mean
- $\epsilon$ = margin of error
- $1 - \alpha$ = confidence level

## Common Z-Scores
For a normal distribution, the number of standard deviations $z$ needed for a confidence level:
- **90% Confidence**: $z \approx 1.645$
- **95% Confidence**: $z \approx 1.96$
- **99% Confidence**: $z \approx 2.58$

## Polling (Sample Proportion)
When polling $n$ people to find the proportion $p$ who support a candidate:
$$\hat{p} \pm z \sqrt{\frac{\hat{p}(1-\hat{p})}{n}}$$
The margin of error $\epsilon = z \sqrt{\frac{\hat{p}(1-\hat{p})}{n}}$. To be conservative, we often use $p=0.5$ which maximizes the variance.

## Related

[[Central Limit Theorem]] · [[Chebyshev's Inequality]] · [[Normal Random Variable]] · [[Maximum Likelihood Estimation]]
