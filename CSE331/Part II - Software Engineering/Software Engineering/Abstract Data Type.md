# CSE331: Abstract Data Type

An **Abstract Data Type (ADT)** gives the client only operations, not data.

- Operations are described in the specification; data is hidden.
- The client reasons about objects through the abstract state exposed by the operations, never through the underlying fields.
- This preserves the **abstraction barrier**: the client does not depend on the implementation, and the implementer is free to change it.

# Terminology

- **Concrete State**
    - The actual fields being stored in the object (the implementation's representation).
- **Abstract State**
    - How clients should think about the object. This is the view described in the specification.
- **Object (obj)**
    - Refers to the abstract state of the object, not its concrete fields.

# Mutable vs Immutable ADTs

See [[Types of Operations]] for the kinds of operations an ADT can expose (observers, mutators, producers) and how these differ between mutable and immutable ADTs.

![[Screenshot 2025-10-22 at 5.23.37 PM.png]]

# Related

- [[Types of Operations]]
- [[Documenting an ADT Implementation]]
- [[Representation Invariants]]
- [[Mutations in ADT]]
- [[The Need for Software Design]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Kinds of Specifications|Kinds of Specifications]]
- [[CSE331/Part II - Software Engineering/Java Programming/Generics|Generics]] — used when implementing generic ADTs in Java
