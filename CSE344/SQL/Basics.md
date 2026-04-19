# CSE344: SQL Basics

## Data Models

A **Data Model** is a mathematical formalism to describe data.
- Allows us to talk about data conceptually without having to think about implementation

A data model has 3 components:
- **Instance**: the actual data
- **Schema**: description of what is being stored
- **Query Language**: how to retrieve or manipulate it

## Relational Model

- Has **set** or **bag semantics**
	- SQL tables have **bag semantics** (duplicates allowed)
	- Relations have **set semantics** (no duplicates)
- Attributes are typed and static
- Relations are flat

## What is SQL

- **Structured Query Language (SQL)**
	- One of the many languages for querying relational data
	- Most widely used language to query relational data
- A **declarative** programming language
	- We describe *what* we want, not *how* to get it — see [[Physical Data Independence]]

## Query Structure

- **SELECT**: which attributes we want
- **FROM**: which table(s) we query
- **WHERE**: predicate saying which rows we want

```sql
SELECT URL, Title
FROM URLS
WHERE NumVisits > 5;
```

![[Query Mental Model.png]]

## For-Each Semantics

**For-each semantics** is how we should conceptualize SQL's execution:

```sql
SELECT Name, UserId
FROM Payroll
WHERE Job = 'TA';
```

Becomes:

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

## Related
- [[Create Table]] — DDL syntax for tables and keys
- [[Joins]] — combining multiple tables on foreign keys
- [[ORDER BY and DISTINCT]] — set vs. bag semantics in practice
- [[Physical Data Independence]] — why SQL is declarative
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — rules enforced by the DBMS
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — how SQL is compiled to relational algebra
