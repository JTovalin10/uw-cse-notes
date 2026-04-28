# CSE331: Writing Method Specs in Java

In Java, method specifications are written as **Javadoc comments** directly above the method declaration.

## What Every Javadoc Comment Includes

- An **overview sentence** — the first sentence, a short summary of what the method does.
- Explanation of each **parameter** (`@param`).
- What is **returned** (`@return`).
- Any **exceptions thrown** (`@throws`).

## Standard Tags

| Tag | Purpose |
|-----|---------|
| `@param name desc` | Describe each parameter |
| `@return desc` | Describe the return value |
| `@throws Ex desc` | Describe when exception `Ex` is thrown |
| `@spec.requires` | State the precondition |
| `@spec.modifies` | See [[@modifies]] |
| `@spec.effects` | See [[@effects]] |

## Three Input Cases

Every input to a method falls into one of three cases:
1. **Input is disallowed** — stated in `@param` and `@spec.requires` (the precondition).
2. **Input is allowed and returns something** — stated in `@return`.
3. **Input is allowed and throws something** — stated in `@throws`.

The postcondition can also include mutation effects, stated in `@spec.modifies` and `@spec.effects`.

## Worked Examples

### Example 1: `indexOf` — basic search

```java
/**
 * Returns the index of x in list, or -1 if not present.
 * @param list the list to search; must be non-null
 * @param x the value to find
 * @return the smallest i such that list.get(i).equals(x), or -1 if x is not in list
 * @throws NullPointerException if list is null
 */
static int indexOf(List<?> list, Object x) { ... }
```

Note the precise `@return`: it names the *smallest* index, not just *an* index. This rules out implementations that return the last occurrence.

### Example 2: `concat` — immutable version

```java
/**
 * Returns the concatenation of two lists.
 * @param A The first list. Must be non-null
 * @param B The second list. Must be non-null
 * @return a list containing the elements of A followed by all the elements of B
 */
List<Integer> concat(List<Integer> A, List<Integer> B)
```

No `@spec.modifies` means neither `A` nor `B` is changed. The result is a fresh list.

### Example 3: `concat` — mutating version

The same operation written as a mutator instead of a producer:

```java
/**
 * Appends all elements of B to the end of A.
 * @param A The first list. Must be non-null
 * @param B The second list. Must be non-null
 * @spec.modifies A
 * @spec.effects A = A_0 ++ B
 */
void concat(List<Integer> A, List<Integer> B)
```

The [[@effects]] clause uses [[CSE331/Part I - Software Specifications/Software Specifications/Floyd Logic|Floyd logic]] notation: `A_0` is the value of `A` before the call. The absence of `B` from `@spec.modifies` promises `B` is unchanged.

### Example 4: `changeFirst` — precise mutation spec

```java
/**
 * Changes the first instance of v in A to w.
 * @param A The list to look in. Must be non-null
 * @param v The value to look for
 * @param w The value to replace the first v with
 * @spec.modifies A
 * @spec.effects changes A[i] = w, where i is the smallest index
 *               with A[i] = v, and leaves A[j] unchanged for all j ≠ i
 * @throws NotFound if no such index i exists
 */
void changeFirst(List<Integer> A, int v, int w)
```

### Example 5: `commonElems` — sorting side effect

```java
/**
 * Returns the number of common elements in both A and B.
 * Sorts A and B in the process.
 * @param A The first list. Must be non-null
 * @param B The second list. Must be non-null
 * @spec.modifies A, B
 * @spec.effects A is sorted and B is sorted
 * @return the number of indexes i such that A[i] also appears in B somewhere
 */
int commonElems(List<Integer> A, List<Integer> B)
```

The overview sentence explicitly mentions the sorting side effect — clients who don't read `@spec.effects` still get warned.

## Comparing Specs for the Same Method

Two specs for the same method can be **compared** by strength. S1 is stronger than S2 if satisfying S1 implies satisfying S2. In terms of tags:

| Stronger spec has... | Weaker spec has... |
|---------------------|-------------------|
| More in `@return` | Less in `@return` |
| More in `@spec.effects` | Less in `@spec.effects` |
| **Less** in `@spec.modifies` | **More** in `@spec.modifies` |
| Less in `@spec.requires` (weaker precondition) | More in `@spec.requires` |

Removing something from `@spec.modifies` **strengthens** the spec because it adds a new promise (that thing will not be changed).

## Related

- [[Kinds of Specifications]]
- [[Pre and Post Conditions]]
- [[Postcondition]]
- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]]
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]]
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutations of Arguments|Mutations of Arguments]]
