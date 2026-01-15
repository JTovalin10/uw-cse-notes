Let $X_1, X_2,..., X_n$ be *independent* Bernoulli random variables. Let $X = \sum X_i$ and $\mu = \mathbb{E}[X]$. For any $0 \leq \delta \leq 1$ 
$$
\mathbb{P}(X \geq (1 + \delta)\mu) \leq exp(-\frac{\delta^2\mu}{3})
$$
and 
$$
\mathbb{P}(X \leq (1 - \delta)\mu) \leq exp(-\frac{\delta^2\mu}{2})
$$
The exp literally means $e^x$ 

[[Expectation]]
What this gives us is a tighter upper bound (more accurate)
we would want to use this if $X$ is a sum of independent Bernoulli variables and if the number of events is large (30+, but the accuracy gets better the larger)

We can find the right and left tail with this. 

assume we have
n people
probabilty of event is m
and we want to find probability of event not within a% of the true value
we want do 
$$
P(X \geq n(m - a)) \quad \text{and} \quad P(X \leq n(m + a))
$$
All we have to do from here is solve for $(1 + \delta) \mu$ and as we have $\mu$ as we are working with Bernoulli random variables we just need to fidn $\delta$:
$$
\delta = (n(m (+-) a)/ \mu)   - 1
$$
Then to find the probability of both tails:
$$
P(E) = P(X < n(m-a)) + P(X > n(m+a))
$$