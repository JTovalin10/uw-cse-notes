# CSE344: Outer Joins

Unlike [[Joins|inner joins]], **outer joins** preserve rows that have no match in the other table.

- **LEFT OUTER JOIN**: all rows in the left table are preserved
- **RIGHT OUTER JOIN**: all rows in the right table are preserved
- **FULL OUTER JOIN**: all rows from both tables are preserved
- Unmatched rows are padded with [[NULL]] values

## Related
- [[Joins]] — inner join mechanics
- [[Self Joins]] — outer joins can also be applied to self-joins
- [[NULL]] — how NULLs from outer joins interact with predicates (three-valued logic)
- [[Sparse Matrix Algebra#Addition]] — outer joins are used to handle sparse matrix addition
- [[CSE344/Query Execution/Main Memory Join Algorithms|Main Memory Join Algorithms]] — physical implementations also support outer variants
