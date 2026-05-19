# CSE 311: Lists (Notation)

This note covers the **notation** used to build and write a [[CSE311/Part I - Mathematical Foundations/Data Structures/List of Integers|List]].

The `::` operator (read **"cons"**) prepends an element to a list:

$$x \mathbin{::} L \quad \text{means} \quad \text{cons}(x, L)$$

The element $x$ becomes the new head, and the existing list $L$ becomes the tail.

**Examples:**

- `nil` = `[]` (the empty list)
- `cons(3, nil)` = `3::nil` = `[3]`

The bracket notation `[...]` is shorthand for the same structure: `[3]` is just a more readable way to write `3::nil`.

## Related

- [[CSE311/Part I - Mathematical Foundations/Data Structures/List of Integers|List of Integers]]
- [[CSE311/Part I - Mathematical Foundations/Functions/Functions on Lists|Functions on Lists]]
- [[CSE311/Part I - Mathematical Foundations/Data Structures/Inductive Data Types|Inductive Data Types]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| `::` (cons) | Prepend / push-front / `x : xs` (Haskell) |
| `nil` / `[]` | Empty list |
