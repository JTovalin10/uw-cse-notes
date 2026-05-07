# CSE 332: Asymptotic Notation

**[[Asymptotic Notation]]** is a mathematical tool used to describe the limiting behavior of a function, particularly for comparing algorithm running times as the input size $n$ grows.

## Big-O, Big-Omega, and Big-Theta
- **Big-O** ($O(g(n))$): Represents an **upper bound**. It is the set of functions with asymptotic behavior less than or equal to $g(n)$.
  - **Formal Definition**: $f \in O(g(n)) \equiv \exists c > 0 . \exists n_0 > 0 . \forall n \ge n_0 . f(n) \le c \cdot g(n)$
- **Big-Omega** ($\Omega(g(n))$): Represents a **lower bound**. It is the set of functions with asymptotic behavior greater than or equal to $g(n)$.
  - **Formal Definition**: $f \in \Omega(g(n)) \equiv \exists c > 0 . \exists n_0 > 0 . \forall n \ge n_0 . f(n) \ge c \cdot g(n)$
- **Big-Theta** ($\Theta(g(n))$): Represents a **tight bound**. A function is in Big-Theta if it is both upper-bounded and lower-bounded by the same function (up to constant factors).
  - **Formal Definition**: $\Theta(g(n)) \equiv \Omega(g(n)) \cap O(g(n))$

---

## Proving Asymptotic Bounds
To prove $f(n) \in O(g(n))$, you must find specific constants $c$ and $n_0$ that satisfy the definition.

### Example: Show $10n + 100 \in O(n^2)$
- Let $c = 10$ and $n_0 = 6$.
- We must show $\forall n \ge 6 . 10n + 100 \le 10n^2$
- Divide by 10: $n + 10 \le n^2$
- Rearrange: $10 \le n^2 - n \implies 10 \le n(n-1)$
- Since $n \ge 6$, $n(n-1) \ge 6(5) = 30$. Since $30 \ge 10$, the inequality holds.

### Example: Show $n^2 \notin O(n)$ (Proof by Contradiction)
1. Assume $n^2 \in O(n)$. By definition, $\exists c, n_0 > 0$ such that $\forall n > n_0, n^2 \le cn$.
2. For all $n > n_0 > 0$, we can divide by $n$: $n \le c$.
3. This implies that $c$ is lower-bounded by $n$. Since $n$ can grow infinitely large, $c$ cannot be a constant.
4. **Contradiction**: Therefore, $n^2 \notin O(n)$.

---

## Simplification Rules & Intuition
When doing asymptotic analysis:
1. **Summation**: Ignore all but the "biggest" term. If $f(n)$ grows faster than $g(n)$, then $f(n) + g(n) \in \Theta(f(n))$.
2. **Multiplicative Constants**: Ignore them (e.g., $4n + 5 \in \Theta(n)$).
3. **Logarithms**:
   - Ignore bases of logarithms (since $\log_a n = \frac{\log_b n}{\log_b a}$, and $1/\log_b a$ is a constant).
   - **Do NOT** ignore the logarithms themselves.
4. **Exponents**: Do NOT ignore non-multiplicative/non-additive constants in exponents (e.g., $3^n$ vs $2^n$).

### Intuition Examples
- $4n + 5 \in \Theta(n)$
- $0.5n \log n + 2n + 7 \in \Theta(n \log n)$
- $n^3 + 2^n + 3^n \in \Theta(3^n)$
- $n \log(10n^2) \in \Theta(n \log n)$ (since $\log(10n^2) = \log 10 + 2 \log n$)

---

## Common Complexity Categories

| Notation      | Name        | Code Example                      | Algorithm Examples               |
| :------------ | :---------- | :-------------------------------- | :------------------------------- |
| $O(1)$        | Constant    | `int val = arr[0];`               | Array indexing, stack push/pop   |
| $O(\log n)$   | Logarithmic | `while (n > 1) { n /= 2; }`       | Binary search, balanced BST find |
| $O(n)$        | Linear      | `for (int i=0; i<n; i++) { ... }` | Linear search, summing array     |
| $O(n \log n)$ | Log-Linear  | `sort(arr);`                      | Merge Sort, Quick Sort (avg)     |
| $O(n^2)$      | Quadratic   | Nested `for` loops                | Bubble Sort, Selection Sort      |
| $O(n^3)$      | Cubic       | 3x Nested `for` loops             | Naive matrix multiplication      |
| $O(2^n)$      | Exponential | `fib(n-1) + fib(n-2)`             | Recursive Fibonacci              |
| $O(n!)$       | Factorial   | Generating permutations           | Naive Traveling Salesperson      |

## Related
- [[Algorithm Analysis|Algorithm Analysis]]
- [[Definitions/Recurrence Relation|Recurrence Relation]]
