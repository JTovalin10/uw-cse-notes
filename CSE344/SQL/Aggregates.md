# SQL: Aggregates

## Aggregate Functions
- **AGG(attr)** operates over all non-[[NULL]] values
	- AGG(DISTINCT attr) is also possible
- With one exception:
	- **COUNT(*)** counts all rows, regardless of NULL values
1. COUNT
2. SUM
3. AVG (mean)
4. MAX
5. MIN

## GROUP BY
- GROUP BY allows us to partition data based on matching column values, then apply an aggregation
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
	- all other fields are discarded and cannot appear in the SELECT clause
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
	- cannot change the partitioning itself, nor the rows that are being aggregated
- See also: [[Sub-Queries#WHERE/HAVING]] for using subqueries as filters
