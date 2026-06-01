# CSE 311: Satisfiability (SAT)

**Satisfiability** asks: given a propositional logic expression, is there a way to set the values of the variables to make the expression evaluate to True (T)?

- If yes, the expression is **satisfiable**.
- If not, the expression is **unsatisfiable**.

Satisfiability is decided by searching over variable assignments — in the worst case, every row of a [[Truth Tables|truth table]] must be checked for a single True. An expression that is satisfiable on *every* row is a [[Tautologies|tautology]]; one that is satisfiable on *no* row is a contradiction (unsatisfiable).

## Related

- [[Tautologies|Tautologies]]
- [[Truth Tables|Truth Tables]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Satisfiability (SAT) | The Boolean satisfiability problem (SAT) |
| Satisfiable expression | A formula with a satisfying assignment / model |
