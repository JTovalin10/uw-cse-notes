# CSE 312: Chernoff Bound (Multiplicative)

Let $X_1, X_2, \ldots, X_n$ be *independent* Bernoulli random variables. Let $X = \sum X_i$ and $\mu = \mathbb{E}[X]$. For any $0 \leq \delta \leq 1$:
$$\mathbb{P}(X \geq (1 + \delta)\mu) \leq e^{-\frac{\delta^2\mu}{3}}$$
and
$$\mathbb{P}(X \leq (1 - \delta)\mu) \leq e^{-\frac{\delta^2\mu}{2}}$$

What this gives us is a tighter upper bound (more accurate). We would want to use this if $X$ is a sum of independent Bernoulli variables and if the number of events is large (30+, but the accuracy gets better the larger).

We can find the right and left tail with this.

Assume we have:
- $n$ people
- probability of event is $m$
- and we want to find the probability of the event not being within $a\%$ of the true value

We want to compute:
$$P(X \geq n(m - a)) \quad \text{and} \quad P(X \leq n(m + a))$$

All we have to do from here is solve for $(1 + \delta)\mu$. Since we are working with Bernoulli random variables we just need to find $\delta$:
$$\delta = \frac{n(m \pm a)}{\mu} - 1$$

Then to find the probability of both tails:
$$P(E) = P(X < n(m - a)) + P(X > n(m + a))$$

## Related
- [[Expectation]]
- [[Hoeffding's Inequality]]
- [[Markov Inequality]]
- [[Normal Random Variable]]
