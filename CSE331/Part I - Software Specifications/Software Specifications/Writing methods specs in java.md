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
| `@spec.requires` | State the [[Pre and Post Conditions\|precondition]] |
| `@spec.modifies` | See [[CSE331/Part I - Software Specifications/Definitions/@modifies\|@modifies]] |
| `@spec.effects` | See [[CSE331/Part I - Software Specifications/Definitions/@effects\|@effects]] |

## Example

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

## Related

- [[Kinds of Specifications]]
- [[Pre and Post Conditions]]
- [[Postcondition]]
- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]]
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]]
