# CSE 312: Index

## Part I — Discrete Mathematics

### Counting and Combinatorics
- [[Product Rule]] — multiply choices across independent decisions
- [[Sum Rule]] — add choices across mutually exclusive decisions
- [[Factorial]] — n! definition and applications
- [[Permutation]] — ordered arrangements (n choose k)
- [[Number of Subsets Formula]] — |P(S)| = 2^|S|
- [[Symmetry of Combination]] — C(n,k) = C(n,n-k)
- [[Binomial Theorem]] — expanding (a+b)^n with coefficients
- [[Sequences]] — ordered collections of elements
- [[Overcounting]] — recognizing and correcting double-counted items
- [[Complementary Counting]] — counting via complement
- [[Pigeonhole principle]] — n items in m<n containers → some container has 2+
- [[Possibilities with Restrictions]] — counting constrained outcomes
- [[Principle of Inclusion-Exclusion]] — |A∪B| = |A| + |B| - |A∩B| extended
- [[Size of Cartesian Product]] — |A × B| = |A| × |B|
- [[Size of Power Set]] — |P(S)| = 2^|S|
- [[Stars and bars]] — distributing identical items into distinct bins

### Basic Probability
- [[Conditional Probability]] — probability given other events occurred
- [[Independence]] — P(A∧B) = P(A)P(B) for independent events
- [[Mutual Exclusion]] — disjoint events with zero intersection
- [[Bayes Rule]] — P(B|A) = P(A|B)P(B)/P(A)
- [[Chain Rule]] — joint probability multiplication chain
- [[Law of Total Probability]] — partitioning probability space
- [[Union Bound]] — P(A∪B) ≤ P(A) + P(B)

## Part II — Random Variables and Distributions

### Random Variables
- [[Random Variables]] — function mapping outcomes to numerical values
- [[Support]] — set of values with non-zero probability
- [[Range]] — set of possible values for a random variable
- [[Probability Mass Function]] — P(X=k) for discrete random variables
- [[Cumulative Distribution Function]] — F(x) = P(X ≤ x)
- [[Discrete Random Variables]] — RV on countable domain with PMF
- [[Continuous Random Variable]] — RV on uncountable domain with PDF
- [[Joint Distributions]] — probability distribution of multiple random variables
- [[Indicator Random Variable]] — binary RV for event occurrence

### Distributions
- [[Distribution]] — probability distribution of a random variable
- [[Normal Random Variable]] — Gaussian/normal distribution properties
- [[Bernoulli Distribution]] — single trial with success/failure
- [[Binomial Distribution]] — number of successes in n independent Bernoulli trials
- [[Geometric Distribution]] — number of trials until the first success
- [[Negative Binomial Distribution]] — number of trials until the r-th success
- [[Discrete Uniform Distribution]] — equal probability for all finite outcomes
- [[Poisson Distribution]] — number of events in a fixed interval of time/space
- [[Hypergeometric Distribution]] — sampling without replacement
- [[Continuous Uniform Distribution]] — equal probability over an interval
- [[Exponential Random Variable]] — time between events in a Poisson process

## Part III — Statistical Analysis

### Expectation and Variance
- [[Expectation]] — E[X] average value of random variable
- [[Linearity of Expectation]] — E[aX+bY] = aE[X] + bE[Y]
- [[Conditional Expectation]] — E[X|Y] expected value given condition
- [[Joint Expectation]] — E[XY] expected value of product
- [[Law of Total Expectation]] — E[X] = Σ E[X|Y=y]P(Y=y)
- [[Variance]] — Var(X) = E[X^2] - (E[X])^2
- [[Standard Deviation]] — sqrt(Variance)
- [[Covariance]] — Cov(X,Y) = E[XY] - E[X]E[Y]

### Inequalities and Bounds
- [[Markov Inequality]] — P(X ≥ a) ≤ E[X]/a for non-negative X
- [[Chebyshev's Inequality]] — P(|X - μ| ≥ kσ) ≤ 1/k²
- [[Hoeffding's Inequality]] — bounds deviation of sample mean from true mean
- [[Chernoff Bound (Multiplicative)]] — exponential bound on tail probability

### Statistical Inference
- [[Argmax]] — selecting argument that maximizes value
- [[Maximum Likelihood Estimation]] — finding parameter values maximizing likelihood
- [[Central Limit Theorem]] — sum of many independent RVs approaches normal
- [[Confidence Intervals]] — range of values likely containing true parameter
