# CSE 332: Recurrences

A **[[Recurrence Relation]]** is a mathematical equation that defines a function in terms of its value on smaller inputs. It is the primary tool used for analyzing the running time of recursive algorithms.

## Anatomy of a Recurrence
The running time of a recursive algorithm can be written as:
$$T(n) = T(p_1) + T(p_2) + \dots + T(p_x) + f(n)$$
- $T(p_i)$: The time to run the algorithm on smaller subproblems of sizes $p_1, \dots, p_x$.
- $f(n)$: The non-recursive work done in the current stack frame (e.g., splitting the data, combining results).

## Solving Recurrences: The Tree Method
The **Tree Method** is a technique to solve recurrences by unrolling them into a tree structure.
1. Draw a picture of the recursion tree.
2. Identify the non-recursive work done at each node.
3. Sum the work level by level.
4. Sum all the levels to get the final running time.

### Chip and Conquer
Form: $T(n) = aT(n - b) + f(n)$
- $a$ is the branching factor (number of recursive calls).
- The input size decreases by $b$ at each level.
- **Height of the tree**: $n/b$ (the number of times we can subtract $b$ until we reach the base case).

**Example**: $T(n) = T(n-1) + 1$ (e.g., recursive linear search).
- Branching factor $a = 1$. Work per node is $1$.
- Height is $n$.
- Total work = $n \times 1 = \Theta(n)$.

### Divide and Conquer
Form: $T(n) = aT(n/b) + f(n)$
- $a$ is the branching factor.
- The input size is divided by $b$ at each level.
- **Height of the tree**: $\log_b n$ (the number of times we can divide by $b$ until we reach the base case).

**Example**: $T(n) = 2T(n/2) + c$ (e.g., finding sum by recursively halving).
- At level $i$, there are $2^i$ nodes.
- Work per node is $c$. Work at level $i$ is $2^i \cdot c$.
- The height of the tree is $\log_2 n$.
- Total work = $\sum_{i=1}^{\log_2 n} 2^i \cdot c = c(2^{\log_2 n + 1} - 1) = \Theta(n)$.

## Finite Geometric Series
When summing work across levels, you frequently encounter finite geometric series:
$$ \sum_{i=0}^{L} a^i = \frac{a^{L+1} - 1}{a - 1} $$
If the ratio $a > 1$, the series is dominated by the last term. If $a < 1$, the series is bounded by a constant.

## Related
- [[Algorithm Analysis]]