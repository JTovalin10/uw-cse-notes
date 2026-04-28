# CSE331: @modifies

**`@modifies`**: Lists anything that *may* be changed by the method.

- Anything not listed in `@modifies` is **assumed not modified** — this is a promise to the client.
- No `@modifies` means nothing is mutated.
- Pairs with [[@effects]], which describes *how* the listed items are changed.

## Key Rule

The absence of something from `@modifies` is itself a guarantee. If `B` is not in `@modifies`, the spec promises that `B` will be the same after the call as it was before. Clients can rely on this.

## Worked Examples

### Example 1: `clear`

```java
// @modifies A
// @effects all entries of A set to zero
void clear(int[] A)
```

`A` appears in `@modifies`, so clients know `A` will change. The `@effects` clause says exactly how.

### Example 2: `concat` — which argument to list

```java
/**
 * Appends all elements of B to the end of A.
 * @modifies A
 * @effects A = A_0 ++ B
 */
void concat(List<Integer> A, List<Integer> B)
```

Only `A` appears in `@modifies`. This promises that `B` is **not** changed by the call — even though the method reads from `B`. Clients who pass `B` can trust it is unmodified after the call.

### Example 3: `commonElems` — multiple modified arguments

```java
/**
 * @modifies A, B
 * @effects A is sorted and B is sorted
 * @return the number of common elements
 */
int commonElems(List<Integer> A, List<Integer> B)
```

Both `A` and `B` appear in `@modifies` because both may be sorted in place.

### Example 4: Mutable ADT — `obj`

When a method mutates the ADT's own abstract state, `@modifies` lists `obj`:

```java
/**
 * Adds x to the front of this list.
 * @modifies obj
 * @effects obj = x :: obj_0
 */
void cons(int x);
```

### Example 5: Removing from `@modifies` strengthens a spec

Narrowing the `@modifies` list is a **strengthening** — it adds a new promise.

| Spec | `@modifies` | Notes |
|------|------------|-------|
| S3 | A, B | Says both A and B *may* change |
| S4 | A | Promises B will *not* change |

S4 is stronger than S3 because it restricts what the implementation is allowed to do.

## Related
- [[@effects]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Postcondition|Postcondition]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Pre and Post Conditions|Pre and Post Conditions]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Writing Methods Specs in Java|Writing Methods Specs in Java]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutation|Mutation]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutations of Arguments|Mutations of Arguments]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutations in ADT|Mutations in ADT]]
