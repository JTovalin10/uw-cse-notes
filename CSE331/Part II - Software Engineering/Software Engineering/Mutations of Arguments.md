# CSE331: Mutations of Arguments

When a method mutates an **argument**, the caller's object changes. Unlike [[Local Variable Mutation]], this is visible outside the method and must be declared in the specification.

## Every Input Falls Into One of Three Cases

1. **Input is not allowed** — the precondition rules it out; behavior is unspecified.
2. **Allowed and will return something** — normal case.
3. **Allowed and will throw something** — exceptional case declared by `@throws`.

## Postcondition Can Include Mutation

The [[Postcondition|postcondition]] is not limited to the return value. It can also describe changes to arguments via:

- **[[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]]** — which arguments (or fields) may change.
- **[[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]]** — the new state of anything listed in `@modifies`.

Anything **not** listed in `@modifies` is guaranteed unchanged by the method.

## Example

```java
// @modifies list
// @effects list_post = list_0 ++ [x]
void append(List<Integer> list, int x);
```

The caller's list is mutated; any other list they hold is untouched.

## Related

- [[Mutation]]
- [[Local Variable Mutation]]
- [[Mutations in ADT]]
- [[Postcondition]]
- [[Pre and Post Conditions]]
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]]
- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]]
