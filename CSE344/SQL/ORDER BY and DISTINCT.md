# CSE344: ORDER BY and DISTINCT

## ORDER BY

- **ORDER BY** orders result tuples by specified attributes
- Default ordering is **ascending**
- Multiple sort keys are applied left-to-right (first tiebreaker, second tiebreaker, ...)

```SQL
SELECT Name, UserId
FROM Payroll
WHERE Job = 'TA'
ORDER BY Salary, Name;
```

The sort order for [[NULL]] values is implementation-defined.

## DISTINCT

- **DISTINCT** deduplicates result tuples
- Relates to [[Basics#Relational Model|bag vs. set semantics]] — SQL tables are bags by default, DISTINCT converts results to set semantics

## Related
- [[Basics#Relational Model]] — bag vs. set semantics
- [[Aggregates]] — `AGG(DISTINCT attr)` deduplicates before aggregating
- [[Set Operations]] — `UNION` vs. `UNION ALL` mirrors DISTINCT vs. bag semantics
- [[NULL]] — NULL handling in sort order and in DISTINCT
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — ORDER BY maps to $\tau$, DISTINCT maps to $\delta$
