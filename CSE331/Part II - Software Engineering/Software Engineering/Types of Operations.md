# CSE331: Types of Operations

[[Abstract Data Type|ADT]] operations fall into three kinds:

- **Observers** — return properties of an object (getters). They do not change the object.
- **Mutators** — change properties of the object (setters). The existing object is modified in place.
- **Producers** — create new objects from an existing one. A new object is returned; the existing object is **not** changed.

![[Screenshot 2025-10-22 at 5.28.02 PM.png]]

## Mutable vs Immutable ADTs

An **immutable** ADT exposes only observers and producers — it has no mutators, so once constructed, the abstract state never changes. An example is `String` in Java.

A **mutable** ADT also exposes mutators. Clients must reason about aliasing because any reference to the object can be used to observe a change made through another reference.

See [[Abstract Data Type]] and [[Mutations in ADT]] for how specifications describe each kind.

![[Screenshot 2025-10-22 at 5.23.37 PM.png]]

## Related

- [[Abstract Data Type]]
- [[Mutations in ADT]]
- [[Mutation]]
- [[Documenting an ADT Implementation]]
- [[Representation Invariants]]
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]]
- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]]
