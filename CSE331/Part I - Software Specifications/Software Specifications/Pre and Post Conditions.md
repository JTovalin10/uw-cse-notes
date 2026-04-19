# CSE331: Pre and Post Conditions

Method specifications describe what a method requires of its inputs (**preconditions**) and what it promises about its outputs (**postconditions**). In Java, these are expressed in Javadoc using tags like `@param`, `@requires`, `@return`, `@throws`, [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]], and [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]].

## Preconditions

- **Preconditions** restrict the allowed inputs to a method.
- Preconditions on individual parameters are often included in the `@param` tag.
- With **multiple parameters**, we use `@requires` to state a condition that relates them.
  - `@requires` tells us the **bound** or constraint that must hold before the method runs.

## Postconditions

- A **postcondition** describes what is true after the method returns.
- **Only applies for allowed inputs** — if the input violates the precondition, the postcondition makes no promises.
- **Only specified for allowed inputs.**
- Usually expressed with `@return` (what is returned) and `@throws` (what exception is thrown).

### Strengthening a Postcondition

A **stronger postcondition** promises more about the result. It may:
- Add more detail to `@return`.
- Add more detail to [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]].
- Remove items from [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]] (promising to modify less).

See [[Propositions]] and [[Stronger Assertions]] for a formal treatment of spec strength.

## Other Outcomes

A method call either returns normally or throws an error:
- `@throws` — declares exceptions the method may raise.
- `@return` — declares the value the method returns.

## Classifying Inputs

Every input falls into one of three categories:

1. **Input is not allowed** — violates the precondition; behavior is unspecified.
2. **Input is allowed and will return something** — specified by `@return`.
3. **Input is allowed and will throw something** — specified by `@throws`.

For how this is expressed in Javadoc comments, see [[Writing Methods Specs in Java]].

## Related

- [[Writing Methods Specs in Java]] — Javadoc form of these specs
- [[Kinds of Specifications]] — declarative vs imperative
- [[Stronger Assertions]] — strengthening an assertion
- [[Propositions]] — stronger postconditions and weaker preconditions
- [[Hoare Triples]] — formal pre/postcondition reasoning
- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]] — promises about mutation
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]] — what may be changed
- [[CSE331/Part I - Software Specifications/Definitions/Restricting Domain|Restricting Domain]] — preconditions as quantifier restrictions
- [[CSE331/Part I - Software Specifications/Definitions/Side Conditions|Side Conditions]] — when conditions appear in function definitions
