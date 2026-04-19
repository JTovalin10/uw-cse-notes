# CSE331: Subtypes

## What is a Subtype?

Sometimes every **B** is an **A**:
- Every book is a library holding
- Every circle is a shape

Formally: an [[Abstract Data Type]] $S_1$ is a **subtype** of $S_2$ when satisfying $S_1$ implies also satisfying $S_2$.

In other words, any value that obeys the specification of $S_1$ also obeys the specification of $S_2$, so $S_1$ values can be used anywhere $S_2$ values are expected.

## Subclass vs. Subtyping

**Subclass $\neq$ Subtype.** They solve different problems even though they frequently appear together in Java.

### Subclassing (Code Sharing)
Subclassing is a means of **code sharing**:
- The subclass inherits all fields of the superclass.
- All methods of the superclass are copied into the subclass.
- Ensures the subclass has all methods of the parent class.

### Subtyping (Specification Strengthening)
Subtyping is about **specifications**:
- Each method spec in the subtype must be **stronger** than (or equal to) the corresponding spec in the supertype.
- Subtyping is mostly expressed in the comments / specs, not in the code itself.

A class can extend another class (subclass) without being a true subtype if its method specs weaken the parent's specs. Conversely, two unrelated classes can be subtypes of a common interface without sharing any implementation.

## Why the Distinction Matters

- Subclassing reuses implementation but says nothing about substitutability.
- Subtyping guarantees substitutability (the Liskov Substitution Principle): a subtype instance can be used anywhere the supertype is expected without surprising the client.

## Related
- [[Abstract Data Type]]
- [[CSE331/Part II - Software Engineering/Java Programming/Generics|Generics]]
- [[CSE331/Part II - Software Engineering/Java Programming/Wildcards|Wildcards]] (the PECS rule depends on subtyping relationships)
- [[Stronger Assertions]]
- [[Representation Invariants]]
