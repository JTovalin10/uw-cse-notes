# Query Execution: Relational Algebra

**Relational Algebra (RA)** is a set-at-a-time algebra for relations.
- RA has a collection of operators
	- Inputs: one or two relations
	- Output: a new relation
- RA specifies how to combine these operators
	- An RA expression specifies the order in which operations shall be performed
	- This expression is also known as a **query plan**

![[SQL to Relational Algebra to binary.png]]

## Basics

- RA operators are named with Greek symbols: $\sigma, \pi, \gamma, \tau, \delta$, etc.
- RA expressions / query plans are often displayed as a **tree** rather than linearly
	- Tuples from the input relation(s) "flow up" the RA tree, getting modified along the way

![[Relational Algebra Example.png]]

## Key Topics

- [[RA Operators]] — full reference for all RA operators (projection, selection, joins, grouping, etc.)
- [[SQL to RA Translation]] — how the DBMS translates SQL queries (including subqueries) into RA query plans
- [[RA Tree Transformations]] — rewriting RA trees into equivalent but cheaper plans; the join ordering problem

## Why Are Joins So Common in Relational Databases?

- [[Normalization]] removes anomalies by splitting tables — joins reunite them at query time
- The most common joins are equijoins and natural joins

## Related
- [[Cardinality Estimation]] — estimating the cost of RA query plans to choose among candidates
- [[Physical Algorithms and Pipelining]] — how RA operators are physically implemented
- [[CSE344/SQL/Sub-Queries]] — SQL subquery mechanics before RA translation
- [[CSE344/SQL/Decorrelation and Unnesting]] — monotonicity and when subqueries can be rewritten
