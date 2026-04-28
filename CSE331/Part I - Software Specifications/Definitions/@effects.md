# CSE331: @effects

**`@effects`**: Lists the results of mutation — the promises about what the state will look like when the call returns.

- No `@effects` means any change to the modified objects is possible.
- Works together with [[@modifies]], which lists *what* may be changed; `@effects` says *how* it is changed.
- Specifications can also use [[CSE331/Part I - Software Specifications/Software Specifications/Floyd Logic|Floyd Logic]] notation in `@effects` clauses (e.g., `obj = obj_0 ++ B`).

## Basic Example

```java
// @modifies A
// @effects all entries of A set to zero
void clear(int[] A)
```

## Worked Examples

### Example 1: `changeFirst`

Changes the first occurrence of a value in a list:

```java
/**
 * Changes the first instance of v in A to w.
 * @param A The list to look in. Must be non-null
 * @param v The value to look for
 * @param w The value to replace the first v with
 * @modifies A
 * @effects changes A[i] = w, where i is the smallest index
 *          with A[i] = v, and leaves A[j] unchanged for all j ≠ i
 * @throws NotFound if no such index i exists
 */
void changeFirst(List<Integer> A, int v, int w)
```

Note that `@effects` here precisely describes exactly which index changes and what the rest of the list looks like — not just "something changed."

### Example 2: Mutating `concat`

The immutable version returns a new list. The mutating version modifies `A` in place using Floyd logic notation:

```java
/**
 * Appends all elements of B to the end of A.
 * @param A The first list. Must be non-null
 * @param B The second list. Must be non-null
 * @modifies A
 * @effects A = A_0 ++ B
 */
void concat(List<Integer> A, List<Integer> B)
```

Here `A_0` refers to the value of `A` before the call. `B` is not listed in `@modifies`, so the spec promises `B` is unchanged.

### Example 3: `commonElems` — what to put in `@effects`

```java
/**
 * Returns the number of common elements in both A and B.
 * Sorts A and B in the process.
 * @param A The first list. Must be non-null
 * @param B The second list. Must be non-null
 * @modifies A, B
 * @effects A is sorted and B is sorted
 * @return the number of indexes i such that A[i] also appears in B somewhere
 */
int commonElems(List<Integer> A, List<Integer> B)
```

### Example 4: Mutable ADT operations

When specifying mutators on an ADT, `@effects` uses `obj` to refer to the abstract state and `obj_0` for the value before the call:

```java
/**
 * Adds x to the front of this list.
 * @modifies obj
 * @effects obj = x :: obj_0
 */
void cons(int x);

/**
 * Moves the point right by dx and up by dy.
 * @modifies obj
 * @effects obj = (x_0 + dx, y_0 + dy)
 */
void shiftBy(double dx, double dy);

/**
 * Adds x to the front of the queue.
 * @modifies obj
 * @effects obj = [x] ++ obj_0
 */
void enqueue(int x);
```

## Comparing Specs with Different `@effects`

A spec is **stronger** if its `@effects` clause promises more. For `commonElems`:

| Spec | `@modifies` | `@effects` | Relation |
|------|------------|-----------|---------|
| S1 | A, B | A is sorted and B is sorted | stronger |
| S2 | A, B | (empty — any change possible) | weaker |

S1 is stronger than S2 because `@effects` adds more constraints on what will happen.

Removing a variable from `@modifies` also **strengthens** a spec (it promises not to change something that was previously listed as possibly changed):

| Spec | `@modifies` | `@effects` | Relation |
|------|------------|-----------|---------|
| S3 | A, B | A is sorted | weaker |
| S4 | A | A is sorted | stronger (promises B not changed) |

## Related
- [[@modifies]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Postcondition|Postcondition]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Pre and Post Conditions|Pre and Post Conditions]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Writing Methods Specs in Java|Writing Methods Specs in Java]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutation|Mutation]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutations of Arguments|Mutations of Arguments]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutations in ADT|Mutations in ADT]]
