# CSE344: Main Memory Join Algorithms

**Main memory join algorithms** assume the data fits entirely in main memory. These are the building blocks for [[External Memory Algorithms|external memory algorithms]].

Consider:
$$\text{Payroll} \bowtie_{\text{userid} = \text{userid}} \text{Registry}$$

Let $|\text{Payroll}| = m$ and $|\text{Registry}| = n$.

## Nested Loop Join

The **nested loop join** is the simplest join algorithm — iterate over every tuple pair.

```python
for x in Payroll:
    for y in Registry:
        if x.UserId == y.UserId:
            output(x, y)
```

Runtime: $O(mn)$

## Hash Join

**Hash join** builds a hash table on one relation, then probes it with the other.

```python
ht = new HashTable()
for x in Payroll:
    ht.insert(x.UserId, x)

for y in Registry:
    z = ht.find(y.UserId)
    output(z, y)
```

- Expected runtime: $\Theta(m + n)$
- Best case: $O(m + n)$
- Worst case: $O(mn)$ (degenerate hash collisions)

## Merge Join

**Merge join** sorts both inputs on the join key and merges them in a single pass.

```python
sort(Payroll)
sort(Registry)
x = Payroll.first()
y = Registry.first()
while y != NULL:
    if   x.UserID < y.UserID: advance x
    elif x.UserID = y.UserID: output(x, y); advance both
    elif x.UserID > y.UserID: advance y
```

Runtime: $O(n \log n + m \log m)$

Merge join is particularly efficient when the input relations are already sorted on the join key.

## Related
- [[External Memory Algorithms]] — extensions of these algorithms when data doesn't fit in memory
- [[Parallel Join Algorithms]] — distributed variants (partitioned hash join, broadcast join, skew join)
- [[RA Operators#Join Operators]] — the logical join operators these algorithms implement
- [[Physical Algorithms and Pipelining]] — overview of physical operator classification
- [[Pipelined Execution]] — how these operators plug into the iterator interface
- [[CSE344/SQL/Joins|Joins]] — the SQL surface syntax compiled into these joins
