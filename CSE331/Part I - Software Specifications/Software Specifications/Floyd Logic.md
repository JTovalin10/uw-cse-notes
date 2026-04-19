# CSE331: Floyd Logic

**Floyd Logic** is a formal system for reasoning about program correctness using assertions about the program state.

## Program State

The **program state** is the collection of values of all the variables at a given point during execution.

## Assertions

An **assertion**, written in `{{ }}`, is a true/false claim about the program state.

- An assertion **holds** if the claim is true in the current state.
- Assertions are **mathematics, not code** — they describe what is true about the state rather than computing anything.
- Assertions are used to describe preconditions and postconditions in [[Hoare Triples]].

## Stronger vs Weaker Assertions

An assertion is **stronger** if it holds in a smaller subset of states (see [[Stronger Assertions]]). Stronger assertions imply weaker ones.

## Related

- [[Hoare Triples]] — pairs of assertions surrounding code
- [[Pre and Post Conditions]] — how assertions are used to specify methods
- [[Stronger Assertions]] — comparing assertion strength
- [[Propositions]] — stronger/weaker pre- and postconditions
- [[CSE331/Part I - Software Specifications/Definitions/Facts|Facts]] — things known to be true about variables
- [[CSE311/Part I - Mathematical Foundations/Logic/Tautologies|Tautologies]] — related logical foundations from CSE311
