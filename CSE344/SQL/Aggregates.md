## Actionable Results
- AGG(attr) operates over all non-NULL values
	- AGG(DISTINCT attr) is also possible
- with one exception
	- COUNT(*) counts all rows, regardless of NULL value
1. COUNT
2. SUM
3. AVG(mean)
4. MAX
5. MIN

## Group BY
- Group-by allows us to write a single query
	- groups partition data based on matching column values, then applies the aggregation
```SQL
SELECT Job, AVG(SALARY)
FROM Payroll
GROUP BY Job;
```
### Order of operations
1. Group tuples by value
2. apply aggregation to each group
### using groups when aggregating
- groups partition data based on matching column values, then applies the aggregation
- each group becomes a single row in the answer
![[Using Groups When Aggregating.png]]
### Retained Fields
- fields used in the aggregation are retained
	- all other fields are discared and canot appear in the SELECT clause
```SQL
SELECT Job, AVG(Salary)
FROM Payroll
GROUP BY Job;
```
![[Group-By, Retained Fields.png]]
## Having: filtering groups
- sometimes we want to filter out entire groups based on that group's aggregated value(s)
- we cannot state this in the where caluse
	- where checks only one single record
- instead we use HAVING
	- HAVING cannot change the partitioning itself, nor the rows that were aggergated
- we can also use aggregation function's in HAVING
### WHERE VS HAVING
- WHERE: filters tuples
- HAVING: filters groups
	- cannot change the partitioning itself, nor the rows that are being aggregated