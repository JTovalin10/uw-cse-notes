# CSE344: Aggregates

## Aggregate Functions

- **AGG(attr)** operates over all non-[[NULL]] values
	- `AGG(DISTINCT attr)` is also possible (deduplicate before aggregating)
- With one exception:
	- **COUNT(\*)** counts all rows, regardless of NULL values

Common aggregate functions:
1. **COUNT**
2. **SUM**
3. **AVG** (mean)
4. **MAX**
5. **MIN**

## GROUP BY

- **GROUP BY** allows us to partition data based on matching column values, then apply an aggregation

```SQL
SELECT Job, AVG(Salary)
FROM Payroll
GROUP BY Job;
```

### Order of Operations
1. Group tuples by value
2. Apply aggregation to each group

### Using Groups When Aggregating

- Groups partition data based on matching column values, then apply an aggregation
- Each group becomes a single row in the answer

![[Using Groups When Aggregating.png]]

### Retained Fields

- Fields used in the aggregation are retained
	- All other fields are discarded and cannot appear in the SELECT clause

```SQL
SELECT Job, AVG(Salary)
FROM Payroll
GROUP BY Job;
```

![[Group-By, Retained Fields.png]]

## HAVING: Filtering Groups

- Sometimes we want to filter out entire groups based on that group's aggregated value(s)
- We cannot state this in the WHERE clause
	- WHERE checks only one single record
- Instead, we use **HAVING**
	- HAVING cannot change the partitioning itself, nor the rows that were aggregated
- We can also use aggregation functions in HAVING

### WHERE vs HAVING

- **WHERE**: filters individual tuples (before grouping)
- **HAVING**: filters entire groups (after grouping)
	- Cannot change the partitioning itself, nor the rows that are being aggregated
- See also [[Sub-Queries#WHERE/HAVING]] for using subqueries as filters

## Related
- [[NULL]] — aggregate functions skip NULL values (except COUNT(\*))
- [[ORDER BY and DISTINCT]] — often combined with aggregates for reporting
- [[Set Operations]] — bag-semantic operations related to DISTINCT
- [[Sub-Queries]] — using aggregates inside subqueries (see [[Witnessing Problem]])
- [[Sparse Matrix Algebra#Multiplication]] — matrix multiplication is GROUP BY on a join
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — GROUP BY maps to the $\gamma$ operator
