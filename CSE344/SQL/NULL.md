# CSE344: NULL

A **NULL** value means missing, unknown, undefined, or inapplicable.

## Predicate Evaluation

A predicate can evaluate to:
- **False**: 0
- **Unknown**: 0.5
- **True**: 1

## Three-Valued Logic

- `A op B` is defined as:
	- **False** or **True** when both A and B are not null
	- **Unknown** otherwise
- Rules:
	- `A AND B` = min(A, B)
	- `A OR B` = max(A, B)
	- `NOT A` = 1 - A
- SQL only returns tuples whose condition evaluates to **True** (not Unknown)

![[three-value logic.png]]

## Related
- [[Aggregates]] — aggregate functions skip NULL values (except `COUNT(*)`)
- [[Joins]] — join predicates use three-valued logic, so NULLs never match
- [[Outer Joins]] — outer joins pad unmatched rows with NULLs
- [[ORDER BY and DISTINCT]] — NULL sort order is implementation-defined
- [[Sparse Matrix Algebra#Addition]] — sparse matrix addition must handle NULLs from outer joins
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — CHECK constraints and NULL interaction
