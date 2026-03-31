## Joins
SQL joins all tables to create "composite typles" before doing any filtering

Joins realize combination of tables
- sometimes the data is combined using a [[foreign key]], but not always
### Inner Joins
- inner join is often interchanable with just join
- intersects two relations using a join predicate
#### Procedural Psuedocode
```SQL
SELECT P.Name, R.Car
FROM Payroll as P
INNER JOIN Registry AS R ON P.UserID = R.UserID;
```

```SQL
SELECT P.Name, R.Car
FROM Payroll AS P, Registry AS R
WHERE P.UserID = R.UserID;
```

```java
public class PayrollTuple {
public int userId;
public std::string name;
public String job;
public int salary;
};

public class RegistryTuple {
public int userId;
public String car;
}

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
- you can think of SQL as creating a colleciton of temporary tuples when it joins tables
### Possible Inner Joins Optimization
- the order of the foreach loops doesn't matter
- we can check predicate early
	- apply filter before looping over table
- the database might be table to retrieve rows with condition without iterating over all rows
	- [[Database Index]]
## Physical Data Independence
- SQL is a declarative language
	- what we want, not how to get it
- the query optimizer is responsible for choosing the best execution plan for the query
- this is physical data independence
## A little extra SQL
- ORDER BY: orders result tuples by specified attributes 
	- default ordering = ascending
```SQL
SELECT name, userid
FROM Payroll
WHERE job = 'TA'
ORDER BY Salary, Name;
```
- DISTINCT: deduplicates result tuples
## Outer Joins
- LEFT OUTER JOIN
	- all rows in the left table are preserved
	- one-many relationships
	- this is the WHERE CLAUSE
- RIGHT OUTER JOIN
	- all rows in right table are preserved
	- this is the JOIN clause
- FULL OUTER JOIN
	  all rows are preserved
## Self Joins
A SQL query may have multiple relations in its FROM clause
```SQL
FROM Registry AS R, Payroll AS P
```
When a relation occurs more than once, we call that query a self-join
```SQL
FROM Registry AS R1, Registry AS R2, Payroll AS P
```
- Self joins allow us to iterate again over a table's data
- they can generate all pairs (triples, etc)
	- then we filter these tuples down to the ones we want

## Set-like Operations
- SQL mimics theoretical sets, but allows for duplicates
	- Bags = Set with duplciates
	- Bags are also known as multisets
- UNION = set union
- UNION ALL = bag union
- INTERSECT = set intersection
- INTERSECT ALL = bag intersection
- EXCEPT = set difference
- EXCEPT ALL = bag difference