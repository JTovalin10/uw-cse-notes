# Query Execution: RA Tree Transformations

We can transform an RA tree into a semantically equivalent but structurally different tree to improve query performance — this is the core of **logical query optimization**.

## Transformation Rules

![[Tree Transformations.png]]

![[RA to RA1.png]]
![[RA to RA 2.png]]

Key principles:
- Push selections ($\sigma$) down the tree as early as possible — reduces the number of tuples flowing through subsequent operators
- Push projections ($\pi$) down to eliminate unneeded columns early
- Reorder joins to minimize intermediate result sizes

## The Join Ordering Problem

- Inner joins are **commutative** and **associative** — any order produces the same result
- Joins are usually the most expensive operation an RDBMS performs
- An optimal join order is critical to query performance
- Finding the globally optimal order is **NP-hard**

In practice, the query optimizer uses heuristics and [[Cardinality Estimation|cardinality estimates]] to find a good (not necessarily optimal) join order.

## Related
- [[Relational Algebra]] — RA overview
- [[RA Operators]] — the operators being rearranged
- [[Cardinality Estimation]] — how the optimizer estimates the cost of candidate plans
- [[SQL to RA Translation]] — where the initial tree comes from
