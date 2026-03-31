# SQL: Joins

SQL joins all tables to create "composite tuples" before doing any filtering.

Joins realize combinations of tables:
- sometimes the data is combined using a [[Basics#Foreign Keys|foreign key]], but not always

## Inner Joins
- An inner join is often interchangeable with just JOIN
- Combines two relations using a join predicate

### Procedural Pseudocode
```SQL
SELECT P.Name, R.Car
FROM Payroll AS P
INNER JOIN Registry AS R ON P.UserID = R.UserID;
```

```SQL
SELECT P.Name, R.Car
FROM Payroll AS P, Registry AS R
WHERE P.UserID = R.UserID;
```

```java
void findCars(PayrollTuple[] ps, RegistryTuple[] rs) {
	for (PayrollTuple p : ps) {
		for (RegistryTuple r : rs) {
			if (p.userID == r.userID) {
				output(p.name, r.car);
			}
		}
	}
}
```

### Mental Model
- You can think of SQL as creating a collection of temporary tuples when it joins tables

### Possible Inner Join Optimizations
- The order of the foreach loops doesn't matter
- We can check the predicate early
	- apply filter before looping over table
- The database might be able to retrieve rows with a condition without iterating over all rows
	- [[Database Index]]

## Related
- [[Outer Joins]] — preserving unmatched rows
- [[Self Joins]] — joining a table with itself
- [[Set Operations]] — UNION, INTERSECT, EXCEPT
