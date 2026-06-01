# CSE 332: Amortized Analysis

**Amortized Complexity** is the maximum total number of steps an algorithm takes on $M$ "most challenging" consecutive inputs, divided by $M$. Unlike worst-case analysis, which looks at a single operation, amortized analysis considers the average cost of a sequence of operations.

---

## The Parking Lot Analogy
> [!TIP] Intuition
> Suppose a parking lot charges $10 per day. 
> - **Scenario 1 (Worst-Case)**: You pay $10 every day. Average cost: **$10/day**.
> - **Scenario 2 (Amortized)**: You don't pay and get a $25 fine every 3 days.
>   - Day 1: $0
>   - Day 2: $0
>   - Day 3: $25 (fine)
>   - Total: $25 over 3 days $\approx$ **$8.33/day**.
> 
> Even though one specific day cost $25, the **amortized** cost over the sequence is lower.

---

## Example: ArrayList Resizing
When adding to an `ArrayList`, the operation is usually $\Theta(1)$. However, if the internal array is full, we must `resize()`, which takes $\Theta(n)$ time to copy elements.

```java
public void add(T value) {
    if (size == data.length) {
        resize(); // Occasional O(n) operation
    }
    data[size] = value;
    size++; // Usually O(1)
}

private void resize() {
    T[] oldData = data;
    data = (T[]) new Object[data.length * 2]; // Doubling strategy
    for (int i = 0; i < oldData.length; i++) {
        data[i] = oldData[i];
    }
}
```

### Analysis
Suppose we start with an array of size $1$ and do $n$ insertions ($n$ is a power of 2):
- **Resizes** occur at $n = 1, 2, 4, 8, \dots$.
- Total cost of resizes: $1 + 2 + 4 + 8 + \dots + n/2 = n - 1$.
- Total cost of $n$ insertions: $n$ (for the insertions) $+ (n-1)$ (for the resizes) $\approx 2n$.
- **Amortized Cost**: $2n / n = 2 \implies \Theta(1)$.

> [!WARNING]
> This only works if we **double** the size. If we increase by a constant (e.g., `+10`), the amortized cost becomes $\Theta(n)$.

## Related
- [[Algorithm Analysis]]
- [[Priority Queues]]
