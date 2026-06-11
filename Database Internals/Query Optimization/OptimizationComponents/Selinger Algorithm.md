# Database Internals: Selinger Algorithm

The **Selinger Algorithm** (from the 1979 System R paper) is a cost-based query optimization algorithm that extends [[Database Internals/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]] with the concept of **interesting orders** to jointly enumerate logical and physical plans.

## Core Idea

- Considers different logical and physical plans simultaneously.
- Cost of a plan = **I/O + CPU**.
- Introduces the concept of **interesting orders** during plan enumeration, which allows the optimizer to keep sub-optimal (by raw cost) plans that produce useful sorted output for later operators.

## Interesting Orders

Some query plans produce output in a sorted order (e.g., a scan over a clustered index, or a sort-merge join). This sorted output is called an **interesting order** if it benefits a later operator — specifically:
- An order matching an `ORDER BY` or `GROUP BY` clause.
- An order on join attributes appearing in equi-join predicates, enabling cheaper sort-merge joins downstream that would otherwise require an explicit sort step.

**Key insight**: For each subset of relations, the optimizer keeps multiple optimal plans — the cheapest overall plan, plus the cheapest plan for each interesting order. This increases the number of plans stored by a factor of $k + 1$ (where $k$ is the number of interesting orders), but allows a plan that is slower now to be retained when it produces sorted output that saves work later in the pipeline.

For example, a sort-merge join on attribute $A$ costs more upfront than a hash join, but if $A$ is also an `ORDER BY` attribute or a subsequent join attribute, the sort-merge join's sorted output eliminates a later sort step — making the total cost lower.

## Selinger Optimizer Design

### Why Left-Deep Plans Only?

The Selinger optimizer restricts the search space to **[[Database Internals/Query Optimization/OptimizationComponents/Join Trees#Left-Deep Join Trees|left-deep join trees]]**:

- **Fits standard pipelined join algorithms**: In a left-deep tree, the inner (right) relation is always a base relation, which works well with nested-loop and hash join implementations.
- **More memory-efficient with one-pass joins**:
  - `((R ⋈ S) ⋈ T)`: reuses the space allocated for $R$ while joining the result with $T$.
  - `(R ⋈ (S ⋈ T))`: must hold $R$ in memory while computing $S \bowtie T$, then join — memory requirements grow with the number of relations.
- **Better for nested-loop joins under the iterator model**:
  - `((R ⋈ S) ⋈ T)`: reads chunks of $(R \bowtie S)$ once; reads the stored base relation $T$ multiple times from disk.
  - `(R ⋈ (S ⋈ T))`: reads chunks of $R$ once; but the computed relation $(S \bowtie T)$ must be read multiple times — requiring either more memory to hold it or more disk I/Os to re-read it.

### Additional Heuristics

- Push selections down as early as possible.
- Never consider Cartesian products (only join pairs that share a predicate).

## General Algorithm

1. **Single relations**: Enumerate all access paths (file scan or index scan); keep the cheapest plan for each interesting order.
2. **Pairs of relations**: Use single-relation results as the outer relation; consider every other relation as the inner; estimate cost for sort-merge join and nested-loop join; keep the cheapest plan for each interesting order.
3. **Larger subsets**: Repeat for 3, 4, … relations using cached results from the previous step.

### Example from the Selinger Paper

For each subset, the optimizer retains both the cheapest plan overall and any plan with an interesting order, for potential use by later joins.

![[Example from selinger paper 1.png]]
![[Example from selinger paper 2.png]]

## OrderJoins Pseudocode

```
OrderJoins(R):
  R = set of relations to join
  For d = 1 to N:            // N = |R|
    for S in {all size-d subsets of R}:
      optjoin(S) = (S - a) ⋈ a,
        where a is the single relation that minimizes:
          cost(optjoin(S - a))
          + min cost to join (S - a) with a
          + min access cost for a

  // Note: optjoin(S - a) is cached from previous iterations
```

The key detail is that `optjoin(S - a)` is always looked up from previously cached results — this is what makes the algorithm dynamic programming rather than a brute-force enumeration.

### Example: OrderJoins(A, B, C, D) — All Nested-Loop Joins

![[orderJoins ex1.png]]
![[orderJoins ex2.1.png]]
![[order-join ex2.2.png]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Selinger Algorithm | System R optimizer / Selinger-style CBO |
| Interesting Order | Interesting order / physical property |
| Left-Deep plan | Left-deep tree / linear join plan |

## Related

- [[Database Internals/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]] — the general DP framework this algorithm builds on
- [[Database Internals/Query Optimization/OptimizationComponents/Join Trees|Join Trees]] — left-deep, right-deep, and bushy tree shapes
- [[Database Internals/Query Optimization/OptimizationComponents/Cost Estimation|Cost Estimation]] — how plan costs are estimated
- [[Database Internals/Query Optimization/Query Optimization|Query Optimization]] — overview
