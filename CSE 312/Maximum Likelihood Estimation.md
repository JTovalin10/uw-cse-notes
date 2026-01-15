The likelihood of an event $E$ under a parameter $\theta$ is
$$
\mathcal{L}(E : \theta) = P(E; \theta)
$$
$P(E; \theta)$ means the probability of $X$, where to properly define the probability sapce we need to know the extra information ($\theta$).

$\mathcal{L}(X; \theta)$ the likelihood of event $X$, given that an experument was run with parameter $\theta$. Note that the likelihood doesnt sum up to 1 (all the time).

[[argmax]]

# Maximum Likelihood Estimator
The max likelihood estimator of the parameter $\theta$ is
$$
\hat\theta = argmax_\theta \quad \mathcal{L}(E; \theta)
$$
While $\theta$ is a variable, $\hat\theta$ is a number
A quick trick when multlying is taking the log as log(ab) = log(a) + log(b)

# definition of likelihood
For discrete variables
$$
\mathcal{L}(x; \theta) = \prod_{i=1}^n p_X(x_i; \theta)
$$

For continous random variables we use
$$
\mathcal{L}(x; \theta) = \prod_{i=1}^n f_X(x_i ; \theta)
$$

If you take the log (or natural log) of this, it turns from a product to summation
We then have 
$\hat p$ which is the data-based estimate of p which is:
$$
\hat p = \frac{n}{\sum_{i=1}^nx_i}
$$
# Unbiased
this means that $\theta = E[\hat \theta]$ where the true value is equal to the estimated value