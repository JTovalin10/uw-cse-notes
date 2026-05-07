# CSE 332: Recurrences

A **[[Recurrence Relation]]** is a mathematical equation that defines a function in terms of its value on smaller inputs. It is the primary tool used for analyzing the running time of recursive algorithms.

## Anatomy of a Recurrence
The running time of a recursive algorithm can be written as:
$$T(n) = T(p_1) + T(p_2) + \dots + T(p_x) + f(n)$$
- $T(p_i)$: The time to run the algorithm on smaller subproblems of sizes $p_1, \dots, p_x$.
- $f(n)$: The non-recursive work done in the current stack frame (splitting, combining, etc.).

---

## Solving Recurrences: The Tree Method
The **Tree Method** is a technique to solve recurrences by unrolling them into a tree structure.
1. **Draw the Tree**: Represent the recursion as a tree.
2. **Determine Work per Node**: Identify the non-recursive work $f(n)$ at each level.
3. **Analyze Tree Properties**:
   - **Branching factor** ($a$): Number of recursive calls per node.
   - **Height**: Number of levels until reaching the base case.
4. **Sum Levels**: Calculate the total work done at level $i$.
5. **Sum Total**: Total work is $\sum_{i=0}^{\text{height}} (\text{Work at level } i)$.

### Chip and Conquer
Form: $T(n) = aT(n - b) + f(n)$
- **Height**: $n/b$ (number of times we subtract $b$ to reach 0).
- **Example: Recursive Linear Search** ($T(n) = T(n-1) + 1$)
  ```java
  private static boolean linearSearch(List<Integer> lst, int k, int start, int end) {
      if (start == end) return false;
      if (lst.get(start) == k) return true;
      return linearSearch(lst, k, start + 1, end);
  }
  ```
  - Work per level: $1$. Total levels: $n$.
  - **Total Work**: $\sum_{i=1}^n 1 = \Theta(n)$.

### Divide and Conquer
Form: $T(n) = aT(n/b) + f(n)$
- **Height**: $\log_b n$ (number of times we divide by $b$ to reach 1).
- **Example 1: Recursive Binary Search** ($T(n) = T(n/2) + 1$)
  ```java
  private static boolean binarySearch(List<Integer> lst, int k, int start, int end) {
      if (start == end) return false;
      int mid = start + (end - start) / 2;
      if (lst.get(mid) == k) return true;
      return (lst.get(mid) > k) ? binarySearch(lst, k, start, mid) : binarySearch(lst, k, mid + 1, end);
  }
  ```
  - Work per level: $1$. Total levels: $\log_2 n$.
  - **Total Work**: $\Theta(\log n)$.

- **Example 2: Recursive List Summation** ($T(n) = 2T(n/2) + c$)
  - Work at level $i$: $2^i \times c$.
  - **Total Work**: $\Theta(n)$.

---

## Common Recurrence Examples
- **$T(n) = 2T(n/2) + n$** (Merge Sort):
  - Work at level $i$: $2^i \times (n/2^i) = n$.
  - Total: $\sum_{i=0}^{\log_2 n} n = n \log_2 n = \Theta(n \log n)$.
- **$T(n) = 2T(n/2) + n^2$**:
  - Work at level $i$: $2^i \times (n/2^i)^2 = n^2 / 2^i$.
  - Total: $n^2 \sum (1/2)^i$. Geometric series ratio $< 1 \implies \Theta(n^2)$.
- **$T(n) = 2T(n/8) + 1$**:
  - Work at level $i$: $2^i$.
  - Total: $\sum_{i=0}^{\log_8 n} 2^i \implies \Theta(n^{\log_8 2}) = \Theta(\sqrt[3]{n})$.

---

## Finite Geometric Series
$$ \sum_{i=0}^{L} a^i = \frac{a^{L+1} - 1}{a - 1} $$
- **If $a > 1$**: Dominated by the **last term** ($a^L$).
- **If $a < 1$**: Bounded by a constant ($\frac{1}{1-a}$).
- **If $a = 1$**: Simply $L+1$.

## Related
- [[Algorithm Analysis]]
- [[Definitions/Recurrence Relation|Recurrence Relation]]
