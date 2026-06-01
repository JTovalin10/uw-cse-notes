# Inductive Data Types

While records and tuples allow us to build "small" compound types, we often need data structures of arbitrary size. We achieve this with recursion.

Inductive data types are defined recursively. They combine union with recursion. We describe a set by providing ways of creating its elements, where each way is a "constructor".

## Natural Numbers
The inductive definition of natural numbers ($\mathbb{N}$):
`type N := zero | succ(n: N)`

This defines that a natural number is either `zero` or the successor of another natural number `succ(n)`.
- `zero` represents 0
- `succ(zero)` represents 1
- `succ(succ(zero))` represents 2

Elements are equal only when they were made exactly the same way (e.g., `succ(zero) != succ(succ(zero))`).

## Lists
Lists are our most important data type. The inductive definition of a list of integers:
`type List := nil | cons(x: Z, L: List)`

### Shorthand Notation for Lists
We often use shorthand notation:
- `$x :: L$` means `cons(x, L)`
- `$[1, 2, 3]$` means `1 :: 2 :: 3 :: nil`

### Structural Recursion
Functions defined on inductive types often use **structural recursion** where they recurse only on *parts* of the input.
For example, a function `len` on a list:
- $len(\text{nil}) := 0$
- $len(x :: L) := 1 + len(L)$

Because one argument gets *strictly smaller* on each recursive call, structural recursion guarantees no infinite recursion.
