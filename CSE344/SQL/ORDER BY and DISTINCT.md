# SQL: ORDER BY and DISTINCT

## ORDER BY
- Orders result tuples by specified attributes
- Default ordering is ascending
```SQL
SELECT Name, UserId
FROM Payroll
WHERE Job = 'TA'
ORDER BY Salary, Name;
```

## DISTINCT
- Deduplicates result tuples
- Relates to [[Basics#Relational Model|bag vs. set semantics]] — SQL tables are bags by default, DISTINCT converts results to set semantics
