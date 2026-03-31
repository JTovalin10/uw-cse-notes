# SQL: Basics

## Data Models
- A **Data Model** is a mathematical formalism to describe data
	- allows us to talk about data conceptually without having to think about implementation
- A data model has 3 components
	- **Instance**: the actual data
	- **Schema**: description of what is being stored
	- **Query Language**: how to retrieve or manipulate it

## Relational Model
- Has **set** or **bag semantics**
	- SQL tables have bag semantics
	- Relations have set semantics
- Attributes are typed and static
- Relations are flat

## What is SQL
- **Structured Query Language (SQL)**
	- one of the many languages for querying relational data
	- most widely used language to query relational data
- A declarative programming language
	- we describe *what* we want, not *how* to get it — see [[Physical Data Independence]]

## Query Structure
- **SELECT**: which attributes we want
- **FROM**: which table(s) we query
- **WHERE**: predicate saying which rows we want
```sql
SELECT URL, Title
FROM URLS
WHERE NumVisits > 5;
```

## For-Each Semantics
For-each semantics is how we should conceptualize SQL's execution:
```sql
SELECT Name, UserId
FROM Payroll
WHERE Job = 'TA';
```
Becomes
```c
foreach row in Payroll:
	if row.Job == 'TA':
		output(row.Name, row.UserId)
```

## Keys
- A **key** is one or more attributes that **uniquely** identify a row
- See [[Create Table#Keys]] for syntax

### Foreign Keys
- Databases can hold multiple tables
- A **foreign key** is one or more attributes that uniquely identify a row in another table
- Describes a relationship between tables — used by [[Joins]] to combine data
