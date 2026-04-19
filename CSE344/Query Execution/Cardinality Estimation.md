# CSE344: Cardinality Estimation

## Logical Query Optimization

### Goal

Equivalent query plans produce equal outputs — but some are far cheaper to execute. The less data circulating inside the tree, the less computation the **RDBMS** does. This includes reducing unnecessary columns or unnecessarily large intermediate results.

![[Example Optimization 1.png]]

### Cost Estimation vs. Cardinality Estimation

Estimating the cost of a candidate query plan involves two steps:
1. **Cardinality estimation**: estimate the sizes of all intermediate relations
2. **Cost estimation**: convert cardinalities into a cost, considering additional factors such as CPU and memory utilization

## Definitions

- $T(R)$ = number of tuples in relation $R$
- $V(R, \text{attr})$ = number of distinct values for `attr` in relation $R$
	- Intuitively: the number of groups produced by `GROUP BY attr`
- The **selectivity factor** $\Theta$ is an operator's size decrease or increase
	- Knowing the selectivity factor is key to estimating a query's cardinality (and cost)
	- If certain assumptions hold, we can derive the selectivity factor from just the operator and the predicate

## Resource Constraints on Estimation

Given:
- Statistics on base tables (computed periodically)
- An incoming query

We want to estimate the size of the answer. Requirements:
- Must be computed very fast
- Must use very little memory

## Deriving Selectivity Factors from Assumptions

These assumptions are flawed but allow estimation of simple queries:

1. **Uniformity**: values are uniformly distributed within an attribute's range
   ![[Uniformity assumption.png]]

2. **Independence**: values in $R.a$ and $R.b$ are independent
   ![[Independence Assumption.png]]

3. **Containment of values**: when $V(R, a) \leq V(S, b)$, the set of $a$ values in $R$ is included in the set of $b$ values in $S$
	- Most commonly applies for $\bowtie_{R.a = S.b}$ when $b$ is $S$'s primary key and $a$ is a foreign key in $R$
	- General case: ![[Containment Assumption Genreal Case.png]]
	- Not-enough-info case: ![[Containment Assumption Not enough info case.png]]

4. **Preservation of values**: ![[Preservation Assumption.png]]

Cardinality estimates are approximations, but they allow the optimizer to compare candidate query plans and choose a better tree.

## Related
- [[Relational Algebra]] — the query plans whose costs are being estimated
- [[RA Tree Transformations]] — how the optimizer uses cardinality estimates to pick a plan
- [[Physical Algorithms and Pipelining]] — cost estimates factor in the choice of physical operator
- [[CSE344/Database Design/Physical Design and Indices|Physical Design and Indices]] — index structure affects cardinality and cost estimates
- [[CSE344/Database Design/Database Indices|Database Indices]] — how clustered/unclustered indices change the cost formulas
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — block-level statistics that feed these estimates
