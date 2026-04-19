# CSE331: Representation Invariants

A **Representation Invariant (RI)** is a set of facts about the field values of an [[Abstract Data Type|ADT]] that should **always be true**.

- The RI **defines which field values are allowed** — any concrete state violating the RI is considered broken.
- Every operation on the ADT must **preserve** the RI: it holds before the call, and must hold again after the call completes.
- The [[Documenting an ADT Implementation|Abstract Function]] (AF) only needs to apply when the RI is true. The AF is undefined (or meaningless) on states that violate the RI.

## Example

```java
class SortedList {
    private int[] data;
    private int size;
    // RI: 0 <= size <= data.length
    //     and data[0] <= data[1] <= ... <= data[size-1]
}
```

Any method on `SortedList` may assume this RI on entry and must re-establish it before returning.

## Why RIs Matter

- They let the implementer reason locally about one method without worrying that callers have corrupted the fields.
- They document hidden constraints that would otherwise be invisible from reading the code.
- They are the first thing to check when debugging an ADT that is misbehaving.

## Related

- [[Abstract Data Type]]
- [[Documenting an ADT Implementation]]
- [[Mutations in ADT]]
- [[Types of Operations]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Kinds of Specifications|Kinds of Specifications]]
- [[CSE331/Part I - Software Specifications/Definitions/Facts|Facts]]
