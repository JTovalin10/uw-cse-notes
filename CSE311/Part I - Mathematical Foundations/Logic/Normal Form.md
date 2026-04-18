# CSE 311: Normal Forms (CNF and DNF)

#Definition **DNF** (**Disjunctive Normal Form**): identify the rows where the formula is **true** and join them with OR. A DNF formula is a disjunction of conjunctions.
$$
(a \land b) \lor (\neg a \land b) \lor \ldots
$$

#Definition **CNF** (**Conjunctive Normal Form**): identify the rows where the formula is **false** and encode each as a clause, then join with AND. A CNF formula is a conjunction of disjunctions.
$$
(a \lor b) \land (\neg a \lor b)
$$

Every proposition can be converted to both CNF and DNF using [[Truth Tables]].

## Related

- [[Truth Tables]]
- [[Logical Equivalence(s)]]
- [[Digital Circuits]]
