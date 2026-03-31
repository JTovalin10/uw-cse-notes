- subqueries are queries inside other queries
	- usually simplifies or factors out parts of the outer queries
	- use case similar to helper functions
Using a flat query we can do this to find the what person has the maximum salary
```SQL
SELECT P1.Name, MAX(P2.Salary)
FROM Payroll AS P1, Payroll AS P2
WHERE P1.Job = P2.Job
GROUP BY P1.Name, P1.Salary, P2.Job
HAVING P1.Salary = MAX(P2.Salary)
```
It is doing two oeprations in a single pass (calaculte per-group maximum usoing GROUP BY/Having, then join against outer table)

subquery allows us to comptue the maxima first, then perform the join in a single pass
```SQL
SELECT P1.Name, P2.Salary
FROM Payroll AS P1, 
( SELECT P1.Job AS Job, MAX(P1.Salary) AS MaxSalary 
FROM Payroll AS P1 
GROUP BY P1.JOB) AS MP
WHERE P1.Job = MP.Job AND P.Salary = MP.MaxSalary
```
- if the SQL subquery returns exacetly one value, it can be use whenever we use a field
	- one value = one tuple with one attribute
- otherwose, a SQL subquery can be thought as an extra table
	- can name the table, its columns, etc
- Can define subqueries with teh WITH clause, most commonly with subqueries in FROM
	- makes subquery look more "table-like"
	- But WITH is just syntactic sugar
- they can go anywhere we use a table
```SQL
WITH MaxPaid AS ( 
SELECT P1.Job AS Job, MAX(P1.Salary) AS MaxSalary 
FROM Payroll AS P1 
GROUP BY P1.JOB)

SELECT P1.Name, P2.Salary
FROM Payroll AS P1, MaxPaid AS MP
WHERE P1.Job = MP.Job AND P.Salary = MP.MaxSalary
```
### Subquery locations and mechanics
#### FROM
Subqueries can "cache" temporary results
- subproblem taht cn be later used/joined
- can make query reads more batural, because ca have "rows" and "columns", just like tables
#### SELECT
- must return a single value
- can compute an associated/correlated value
	- correlated means outer table is referenced in the subquery
- the semantics of a correlated subquery are that the entire subqeury is redomputed for each tuple
	- if subqueries are helper methods, then a correlated subquery is a parameterized helper method
#### WHERE/HAVING
- Using subqueries in WHERE and HAVING allows us to use them to filter results
- SQL Operators
	- EXISTS / NOT EXISTS
	- IN / NOT IN
	- ANY / ALL
![[Subquery Analogues to First-Order Logic.png]]