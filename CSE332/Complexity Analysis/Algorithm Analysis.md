# CSE 332: Algorithm Analysis

## Resource Analysis
**Resource Analysis** is a process that maps an algorithm's input size to a count of resources used. This allows us to compare algorithms theoretically, independent of specific implementations, hardware, or languages.

### Goals
- Identify a function that maps input size to resources used.
- **Domain**: Sizes of the input (e.g., number of characters in a string, number of items in a list).
- **Codomain**: Counts of resources used (e.g., number of primitive operations, memory bytes).

> [!IMPORTANT]
> Always specify the **units** for both the domain and codomain to ensure the analysis is well-defined.

---

## Comparing Running Times
When evaluating multiple algorithms for the same task, we look at their growth rates. Consider three algorithms for the same problem:
- **Algorithm A**: $10n + 900$
- **Algorithm B**: $100n - 50$
- **Algorithm C**: $n^2 / 100$

While Algorithm C might be faster for very small $n$ (due to the small constant), for large $n$, Algorithm A or B will eventually be superior because they are linear ($O(n)$) while Algorithm C is quadratic ($O(n^2)$). Asymptotic analysis helps us focus on this long-term behavior.

---

## Complexity Types
Algorithms can be analyzed under different scenarios:
- **Worst-case Complexity**: The maximum number of steps an algorithm takes on the "most challenging" input of size $n$.
- **Best-case Complexity**: The minimum number of steps an algorithm takes on the "easiest" input of size $n$.
- **Average Complexity**: The average number of steps an algorithm takes on random inputs. This is context and distribution-dependent.
- **[[Amortized Analysis|Amortized Complexity]]**: The maximum total number of steps an algorithm takes on $M$ "most challenging" consecutive inputs, divided by $M$.

---

## Counting Operations
When calculating running times, we count "primitive operations" (arithmetic, comparisons, indexing). When choosing which operations to count, consider:
- **Necessity**: Is the operation necessary to solve the problem?
- **Frequency**: Is it the most frequent operation (up to a constant factor)?
- **Magnitude**: Is the operation expensive to perform?

### General Rules
- **Consecutive statements**: Add the times together.
- **Loops**: Sum the time required for each iteration. If every iteration takes the same amount of time, it is $[\text{time per loop} \times \text{number of iterations}]$.
- **Conditionals**: Sum the time to check the condition and the time of the slowest branch.
- **Function Calls**: Time of the function's body.
- **Recursion**: Set up and solve a **[[Recurrence Relation]]**.

### Example 1: Sequential and Loops
```java
public int sequentialExample(List<Integer> n) {
    int b = 55 + 5; // 1 op
    int c = b / 3;  // 1 op

    for (int i = 0; i < n.size(); i++) {
        b++; // 1 op per iteration (n times)
    }

    if (b % 2 == 0) {
        c++; // 1 op
    } else {
        for (int i = 0; i < n.size(); i++) {
            c++; // 1 op per iteration (n times)
        }
    }
    return c;
}
```
**Total Worst-Case**: $1 + 1 + n + 1 + n = 2n + 3 \implies \Theta(n)$.

### Example 2: Nested Loops
```java
public void nestedExample(List<Integer> n) {
    for (int i = 0; i < n.size(); i++) { // n times
        for (int j = 0; j < n.size(); j++) { // n times
            System.out.println("Hi!"); // 1 op
        }
    }
}
```
**Total Worst-Case**: $n \times n = n^2 \implies \Theta(n^2)$.

---

## Complexity vs. Asymptotic Bounds
**Beware**: Complexity types (Worst, Best, Amortized) are ways to **select** a function, while **[[Asymptotic Notation]]** ($O, \Omega, \Theta$) are ways to **compare** functions. You can mix and match them!

- *"The worst-case running time of my algorithm is $\Omega(n^2)$."* (This is a lower bound on the maximum possible time).
- *"The best-case running time of my algorithm is $O(n)$."* (This is an upper bound on the minimum possible time).

## Related
- [[Asymptotic Notation]]
- [[Recurrences]]
- [[Amortized Analysis]]
- [[Definitions/Load Factor|Load Factor]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Induction|Math: Induction]]
