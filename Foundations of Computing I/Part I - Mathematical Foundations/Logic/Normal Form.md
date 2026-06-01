# CSE 311: Normal Forms (CNF and DNF)

A **normal form** is a standardized way of writing a proposition so that any logical formula can be expressed in a fixed, predictable shape. Both normal forms below are read directly off a [[Truth Tables|truth table]].

## Disjunctive Normal Form (DNF)

**DNF** (**Disjunctive Normal Form**): identify the rows where the formula is **true** and join them with OR. A DNF formula is a disjunction of conjunctions — each conjunction (an "AND clause") describes one true row exactly.

$$
(a \land b) \lor (\neg a \land b) \lor \ldots
$$

### Simplified Explanation

DNF says "the formula is true in *this* case, OR *this* case, OR ..." — you list every winning combination of variable values.

## Conjunctive Normal Form (CNF)

**CNF** (**Conjunctive Normal Form**): identify the rows where the formula is **false** and encode each as a clause, then join with AND. A CNF formula is a conjunction of disjunctions — each disjunction (an "OR clause") rules out one false row.

$$
(a \lor b) \land (\neg a \lor b)
$$

### Simplified Explanation

CNF says "the formula must avoid *this* bad case, AND *this* bad case, AND ..." — every clause forbids one losing combination.

Every proposition can be converted to both CNF and DNF using [[Truth Tables|truth tables]]. Because normal forms use only $\land$, $\lor$, and $\neg$, they map straight onto [[Digital Circuits|digital circuits]] built from AND, OR, and NOT gates.

## Related

- [[Truth Tables|Truth Tables]]
- [[Logical Equivalence(s)|Logical Equivalence(s)]]
- [[Digital Circuits|Digital Circuits]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Disjunctive Normal Form (DNF) | Sum of products (SOP) |
| Conjunctive Normal Form (CNF) | Product of sums (POS) |
| Clause | Term / minterm (DNF) or maxterm (CNF) |
