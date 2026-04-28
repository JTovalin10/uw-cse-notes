# CSE331: Equality

For any type, it is useful to know which objects are "the same".

- `==` in Java checks **reference equality**. It tells you if they refer to the same object in memory. This is often not useful for user-defined records.
- Checking if the concrete fields are the same is also wrong, because different concrete states can represent the same abstract state.
- **Same abstract states should be considered equal.**

## Properties of Equality
A sensible definition of equality should act like "=" in math (an equivalence relation):
1. **Reflexive:** `equal(a, a) = true`
2. **Symmetric:** `equal(a, b) = equal(b, a)`
3. **Transitive:** If `equal(a, b)` and `equal(b, c)`, then `equal(a, c)`

## Equals in Java
Every class inherits an `equals` method from `Object`, which implements reference equality (`this == o`). To check abstract state equality, you must override it.

Java requires the following properties for `equals`:
1. `a.equals(a) == true` (Reflexive)
2. `a.equals(b) == b.equals(a)` (Symmetric)
3. `a.equals(b) && b.equals(c) ⇒ a.equals(c)` (Transitive)
4. `a.equals(null) == false` (Asymmetric with null)
5. `a.equals(b)` cannot change value unless `a` or `b` is mutated (Consistency).

*Note: The parameter must be of type `Object`, i.e., `public boolean equals(Object o)`.*

## Equality and Subclasses
Defining equality correctly across subclasses is very difficult without breaking symmetry or transitivity. 
- Example: A `Duration` (minutes, seconds) and a `NanoDuration` (minutes, seconds, nanoseconds). If they can be equal to each other, transitivity or symmetry is easily broken.
- Best solution: Have both agree that they are not equal, because they have different abstract states (time in seconds vs time in nanoseconds). This tightly couples the classes. Usually, it's better to avoid subclassing altogether.

## HashCode
- Java has another method called `hashCode()`, provided to make `HashMap`, `HashSet`, etc., work.
- **Rule:** When you override `equals`, you **must** also override `hashCode`.
- Requirements for `hashCode`:
  1. `a.hashCode()` cannot change value unless `a` is mutated (self-consistency).
  2. `a.equals(b) ⇒ a.hashCode() == b.hashCode()` (consistent with equals).

## Related
- [[Subclasses]]
- [[Representation Invariants]]