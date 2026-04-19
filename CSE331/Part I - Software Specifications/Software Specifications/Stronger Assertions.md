# CSE331: Stronger Assertions

An **assertion** is **stronger** iff it holds in a **subset** of states. That is, a stronger assertion is more restrictive — it rules out more possible states.

## Implication

Stronger assertions imply the weaker ones:

- **stronger** = *implies*
- **weaker** = *is implied by*

If $A$ is stronger than $B$, then $A \Rightarrow B$. Every state satisfying $A$ also satisfies $B$, but not vice versa.

## Why This Matters

When reasoning about [[Hoare Triples]] and [[Floyd Logic]], we can always **strengthen the precondition** or **weaken the postcondition** while preserving correctness:

- A specification with a stronger precondition is easier to satisfy (the method gets to assume more).
- A specification with a weaker postcondition is easier to satisfy (the method has to guarantee less).

See also [[Kinds of Specifications]] for how strength applies to method specs.

## Related

- [[Propositions]]
- [[Hoare Triples]]
- [[Floyd Logic]]
- [[Pre and Post Conditions]]
- [[CSE331/Part I - Software Specifications/Definitions/Facts|Facts]]
