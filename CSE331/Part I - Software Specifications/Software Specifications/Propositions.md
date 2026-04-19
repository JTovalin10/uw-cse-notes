# CSE331: Propositions (Spec Strength)

Preconditions and postconditions are **propositions** — true/false claims about the values of variables in the program. Because they are propositions, we can compare their logical strength.

## Stronger and Weaker Propositions

We say that $P_1$ is **stronger** than $P_2$ if:
- Whenever $P_1$ is true, $P_2$ is also true.
- The set of values that satisfy $P_1$ is a **subset** of the set that satisfies $P_2$.
- Equivalently, $P_1$ implies $P_2$ (i.e., $P_1 \rightarrow P_2$).

We say $P_2$ is **weaker** than $P_1$.

See [[Stronger Assertions]] for the general assertion-strength relationship.

## Stronger Postcondition

A **stronger postcondition**:
- Describes a **smaller** subset of allowed outputs for a given input.
- Example: "return is between 1 and 100" is stronger than "return is positive".

See [[Postcondition#Stronger Postcondition]] for how strengthening shows up in Javadoc tags.

## Weaker Precondition

A **weaker precondition**:
- Accepts a **larger** subset of allowed inputs.
- Example: "allowing all `int` values" is weaker than "allowing only positive ints".

## Specificity

A **more specific** return value means the spec is stronger — **more detail is better**.

## What Makes a Spec Stronger?

Spec $S_1$ is **stronger** than spec $S_2$ if it has:
- A **stronger postcondition** (smaller subset of allowed outputs), **or**
- A **weaker precondition** (larger subset of allowed inputs),
- (or both).

In other words, a stronger spec **promises more** while **demanding less**.

## Related

- [[Stronger Assertions]] — general notion of assertion strength
- [[Pre and Post Conditions]] — where these conditions appear in Java specs
- [[Postcondition]] — strengthening a postcondition in Javadoc
- [[Hoare Triples]] — strongest postcondition and weakest precondition from forward/backward reasoning
- [[Floyd Logic]] — assertions as T/F claims about state
- [[CSE311/Part I - Mathematical Foundations/Logic/Logical Equivalence(s)|Logical Equivalences]] — foundations from CSE311
- [[CSE331/Part I - Software Specifications/Definitions/Restricting Domain|Restricting Domain]] — implication as a way to restrict inputs
