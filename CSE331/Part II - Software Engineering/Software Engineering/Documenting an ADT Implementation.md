# CSE331: Documenting an ADT Implementation

When we write an [[Abstract Data Type|ADT]], the client sees only the **abstract state** (exposed by operations). The implementation stores **concrete state** (the fields). Two pieces of documentation connect them.

## Key Ideas

- The **abstract state** is a simple, client-facing definition of the object.
- Clients use the abstract state to reason about calls to this code.
- We write **specifications** in terms of the abstract state.
- We also need to **reason about the ADT implementation** — and for that we need to say how the fields map to the abstract state.

## Abstract Function (AF)

The **Abstract Function** defines *what* abstract state the current field values represent. It is a function from the concrete representation to the abstract value.

```
// AF(this) = the set containing exactly the elements
//            stored in this.items[0..this.size-1]
```

If two different field configurations represent the same abstract value, the AF maps both to that abstract value (the AF is total on the set of *valid* concrete states).

![[Screenshot 2025-10-22 at 5.31.24 PM.png]]

## Representation Invariant (RI)

The **[[Representation Invariants|Representation Invariant]]** says *which* field values are allowed. The AF only needs to be defined (and only needs to make sense) when the RI holds.

Together the AF and RI document what the fields mean and what they must satisfy — this is the key to understanding any non-trivial ADT implementation.

## Related

- [[Abstract Data Type]]
- [[Representation Invariants]]
- [[Types of Operations]]
- [[Mutations in ADT]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Kinds of Specifications|Kinds of Specifications]]
