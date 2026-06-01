# CSE 311: Data Types

A **data type** classifies what kind of value a variable holds. If $x$ is a variable of type $T$, this **type annotation** is written $x : T$ and read "$x$ has the type $T$".

**Data types are [[What is a Set|sets]].** A value's type simply tells you which set it belongs to, so type-checking is membership-checking. The most basic built-in types are:

$$\mathbb{N} = \text{natural numbers}$$
$$\mathbb{Z} = \text{all integers}$$
$$\mathbb{R} = \text{all real numbers}$$
$$\mathbb{B} = \text{the boolean values}$$
$$\mathbb{H} = \text{any single character}$$
$$\mathbb{H}^* = \text{any sequence of characters (strings)}$$

These basic types are combined into [[Compound Types|compound types]] (unions, tuples, records) and, with recursion, into [[Foundations of Computing I/Part I - Mathematical Foundations/Data Structures/Inductive Data Types|inductive data types]].

## Related

- [[Compound Types|Compound Types]]
- [[Foundations of Computing I/Part I - Mathematical Foundations/Data Structures/Inductive Data Types|Inductive Data Types]]
- [[What is a Set|What is a Set]]
- [[Foundations of Computing I/Part I - Mathematical Foundations/Functions/Functions|Functions]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Type annotation ($x : T$) | Type declaration / type signature |
| $\mathbb{B}$ (boolean values) | `bool` / `boolean` |
| $\mathbb{H}$ (single character) | `char` |
| $\mathbb{H}^*$ (string) | `String` / `str` |
