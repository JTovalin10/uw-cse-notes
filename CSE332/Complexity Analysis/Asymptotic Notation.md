# CSE 332: Asymptotic Notation

**Asymptotic Notation** is a mathematical tool used to describe the limiting behavior of a function, particularly for comparing algorithm running times as the input size $n$ grows.

## Big-O, Big-Omega, and Big-Theta
- **Big-O** ($O(g(n))$): Represents an **upper bound**. It is the set of functions with asymptotic behavior less than or equal to $g(n)$.
  - **Formal Definition**: $f(n) \in O(g(n)) \equiv \exists c > 0, n_0 > 0 . \forall n \ge n_0 . f(n) \le c \cdot g(n)$
- **Big-Omega** ($\Omega(g(n))$): Represents a **lower bound**. It is the set of functions with asymptotic behavior greater than or equal to $g(n)$.
  - **Formal Definition**: $f(n) \in \Omega(g(n)) \equiv \exists c > 0, n_0 > 0 . \forall n \ge n_0 . f(n) \ge c \cdot g(n)$
- **Big-Theta** ($\Theta(g(n))$): Represents a **tight bound**. A function is in Big-Theta if it is both upper-bounded and lower-bounded by the same function (up to constant factors).
  - **Formal Definition**: $\Theta(g(n)) \equiv \Omega(g(n)) \cap O(g(n))$

---

## Comparing Growth Rates

### The Hierarchy of Growth
Ordered from slowest growing (fastest algorithm) to fastest growing (slowest algorithm):
$$1 < \log \log n < \log n < \sqrt{n} < n < n \log n < n^2 < n^3 < 2^n < n! < n^n$$

### Limit Test
A formal way to compare the growth of $f(n)$ and $g(n)$ is to take the limit as $n \to \infty$:
$$ L = \lim_{n \to \infty} \frac{f(n)}{g(n)} $$
- If $L = 0$: $f(n) \in O(g(n))$ but $f(n) \notin \Theta(g(n))$ (i.e., $f$ grows strictly slower).
- If $L = c$ (constant): $f(n) \in \Theta(g(n))$.
- If $L = \infty$: $f(n) \in \Omega(g(n))$ but $f(n) \notin \Theta(g(n))$ (i.e., $f$ grows strictly faster).

### L'Hôpital's Rule
If the limit results in $\frac{\infty}{\infty}$, you can take the derivative of the numerator and denominator:
$$ \lim_{n \to \infty} \frac{f(n)}{g(n)} = \lim_{n \to \infty} \frac{f'(n)}{g'(n)} $$
*Example*: Compare $f(n) = \ln n$ and $g(n) = n$.
$$ \lim_{n \to \infty} \frac{\ln n}{n} \xrightarrow{L'H} \lim_{n \to \infty} \frac{1/n}{1} = 0 \implies \ln n \in O(n) $$

---

## Proving Asymptotic Bounds
To prove $f(n) \in O(g(n))$, you must find specific constants $c$ and $n_0$ that satisfy the definition.

### Example: Show $10n + 100 \in O(n^2)$
- Let $c = 10$ and $n_0 = 10$.
- We must show $\forall n \ge 10 . 10n + 100 \le 10n^2$
- Since $n \ge 10$, $10n^2 \ge 100n$. Since $100n \ge 10n + 100$ for $n \ge 2$, the inequality holds.

### Example: Show $n^2 \notin O(n)$ (Proof by Contradiction)
1. Assume $n^2 \in O(n)$. By definition, $\exists c, n_0 > 0$ such that $\forall n > n_0, n^2 \le cn$.
2. For all $n > n_0 > 0$, we can divide by $n$: $n \le c$.
3. This implies that $c$ is lower-bounded by $n$. Since $n$ can grow infinitely large, $c$ cannot be a constant.
4. **Contradiction**: Therefore, $n^2 \notin O(n)$.

---

## Related
- [[CSE332/Complexity Analysis/Algorithm Analysis|Algorithm Analysis]]
- [[CSE332/Complexity Analysis/Recurrences|Recurrences]]
- [[CSE332/CSE332 Index|CSE332 Index]]

