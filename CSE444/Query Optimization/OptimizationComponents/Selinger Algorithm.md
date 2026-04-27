# CSE444: Selinger Algorithm

The **Selinger Algorithm** (from the 1979 System R paper) is a cost-based query optimization algorithm that extends dynamic programming with the concept of **interesting orders** to jointly enumerate logical and physical plans.

## Core Idea

- Considers different logical and physical plans simultaneously
- Cost of a plan = **I/O + CPU**
- Introduces the concept of **interesting orders** during plan enumeration

## Interesting Orders

Some query plans produce output in a sorted order (e.g., a scan over a clustered index or a sort-merge join). This sorted output is called an **interesting order** if it benefits a later operator — specifically:
- An order matching an `ORDER BY` or `GROUP BY` clause
- An order on join attributes appearing in equi-join predicates, enabling cheaper sort-merge joins downstream

**Key insight**: For each subset of relations, the optimizer keeps multiple optimal plans — the cheapest overall, plus the cheapest plan for each interesting order. This increases complexity by a factor of $k + 1$ (where $k$ = number of interesting orders), but allows a slower plan to be retained when it produces useful sorted output.

## Selinger Optimizer Design

### Why Left-Deep Plans Only?

The Selinger optimizer restricts the search space to **left-deep join trees**:
- Fits well with standard pipelined join algorithms — the inner relation is always a base relation
- More memory-efficient with one-pass joins:
  - `((R ⋈ S) ⋈ T)`: reuses the space for R while joining the result with T
  - `(R ⋈ (S ⋈ T))`: must hold R in memory while computing S ⋈ T, then join — gets worse as the number of relations grows
- Better for nested-loop joins under the iterator model:
  - `((R ⋈ S) ⋈ T)`: reads chunks of (R ⋈ S) once; reads the stored base relation T multiple times from disk
  - `(R ⋈ (S ⋈ T))`: reads chunks of R once; reads the computed relation (S ⋈ T) multiple times — requires more time or more space

### Additional Heuristics

- Push selections down as early as possible
- Never consider Cartesian products (only join pairs that share a predicate)

## General Algorithm

1. **Single relations** — enumerate all access paths (file scan or index scan); keep the cheapest plan for each interesting order.
2. **Pairs of relations** — use single-relation results as the outer relation; consider every other relation as the inner; estimate cost for sort-merge join and nested-loop join; keep the cheapest plan for each interesting order.
3. **Larger subsets** — repeat for 3, 4, … relations using cached results from the previous step.

### Example from the Selinger Paper

For each subset, the optimizer retains both the cheapest plan overall and any plan with an interesting order, for potential use by later joins.

![[CSE444/Screenshots/Example from selinger paper 1.png]]
![[CSE444/Screenshots/Example from selinger paper 2.png]]

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

### Example: OrderJoins(A, B, C, D) — All Nested-Loop Joins

![[CSE444/Screenshots/orderJoins ex1.png]]
![[CSE444/Screenshots/orderJoins ex2.1.png]]
![[CSE444/Screenshots/order-join ex2.2.png]]

---

## Related

- [[CSE444/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]] — the general DP framework this algorithm builds on
- [[CSE444/Query Optimization/OptimizationComponents/Join Trees|Join Trees]] — left-deep, right-deep, and bushy tree shapes
- [[CSE444/Query Optimization/OptimizationComponents/Cost Estimation|Cost Estimation]] — how plan costs are estimated
- [[CSE444/Query Optimization/Query Optimization|Query Optimization]] — overview
