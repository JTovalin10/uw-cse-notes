# CSE331: Mutations in ADT

Mutation inside an [[Abstract Data Type|ADT]] method changes the fields of `this`. The client reasons about the object through its **abstract state**, so the spec describes mutation in terms of the abstract state rather than the concrete fields.

## Immutable vs Mutable Operations

**Immutable** (produces a new object):

```java
// @return [x] ++ obj
NumberQueue enqueue(int x);
```

The original `obj` is unchanged; the method returns a fresh queue with `x` at the front.

**Mutable** (modifies the receiver):

```java
// @modifies obj
// @effects obj = [x] ++ obj_0
void enqueue(int x);
```

- `obj` is the receiver's abstract state.
- `obj_0` is its value *before* the call.
- The caller sees the updated object through the same reference.

## Why the Distinction Matters

- An immutable spec lets the caller share references freely without surprise.
- A mutable spec forces the caller to reason about aliasing — anyone holding the same reference will see the change.
- The implementation must still preserve the [[Representation Invariants|representation invariant]] after any mutation.

## Related

- [[Abstract Data Type]]
- [[Mutation]]
- [[Mutations of Arguments]]
- [[Types of Operations]]
- [[Representation Invariants]]
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]]
- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]]
