# CSE 311: Logical Equivalences

A **logical equivalence** ($\equiv$) asserts that two propositions always share the same truth value. The following core equivalences let us rewrite connectives in terms of one another:

- $A = B \quad \equiv \quad (A \leftrightarrow B \equiv T)$
- $p \equiv \neg \neg p$ — double negation
- $p \rightarrow q \quad \equiv \quad \neg p \lor q$ — implication rewritten as a disjunction
- $p \leftrightarrow q \quad \equiv \quad (p \rightarrow q) \land (q \rightarrow p)$ — biconditional as two implications

## Equality vs. Equivalence

- $A = B$ means $A$ and $B$ are the same thing written twice (character-for-character identical).
- $A \equiv B$ is an assertion that two propositions $A$ and $B$ always have the same truth values.

The distinction matters: two propositions can be equivalent (same truth values on every row of a [[Truth Tables|truth table]]) without being literally equal as written expressions.

## Important Equivalences

#Definition **Identity**:
$$p \land T \equiv p$$
$$p \lor F \equiv p$$
$$x \cdot 1 = x$$
$$x + 0 = x$$

#Definition **Domination**:
$$p \lor T \equiv T$$
$$p \land F \equiv F$$
$$x \cdot 0 = 0$$

#Definition **Idempotent**:
$$p \lor p \equiv p$$
$$p \land p \equiv p$$

#Definition **Commutative**:
$$p \lor q \equiv q \lor p$$
$$p \land q \equiv q \land p$$

#Definition **Associative**:
$$(p \lor q) \lor r \equiv p \lor (q \lor r)$$
$$(p \land q) \land r \equiv p \land (q \land r)$$

#Definition **Distributive**:
$$p \land (q \lor r) \equiv (p \land q) \lor (p \land r)$$
$$p \lor (q \land r) \equiv (p \lor q) \land (p \lor r)$$

#Definition **Absorption**:
$$p \lor (p \land q) \equiv p$$
$$p \land (p \lor q) \equiv p$$

#Definition **Negation**:
$$p \lor \neg p \equiv T$$
$$p \land \neg p \equiv F$$

Each named equivalence above is paired with its [[Boolean Algebra|Boolean algebra]] form (e.g. identity $p \land T \equiv p$ alongside $x \cdot 1 = x$) to show that the logical laws are the same laws as ordinary arithmetic identities.

## Related

- [[Boolean Algebra|Boolean Algebra]]
- [[DeMorgans Laws|DeMorgans Laws]]
- [[Digital Circuits|Digital Circuits]]
- [[Truth Tables|Truth Tables]]
- [[Normal Form|Normal Form]]
- [[Tautologies|Tautologies]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Logical equivalence ($\equiv$) | Logical equality / tautological equivalence |
| Idempotent / domination / identity laws | Boolean algebra axioms |

