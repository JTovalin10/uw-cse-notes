# SQL: Outer Joins

Unlike [[Joins|inner joins]], outer joins preserve rows that have no match in the other table.

- **LEFT OUTER JOIN**: all rows in the left table are preserved
- **RIGHT OUTER JOIN**: all rows in the right table are preserved
- **FULL OUTER JOIN**: all rows are preserved
- Unmatched rows are padded with [[NULL]] values

## Related
- [[Joins]] — inner join mechanics
- [[NULL#Three-Valued Logic]] — how NULLs from outer joins interact with predicates
- [[Sparse Matrix Algebra#Addition]] — outer joins used to handle sparse matrix addition
