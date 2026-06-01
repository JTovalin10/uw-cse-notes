# CSE 331: Abstract Function

The **Abstract Function (AF)** defines what abstract state the field values of an object currently represent. It is a function from the concrete representation (the actual field values) to the abstract value the client reasons about.

The Abstract Function only needs to be defined when the **[[Representation Invariants|Representation Invariant]]** (RI) is true — that is, the AF is only meaningful for field values that form a valid representation. On states that violate the RI, the AF is undefined.

## Related

- [[Representation Invariants|Representation Invariants]]
- [[Documenting an ADT Implementation|Documenting an ADT Implementation]]
- [[Abstract Data Type|Abstract Data Type]]

## Industry Standard Terms

| CSE 331 Term | Industry-Standard Equivalent |
| --- | --- |
| Abstract Function | Abstraction function / interpretation function |
| Representation Invariant (RI) | Class invariant |
