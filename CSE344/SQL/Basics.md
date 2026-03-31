## Data Models
- A Data Model is a mathemtical Formalism to describe data
	- allows us to talk about data conceptually without having to think about implementation
- A data model has 3 components
	- Instance: the actual data
	- Schema: description of what is being stored
	- Query Language: how to retrieve or manipulate it
## Relational model
- Have **set** or **bag semantics**
	- SQL table have bag semantics
	- Relations have set semantics
- Attributes are typed and static
- Relations are flat
## What is SQL
- Structured Query Language
	- one of the many languages for querying relational data
	- most widely used language to query relational data
- A declarative programming language
## SQL in Detail
### Query Structure

Select: which attribute we want
FROM: which table(s) we query
WHERE: predicate saying which rows we want
```sql
SELECT URL, Title
FROM URLS
WHERE NumVisits > 5;
```
## For Each Semantics
For-each semantics means that this is how we should conceputalize SQL's execution
```sql
SELECT URL, Title
FROM URLS
WHERE NumVisits > 5;
```
Becomes
```c
foreach row in Payroll:
	if row.Job == 'TA':
		output(row.Name, row.UserId)
```
## Keys
A key is one or more attribute that, in aggregate, **uniquely** identify a row
### Foreign Keys
- Databases can hold multiple tables
- A foreign key is one or more attributes that, in aggregate, uniquely identify a row in another table
- Describes a relationship between tables