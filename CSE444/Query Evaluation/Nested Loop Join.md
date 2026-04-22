# CSE444: Nested Loop Join

**Nested loop join** is the most straightforward join algorithm. It iterates over every pair of tuples from the two relations. There are three variants, each refining memory usage.

## Tuple-Based Nested Loop Join

$R \bowtie S$, where $R$ is the **outer relation** and $S$ is the **inner relation**:
- Time complexity: $O(n^2)$
- **Cost**: $B(R) + T(R) \cdot B(S)$
- This is a **multiple-pass algorithm** — $S$ is re-read once for every tuple in $R$

```java
for each tuple t_1 in R do:
    for each tuple t_2 in S do:
        if t_1 and t_2 join then output(t1, t2)
```

## Page-at-a-Time Refinement

The **page-at-a-time refinement** iterates over pages rather than individual tuples, reducing the number of times $S$ is scanned from $T(R)$ to $B(R)$.

**Cost**: $B(R) + B(R) \cdot B(S)$

```java
for each page of tuples r in R do
    for each page of tuples s in S do
        for all pairs of tuples t1 in r, t2 in s
            if t1 and t2 join then output(t1, t2)
```

This is strictly better than tuple-based nested loop join since $B(R) \leq T(R)$.

## Block-Memory Refinement

The **block-memory refinement** loads $M - 1$ pages of $R$ into memory at once, reducing the number of times $S$ must be scanned to $\lceil B(R) / (M-1) \rceil$. In-memory operations are free, so holding $M - 1$ pages from $R$ in memory costs nothing once loaded.

**Cost**: $B(R) + B(S) \cdot \left\lceil \dfrac{B(R)}{M-1} \right\rceil$

```java
for each group of ceil(M-1) pages r in R do
    for each page of tuples s in S do
        for all pairs of tuples t1 in r, t2 in s
            if t1 and t2 join then output(t1, t2)
```

![[CSE444/Screenshots/Block Memory Refinement.png]]

## Comparison

| Variant | Cost | Notes |
|---|---|---|
| Tuple-based | $B(R) + T(R) \cdot B(S)$ | Worst; re-reads $S$ per tuple |
| Page-at-a-time | $B(R) + B(R) \cdot B(S)$ | Better; re-reads $S$ per page of $R$ |
| Block-memory | $B(R) + B(S) \cdot \lceil B(R)/(M-1) \rceil$ | Best; loads $M-1$ pages of $R$ at once |

## Related

- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families
- [[CSE444/Query Evaluation/Hash Join|Hash Join]] — more efficient one-pass alternative
- [[CSE444/Query Evaluation/Index-Based Algorithms|Index-Based Algorithms]] — index nested loop join uses an index to skip inner scans
