# CSE331: Subclasses

Subclassing (`extends` in Java) is a means of sharing code, but it is a surprisingly **dangerous feature** that tends to break modularity.

## Subclassing Creates Tight Coupling
Subclassing creates tight coupling between the superclass and the subclass.
- Direct field access in the parent can break the subclass.
- The subclass becomes dependent on which methods call each other in the superclass.
- The subclass becomes dependent on the *order* of method calls in the superclass.
- A subclass can be called when the Representation Invariant (RI) is false (e.g., during a superclass method call that temporarily breaks the RI).

This often leads to the **"fragile base class"** problem, where changes to the superclass (even if they preserve its specification) unexpectedly break subclasses.

## Best Practices
- **EJ 19:** Either design for subclassing or prohibit it.
- **EJ 18:** Prefer composition to inheritance.
- In CSE 331, we generally avoid subclassing for ADTs. We use interfaces and implement them with classes to avoid these coupling problems.

## Related
- [[Module Design]]
- [[Abstract Data Type]]