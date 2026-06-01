# CSE331: Postcondition

A **postcondition** is an assertion that describes what must be true after a method returns. In Javadoc, postconditions are typically written with `@return`, `@throws`, and [[@effects|@effects]].

See [[Pre and Post Conditions]] for the full treatment of preconditions and postconditions together.

## Stronger Postcondition

A **stronger postcondition** promises more about the result of the method. Making a postcondition stronger may:
- **Add more detail to `@return`** (restrict the return value to a smaller set, e.g. "between 1 and 100" is stronger than "is positive").
- **Add more to [[@effects|@effects]]** (promise more about mutation effects).
- **Remove items from [[@modifies|@modifies]]** (promise to mutate fewer things).

A more specific return value means the spec is stronger — more detail is better.

## Related

- [[Pre and Post Conditions]] — full discussion of preconditions and postconditions
- [[Stronger Assertions]] — what "stronger" means for assertions
- [[Propositions]] — stronger postcondition vs weaker precondition
- [[Software Design and Implementation/Part I - Software Specifications/Software Specifications/Writing Methods Specs in Java]] — Javadoc syntax for postconditions
- [[Hoare Triples]] — postconditions in formal reasoning
- [[@effects|@effects]]
- [[@modifies|@modifies]]
