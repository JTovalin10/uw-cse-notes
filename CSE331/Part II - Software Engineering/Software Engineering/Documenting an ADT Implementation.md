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

## Correctness of ADT Implementation

To prove an ADT implementation is correct, you must use both the RI and AF.

### Correctness of Immutable ADTs
1. **Check the constructor:** 
   - Creates a concrete state satisfying the RI.
   - Creates the abstract state required by the spec (verified using the AF).
2. **Check the correctness of each method:** 
   - Check the value returned is the one stated by the spec.
   - Will need to use the RI in most methods.
   - Will need to use the AF in every method to translate concrete state to abstract state.

### Correctness of Mutable ADTs
1. **Check the constructor:** Same as immutable.
2. **Check the correctness of each observer method:** Same as immutable.
3. **Check the correctness of each mutator method:**
   - Check abstract state produced is the one stated by the spec.
   - Check that the **RI still holds** at the end.
   - Make sure there are **no aliases** (prevent representation exposure).

## Related

- [[Abstract Data Type]]
- [[Representation Invariants]]
- [[Types of Operations]]
- [[Mutations in ADT]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Kinds of Specifications|Kinds of Specifications]]
