# SQL: The Witnessing Problem (Argmax)

Find the tuple whose value contributed to the aggregate's value.
- Uses a [[Sub-Queries|subquery]] with a [[Self Joins|self-join]]

```SQL
SELECT P.Name, P.Salary
FROM Payroll AS P,
	(SELECT P1.Job AS Job, MAX(P1.Salary) AS MaxSalary
	 FROM Payroll AS P1
	 GROUP BY P1.Job) AS MP
WHERE P.Job = MP.Job AND P.Salary = MP.MaxSalary
```

## Key Idea
- Calculate per-job max using [[Aggregates#GROUP BY|GROUP BY]]:
```SQL
SELECT Job, MAX(Salary)
FROM Payroll
GROUP BY Job
```
- "Iterate" a second time over the same table (self-join to get two copies)
	- Returns rows where Salary = MAX(Salary)

## Recipe
1. Start with a self-join
2. Identify the group and the per-group aggregation function
3. Filter the self-join on the grouping attribute(s)
4. In the second loop, group on the aggregated column
5. Remove the groups whose values don't match the new aggregated argument
6. Select the argument and its aggregated value
