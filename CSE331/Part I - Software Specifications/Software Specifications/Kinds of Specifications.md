# CSE331: Kinds of Specifications

There are two broad kinds of software specifications: **declarative** and **imperative**.

## Declarative Specifications

- Says **what** the answer looks like.
- Does **not** say how to calculate it.
- It is up to the implementer to ensure the code satisfies the spec.

## Imperative Specifications

- Tells us **how** the answer is calculated.
- Lays out the exact steps used to compute it.

## Related

- [[Pre and Post Conditions]] — declarative style for method behavior
- [[Writing Methods Specs in Java]] — how specs look in Javadoc
- [[Hoare Triples]] — formal declarative reasoning about code
- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]] — declarative description of mutation
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]] — declarative list of what may change
