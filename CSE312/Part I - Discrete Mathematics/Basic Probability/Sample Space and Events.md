# CSE 312: Sample Space and Events

## Sample Space
A **sample space** $\Omega$ is the set of all possible outcomes of an experiment. 
- "Outcome" is the word for a single element of $\Omega$.
- Example: For a single coin flip, $\Omega = \{H, T\}$.
- Example: For a normal die, $\Omega = \{1, 2, 3, 4, 5, 6\}$.

## Events
An **event** $E \subseteq \Omega$ is a subset of possible outcomes.
- Example: Getting an even number on a die roll $E = \{2, 4, 6\}$.

## Probability Space
A (discrete) probability space is a pair $(\Omega, \mathbb{P})$ where:
- $\Omega$ is the sample space.
- $\mathbb{P}: \Omega \to [0, 1]$ is the probability measure.
- $\mathbb{P}$ satisfies:
  - $\mathbb{P}(x) \ge 0$ for all $x$.
  - $\sum_{x \in \Omega} \mathbb{P}(x) = 1$.
  - If $E, F \subseteq \Omega$ and $E \cap F = \emptyset$, then $\mathbb{P}(E \cup F) = \mathbb{P}(E) + \mathbb{P}(F)$.

For an event $E$, the probability is defined as $\mathbb{P}(E) = \sum_{\omega \in E} \mathbb{P}(\omega)$.

## Related

- [[Mutual Exclusion]]
- [[Conditional Probability]]
