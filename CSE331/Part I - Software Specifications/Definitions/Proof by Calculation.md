# Proof by Calculation

Proving implications is a core step of reasoning about functional code. We need to show that the facts known at a return statement imply the required postcondition.

**Proof by Calculation** proves an implication by showing that an equation or inequality holds. It uses known facts and definitions (e.g., the fact that $len(nil) = 0$).

## Calculation Blocks
A calculation block is a chain of "$=$" or "$\le$" or "$\ge$" that shows the first expression relates to the last expression.

- It is easier to read when split across lines.
- It includes explanations in the right column (e.g., "since x = y", "def of f").
- Each line relates to the previous line via "$=$" or the specified inequality.

Example:
$$
\begin{align*}
x + z &= y + z && \text{since } x = y \\
&\le y + 10 && \text{since } z \le 10 \\
\end{align*}
$$
All together, this proves that $x + z \le y + 10$.

When proving correctness of a method, we write out the returned expression and use calculation blocks to show it equals (or satisfies) the postcondition.
