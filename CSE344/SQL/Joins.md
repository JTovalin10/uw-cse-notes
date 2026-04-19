# CSE344: Joins

SQL joins all tables to create **composite tuples** before doing any filtering.

Joins realize combinations of tables:
- Sometimes the data is combined using a [[Basics#Foreign Keys|foreign key]], but not always

## Inner Joins

- An **inner join** is often interchangeable with just `JOIN`
- Combines two relations using a **join predicate**

### Procedural Pseudocode

Explicit `INNER JOIN` syntax:
```SQL
SELECT P.Name, R.Car
FROM Payroll AS P
INNER JOIN Registry AS R ON P.UserID = R.UserID;
```

Implicit join (cross product with a WHERE predicate):
```SQL
SELECT P.Name, R.Car
FROM Payroll AS P, Registry AS R
WHERE P.UserID = R.UserID;
```

Equivalent imperative implementation:
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
	- Apply filter before looping over table
- The database might be able to retrieve rows with a condition without iterating over all rows
	- See [[CSE344/Database Design/Database Indices|Database Indices]]

## Related
- [[Outer Joins]] — preserving unmatched rows with NULL padding
- [[Self Joins]] — joining a table with itself
- [[Set Operations]] — UNION, INTERSECT, EXCEPT
- [[NULL]] — how NULLs affect join predicates via three-valued logic
- [[Basics#Foreign Keys]] — the typical basis for a join predicate
- [[CSE344/Query Execution/Main Memory Join Algorithms|Main Memory Join Algorithms]] — physical implementations (nested loop, hash, merge)
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — how joins map to the $\bowtie$ operator
