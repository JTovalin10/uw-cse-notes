# CSE 332: Algorithm Analysis

## Resource Analysis
**Resource Analysis**: A process that maps an algorithm's input size to a count of resources used. This allows us to compare algorithms theoretically, independent of specific implementations, hardware, or languages.

When doing resource analysis, we define a function where:
- **Input**: Size of the input (e.g., number of items in a list, number of characters in a string).
- **Output**: Count of resources used (e.g., number of primitive operations like arithmetic ops, comparisons, or maximum memory bytes used).

## Complexity Types
Algorithms can be analyzed under different scenarios:
- **Worst-case Complexity**: The maximum number of steps an algorithm takes on the "most challenging" input of size $n$.
- **Best-case Complexity**: The minimum number of steps an algorithm takes on the "easiest" input of size $n$.
- **Average Complexity** / Expected complexity: The average number of steps an algorithm takes on random inputs. This is context and distribution-dependent.
- **Amortized Complexity**: The maximum total number of steps an algorithm takes on $M$ "most challenging" consecutive inputs, divided by $M$.
  - *Example*: In an `ArrayList`, the `add(value)` operation has a worst-case time of $O(n)$ if the array needs to resize. However, because resizing guarantees additional capacity, the average cost over a sequence of operations across $n$ adds is constant. Thus, the amortized running time is $O(1)$.

## Counting Operations
When calculating running times, we generally follow these rules:
- **Consecutive statements**: Add the times together.
- **Loops**: Sum the time required for each iteration. If every iteration takes the same amount of time, it is $[ \text{time per loop} \times \text{number of iterations} ]$.
- **Conditionals**: Sum the time to check the condition and the time of the slowest branch.
- **Function Calls**: Time of the function's body.
- **Recursion**: Set up and solve a **[[Recurrence Relation]]**.

### Example
```java
for (i = 0; i < n.size(); i++) {
    b++;
}
if (b % 2 == 0) {
    c++;
} else {
    for (i = 0; i < n.size(); i++) {
        c++;
    }
}
```
- First loop: $n$ times.
- Conditional check: $1$ op.
- Slowest branch (the `else` block): $n$ times.
- Total worst-case operations: $\approx 2n + \text{constants}$. Thus, the running time is $O(n)$.

## Related
- [[Asymptotic Notation]]
- [[Recurrences]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Induction|Math: Induction]]