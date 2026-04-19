# CSE331: Hoare Triples

A **Hoare Triple** is a structure used in [[Floyd Logic]] to reason about program correctness. It consists of two assertions surrounding a piece of code.

```c
{{ P }}   // precondition
  S       // code
{{ Q }}   // postcondition
```

- A Hoare triple has **two assertions and some code**.
- The triple is **valid** if the code is correct:
  - Given `S`, we have $P \rightarrow Q$ (if `P` holds before `S` runs, then `Q` holds after).
  - Otherwise, the triple is false.

## Hoare Triples with No Code

```c
{{ P }}   // precondition
{{ Q }}   // postcondition
```

When is such a triple valid?
- It is valid when $P \rightarrow Q$.
- We can establish this using [[CSE311/Part II - Formal Reasoning/Proof Techniques/Proof by Calculation|proof by calculation]].

## Hoare Triples With Code

- We can use **forward and backward reasoning**.
- Move the assertions toward each other until they meet in the middle.

## Hoare Triples With Multiple Lines of Code

```c
{{ P }}
   S
{{ R }}
   T
{{ Q }}
```

- Valid **iff** there exists an `R` making both triples valid.

## Moving Forward / Backward

Forward and backward reasoning fill in missing assertions.

- **Forward reasoning**
  - Fills in the **postcondition**.
  - Gives the **strongest** postcondition making the triple valid.
- **Backward reasoning**
  - Fills in the **precondition**.
  - Gives the **weakest** precondition making the triple valid.

See [[Stronger Assertions]] and [[Propositions]] for what "stronger" and "weaker" mean in this context.

## Related

- [[Floyd Logic]] — the broader reasoning framework
- [[Pre and Post Conditions]] — how preconditions and postconditions appear in method specs
- [[Stronger Assertions]] — assertion strength
- [[Propositions]] — strengthening/weakening pre- and postconditions
- [[CSE331/Part I - Software Specifications/Definitions/Facts|Facts]] — collecting facts in code
