# Compound Types in Math

Compound types combine multiple data types together. There are multiple ways to build them.

## Record Types
A record type consists of fields, each with a name and a value of a specific type.
- Example type: $\{x: \mathbb{N}, y: \mathbb{N}\}$
- Example element: $\{x: 3, y: 5\}$

In math, field names matter, but not the order. Thus, $\{x: 3, y: 5\} = \{y: 5, x: 3\}$.
Note that "$=$" in math means they represent the same values (unlike reference equality in some programming languages).

## Tuple Types
A tuple is an ordered sequence of elements.
- Example type: $\mathbb{N} \times \mathbb{N}$
- Example element: $(5, 7)$

Tuples can be of 3, 4, or more elements. Since order matters, you distinguish parts by their order, whereas records distinguish parts by name.

To refer to tuple parts, we must give them names. For example:
Let $(a, b) := t$.
"$:=$" means a definition. If we know that $t = (5, 7)$, then we have defined $a = 5$ and $b = 7$.
