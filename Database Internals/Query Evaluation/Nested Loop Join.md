# Database Internals: Nested Loop Join

**Nested loop join** is the most straightforward join algorithm. It iterates over every pair of tuples from the two relations to find matches. There are three variants, each refining memory usage to reduce the number of times the inner relation must be re-read from disk.

## Tuple-Based Nested Loop Join

The simplest variant reads one tuple at a time from the outer relation and scans the entire inner relation for each.

For $R \bowtie S$, where $R$ is the **outer relation** and $S$ is the **inner relation**:
- **Cost**: $B(R) + T(R) \cdot B(S)$
- This is a **multiple-pass algorithm** — $S$ is re-read once for every tuple in $R$, which is $T(R)$ times total.

```java
for each tuple t_1 in R do:
    for each tuple t_2 in S do:
        if t_1 and t_2 join then output(t1, t2)
```

The cost is extremely high because even a modestly large $T(R)$ results in thousands of full scans of $S$. For example, if $T(R) = 10{,}000$ and $B(S) = 500$, the cost is $B(R) + 10{,}000 \times 500 = B(R) + 5{,}000{,}000$ I/Os.

## Page-at-a-Time Refinement

The **page-at-a-time refinement** iterates over pages of $R$ rather than individual tuples, reducing the number of full scans of $S$ from $T(R)$ down to $B(R)$. For every page of $R$ loaded into memory, we scan all pages of $S$ once and join all tuple pairs from those two pages.

**Cost**: $B(R) + B(R) \cdot B(S)$

```java
for each page of tuples r in R do
    for each page of tuples s in S do
        for all pairs of tuples t1 in r, t2 in s
            if t1 and t2 join then output(t1, t2)
```

This is strictly better than the tuple-based variant since $B(R) \leq T(R)$. It is most efficient when the outer relation is small and is often combined with an index on the inner relation to skip pages of $S$ that cannot contain matches.

## Block-Memory Refinement

The **block-memory refinement** (also called the **chunk-based** or **buffer-aware** nested loop) loads $M - 1$ pages of $R$ into memory at once, using all available buffer frames. This reduces the number of full scans of $S$ to $\lceil B(R) / (M-1) \rceil$, because each scan of $S$ now clears a chunk of $M-1$ pages from $R$ rather than just one page.

- In practice, a hash table is built over the $M-1$ pages of $R$ held in memory, so probing with each $S$ tuple is $O(1)$ rather than a linear scan.
- Efficient when the outer relation is small relative to memory.

**Cost**: $B(R) + B(S) \cdot \left\lceil \dfrac{B(R)}{M-1} \right\rceil$

```java
for each group of ceil(M-1) pages r in R do
    for each page of tuples s in S do
        for all pairs of tuples t1 in r, t2 in s
            if t1 and t2 join then output(t1, t2)
```

![[Block Memory Refinement.png]]

The intuition: with $M$ buffer pages, we use $M-1$ for chunks of $R$ and 1 for streaming pages of $S$. The larger the chunk of $R$ we can hold, the fewer times we need to re-read all of $S$. When $M-1 \geq B(R)$, the entire outer relation fits in memory and $S$ is only read once, making the cost $B(R) + B(S)$ — equivalent to a one-pass algorithm.

## Comparison

| Variant | Cost | Notes |
|---|---|---|
| Tuple-based | $B(R) + T(R) \cdot B(S)$ | Worst; re-reads $S$ per tuple |
| Page-at-a-time | $B(R) + B(R) \cdot B(S)$ | Better; re-reads $S$ per page of $R$ |
| Block-memory | $B(R) + B(S) \cdot \lceil B(R)/(M-1) \rceil$ | Best; loads $M-1$ pages of $R$ at once |

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Nested Loop Join (Block-Memory) | Block Nested Loop Join (BNL) |
| Outer relation | Driver table / build side |
| Inner relation | Probe table / lookup side |
| Page-at-a-time | Page Nested Loop Join |

## Related

- [[Database Internals/Query Evaluation/Operator Algorithms|Operator Algorithms]] — overview of all algorithm families and cost parameters
- [[Database Internals/Query Evaluation/Single-Pass Hash Join|Single-Pass Hash Join]] — more efficient one-pass alternative
- [[Database Internals/Query Evaluation/Index-Based Algorithms|Index-Based Algorithms]] — index nested loop join uses an index to skip inner scans
