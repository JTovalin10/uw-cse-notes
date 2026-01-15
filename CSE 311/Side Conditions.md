Sometimes, the structure of a pattern alone isn't enough to decide which rule should apply. A **side condition** is an additional boolean expression, introduced with an `if`, that must be true for the pattern to match.

**The conditions must be exclusive**

The general form looks like this: `function(pattern) := result if condition`

- **Example:** Defining the `not` function using a general variable `b` and side conditions.
    
    $$ \text{not}(b) := \text{F} \quad \text{if } b = \text{T} $$ $$ \text{not}(b) := \text{T} \quad \text{if } b = \text{F}$$

Just like with regular pattern matching, you must be careful to ensure the conditions are **exclusive** (only one can be true) and **exhaustive** (one must be true for any valid input).

---

## Preference for Pure Pattern Matching

In general, it is always better to use pure pattern matching **without** side conditions when possible.

Side conditions are harder to reason about, both for programmers and for automated tools. Pure pattern matching works on the _structure_ of the data (its constructors), which is often simpler to verify and analyze.

For the `not` example above, the standard pattern matching approach is clearer and preferred:

not(T):=F

not(F):=T

---

## When to Use Side Conditions ✍️

We only use side conditions when the logic cannot be expressed through structural pattern matching. This typically happens when a function's behavior depends on a _property_ of a value rather than its _constructor_.

- **Example:** Defining a function on a Real Number (R). You cannot write a "pattern" for all numbers greater than 1. Real numbers don't have distinct constructors like `T` and `F`. Therefore, you must use a side condition to check for this property.
    
    $$ \text{isPositive}(x) := \text{T} \quad \text{if } x > 0 $$ $$ \text{isPositive}(x) := \text{F} \quad \text{if } x \le 0$$

In this case, side conditions are necessary because the distinction between cases (`x > 0` vs `x <= 0`) is not structural.

---
[[Pattern Matching]]