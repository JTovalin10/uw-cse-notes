# CSE 312: Independence

Two events are **independent** if:

$$P(A \cap B) = P(A)\,P(B)$$

This means that event $A$ cannot impact the result of event $B$.

## Advanced Forms of Independence

- **Conditional Independence:** Two events $A$ and $B$ are conditionally independent given $C$ if:
  $$\mathbb{P}(A \cap B \mid C) = \mathbb{P}(A \mid C) \cdot \mathbb{P}(B \mid C)$$
- **Pairwise Independence:** A set of events $A_1, A_2, \dots, A_n$ are pairwise independent if for all $i, j$ ($i \neq j$):
  $$\mathbb{P}(A_i \cap A_j) = \mathbb{P}(A_i) \cdot \mathbb{P}(A_j)$$
- **Mutual Independence:** A set of events $A_1, A_2, \dots, A_n$ are mutually independent if for every subset $\{i_1, i_2, \dots, i_k\}$ of $\{1, 2, \dots, n\}$:
  $$\mathbb{P}(A_{i_1} \cap A_{i_2} \cap \dots \cap A_{i_k}) = \mathbb{P}(A_{i_1}) \cdot \mathbb{P}(A_{i_2}) \cdots \mathbb{P}(A_{i_k})$$

## Independence of Random Variables

Two random variables $X$ and $Y$ are independent if for all possible values $x$ and $y$:
$$\mathbb{P}(X = x, Y = y) = \mathbb{P}(X = x)\mathbb{P}(Y = y)$$

Mutual independence for random variables simplifies slightly compared to events: $X_1, X_2, \dots, X_n$ are mutually independent if for all $x_1, x_2, \dots, x_n$:
$$\mathbb{P}(X_1 = x_1, \dots, X_n = x_n) = \mathbb{P}(X_1 = x_1) \cdots \mathbb{P}(X_n = x_n)$$
(You do not need to check all subsets for random variables, just all values for the full joint distribution).

[[Mutual Exclusion]]

## Related

- [[Mutual Exclusion]]
- [[Conditional Probability]]
