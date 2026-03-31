# SQL: Self Joins

A SQL query may have multiple relations in its FROM clause:
```SQL
FROM Registry AS R, Payroll AS P
```
When a relation occurs more than once, we call that query a **self-join**:
```SQL
FROM Registry AS R1, Registry AS R2, Payroll AS P
```
- Self joins allow us to iterate again over a table's data
- They can generate all pairs (triples, etc.)
	- then we filter these tuples down to the ones we want

## Related
- [[Witnessing Problem]] — the main use case for self joins
- [[Joins]] — inner join mechanics
