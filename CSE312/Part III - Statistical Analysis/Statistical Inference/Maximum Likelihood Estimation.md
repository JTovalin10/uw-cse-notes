# CSE 312: Maximum Likelihood Estimation (MLE)

The **likelihood** of an event $E$ under a parameter $\theta$ is:

$$\mathcal{L}(E : \theta) = P(E; \theta)$$

$P(E; \theta)$ means the probability of $X$, where to properly define the probability space we need to know the extra information ($\theta$).

$\mathcal{L}(X; \theta)$ is the likelihood of event $X$, given that an experiment was run with parameter $\theta$. Note that the likelihood doesn't sum up to 1 (all the time).

## Maximum Likelihood Estimator

The **maximum likelihood estimator** of the parameter $\theta$ is:

$$\hat{\theta} = \text{argmax}_\theta \; \mathcal{L}(E; \theta)$$

While $\theta$ is a variable, $\hat{\theta}$ is a number.

A quick trick when multiplying is taking the log, since $\log(ab) = \log(a) + \log(b)$.

## Definition of Likelihood

For discrete variables:

$$\mathcal{L}(x; \theta) = \prod_{i=1}^n p_X(x_i; \theta)$$

For continuous random variables we use:

$$\mathcal{L}(x; \theta) = \prod_{i=1}^n f_X(x_i ; \theta)$$

If you take the log (or natural log) of this, it turns from a product to a summation.

We then have $\hat{p}$, which is the data-based estimate of $p$:

$$\hat{p} = \frac{n}{\sum_{i=1}^n x_i}$$

## Unbiased

An estimator is **unbiased** when $\theta = E[\hat{\theta}]$, meaning the true value equals the expected value of the estimate.

### Proof: Sample Mean is Unbiased
Let $X_1, X_2, \dots, X_n$ be i.i.d. random variables with mean $\mu$. The sample mean is $\bar{X} = \frac{1}{n} \sum X_i$.
$$E[\bar{X}] = E\left[\frac{1}{n} \sum_{i=1}^n X_i\right] = \frac{1}{n} \sum_{i=1}^n E[X_i] = \frac{1}{n} \cdot n\mu = \mu$$
Since $E[\bar{X}] = \mu$, the sample mean is an unbiased estimator of the population mean.

### Note on Variance
The MLE for variance $\hat{\sigma}^2 = \frac{1}{n} \sum (X_i - \bar{X})^2$ is actually **biased**. The unbiased estimator for variance uses $\frac{1}{n-1}$ (Bessel's correction).

## Related

[[Argmax]] · [[Expectation]] · [[Discrete Random Variables]] · [[Continuous Random Variable]] · [[Confidence Intervals]]
