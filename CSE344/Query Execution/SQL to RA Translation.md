# Query Execution: SQL to RA Translation

## Query Plans

A **query plan** is an expression in [[Relational Algebra|relational algebra]].
- Expressions are written as a tree
- The DBMS translates SQL queries into analogous query plans
	- The plan specifies the order of operators
- Tuples "flow up" the query plan, getting modified along the way

![[SQL to Relational Algebra to binary.png]]

## Translating Basic SQL

A basic `SELECT-FROM-WHERE` query maps directly to RA:
- `WHERE` → Selection $\sigma$
- `SELECT` → Projection $\pi$
- `FROM` with multiple tables → Cross product $\times$ (or join $\bowtie$)
- `GROUP BY` / aggregates → Grouping $\gamma$
- `ORDER BY` → Sorting $\tau$
- `DISTINCT` → Deduplication $\delta$

## Translating SQL with Subqueries

RA is an algebra — it does not have subqueries. It is a set-at-a-time language: relation in, relation out. If a SQL query has a subquery, the DBMS must:
1. Decorrelate the subquery
2. Translate the subquery to RA
3. Translate the outer query to RA

Key properties that make this possible:
- Inner-join order doesn't matter (commutativity and associativity)
- A self-join on a key only duplicates the per-tuple info

### Subqueries in FROM

![[Subqueries in FROm to RA.png]]

Subqueries in `FROM` translate naturally — each subquery becomes a named intermediate relation in the RA tree.

### Subqueries in WHERE/HAVING

![[Subqueries in WHERE, Having.png]]

- RA cannot represent correlated queries — tuples flow up, so correlations must be removed first (see [[CSE344/SQL/Decorrelation and Unnesting]])
- Typically, the outer query compares a scalar subquery result (single tuple, single attribute) against something in the outer query
- After decorrelating, `=` or `IN` must be converted into a join — RA has no operator that checks set membership

## Related
- [[Relational Algebra]] — RA overview and query plan trees
- [[RA Operators]] — the full operator reference
- [[RA Tree Transformations]] — optimizing the resulting plan
- [[CSE344/SQL/Sub-Queries]] — the SQL subquery mechanics being translated
- [[CSE344/SQL/Decorrelation and Unnesting]] — monotonicity and when subqueries can be unnested
