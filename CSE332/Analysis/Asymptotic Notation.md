# CSE 332: Asymptotic Notation

**[[Asymptotic Notation]]** is a mathematical tool used to describe the limiting behavior of a function, particularly for comparing algorithm running times as the input size $n$ grows.

## Big-O, Big-Omega, and Big-Theta
- **[[Big-O]]** ($O(g(n))$): Represents an **upper bound**. It is the set of functions with asymptotic behavior less than or equal to $g(n)$.
  - **Formal Definition**: $f \in O(g(n)) \equiv \exists c > 0 . \exists n_0 > 0 . \forall n \ge n_0 . f(n) \le c \cdot g(n)$
- **[[Big-Omega]]** ($\Omega(g(n))$): Represents a **lower bound**. It is the set of functions with asymptotic behavior greater than or equal to $g(n)$.
  - **Formal Definition**: $f \in \Omega(g(n)) \equiv \exists c > 0 . \exists n_0 > 0 . \forall n \ge n_0 . f(n) \ge c \cdot g(n)$
- **[[Big-Theta]]** ($\Theta(g(n))$): Represents a **tight bound**. A function is in Big-Theta if it is both upper-bounded and lower-bounded by the same function (up to constant factors).
  - **Formal Definition**: $\Theta(g(n)) \equiv \Omega(g(n)) \cap O(g(n))$

## Proving Asymptotic Bounds
To prove $f(n) \in O(g(n))$, you must find specific constants $c$ and $n_0$ that satisfy the definition.

**Example**: Show $10n + 100 \in O(n^2)$
- Let $c = 10$ and $n_0 = 6$.
- We must show $\forall n \ge 6 . 10n + 100 \le 10n^2$
- Divide by 10: $n + 10 \le n^2$
- Rearrange: $10 \le n^2 - n \implies 10 \le n(n-1)$
- Since $n \ge 6$, $n(n-1) \ge 6(5) = 30$. Since $30 \ge 10$, the inequality holds.

To prove that a function is *not* in a bound (e.g., $n^2 \notin O(n)$), you typically use a Proof by Contradiction, showing that no constant $c$ could satisfy the inequality for all $n \ge n_0$ as $n$ grows infinitely large.

## Simplification Rules
When doing asymptotic analysis:
1. Ignore lower-order terms (e.g., $n^2 + n \implies n^2$).
2. Ignore multiplicative constants (e.g., $4n \implies n$).
3. Ignore bases of logarithms (since they differ by a constant factor).
4. **Do NOT ignore**: Non-multiplicative/non-additive constants (like exponents) and the logarithms themselves.

## Common Complexity Categories
- $O(1)$: Constant
- $O(\log n)$: Logarithmic
- $O(n)$: Linear
- $O(n \log n)$: Log-linear
- $O(n^2)$: Quadratic
- $O(n^3)$: Cubic
- $O(n^k)$: Polynomial
- $O(k^n)$: Exponential

## Related
- [[Algorithm Analysis]]