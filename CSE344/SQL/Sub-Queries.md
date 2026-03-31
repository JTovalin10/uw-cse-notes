# SQL: Sub-Queries

- **Subqueries** are queries inside other queries
	- usually simplify or factor out parts of the outer query
	- use case is similar to helper functions

## Motivation
Using a flat query to find which person has the maximum salary:
```SQL
SELECT P1.Name, MAX(P2.Salary)
FROM Payroll AS P1, Payroll AS P2
WHERE P1.Job = P2.Job
GROUP BY P1.Name, P1.Salary, P2.Job
HAVING P1.Salary = MAX(P2.Salary)
```
This does two operations in a single pass (calculates the per-group maximum using [[Aggregates#GROUP BY|GROUP BY]]/[[Aggregates#HAVING Filtering Groups|HAVING]], then [[Joins#Self Joins|self-joins]] against the outer table)

A subquery allows us to compute the maxima first, then perform the join separately:
```SQL
SELECT P1.Name, MP.MaxSalary
FROM Payroll AS P1,
	(SELECT P1.Job AS Job, MAX(P1.Salary) AS MaxSalary
	 FROM Payroll AS P1
	 GROUP BY P1.Job) AS MP
WHERE P1.Job = MP.Job AND P1.Salary = MP.MaxSalary
```

## Key Rules
- If a subquery returns exactly one value, it can be used wherever we use a field
	- one value = one tuple with one attribute
- Otherwise, a subquery can be thought of as an extra table
	- can name the table, its columns, etc.

## WITH Clause
- Can define subqueries with the **WITH** clause (most commonly with subqueries in FROM)
	- makes the subquery look more "table-like"
	- WITH is just syntactic sugar
```SQL
WITH MaxPaid AS (
	SELECT P1.Job AS Job, MAX(P1.Salary) AS MaxSalary
	FROM Payroll AS P1
	GROUP BY P1.Job)

SELECT P1.Name, MP.MaxSalary
FROM Payroll AS P1, MaxPaid AS MP
WHERE P1.Job = MP.Job AND P1.Salary = MP.MaxSalary
```

## Subquery Locations and Mechanics

### FROM
Subqueries can "cache" temporary results
- subproblem that can be later used/joined
- can make queries read more naturally, because subqueries have "rows" and "columns" just like tables

### SELECT
- Must return a single value
- Can compute an associated/correlated value
	- **correlated** means the outer table is referenced in the subquery
- The semantics of a correlated subquery: the entire subquery is recomputed for each outer tuple
	- if subqueries are helper methods, then a correlated subquery is a parameterized helper method

### WHERE/HAVING
- Using subqueries in WHERE and HAVING allows us to use them to filter results
- SQL Operators:
	- **EXISTS** / **NOT EXISTS**
	- **IN** / **NOT IN**
	- **ANY** / **ALL**
![[Subquery Analogues to First-Order Logic.png]]

## Related
- [[Witnessing Problem]] — the main subquery pattern (argmax)
- [[Decorrelation and Unnesting]] — monotonicity of subquery-free queries
