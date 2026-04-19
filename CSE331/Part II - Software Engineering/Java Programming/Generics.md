# CSE331: Generics

**Generics** let a class or method work with **any type** while preserving type safety at compile time. Instead of writing code that uses `Object` and casts everywhere, you parameterize the code by the type it operates on.

## Type Parameters

Declarations can have any number of type parameters. By convention, short single-letter names are used:

- `E` — element
- `K` — key
- `V` — value
- `T` — general type

Example:

```java
class Box<T> {
    private T value;
    public T get() { return value; }
    public void set(T v) { this.value = v; }
}
```

## Type Constraints

Type declarations **constrain** the value passed in.

![[Screenshot 2025-11-28 at 12.27.59 AM.png]]

Constraints appear as **bounds** on the type parameter.

## Type Bounds

- **Upper bound** — `T extends Base`
  - `T` must be `Base` or a subtype of it.
- **Multiple upper bounds** — use `&`:
  - `A extends B & C & D` means `A` must satisfy **all** of these.

![[Screenshot 2025-11-28 at 12.28.45 AM.png]]

## Type Arguments

- Code can only use methods from the **type bound**.
- You can only call methods guaranteed to be there by the bound.
- Whatever type is passed must satisfy the constraint.
  - If `T extends Comparable<T>`, the passed type must implement `Comparable`.

![[Screenshot 2025-11-28 at 12.29.51 AM.png]]

## Related

- [[Generic Methods]]
- [[Wildcards]]
- [[Type Erasure and Arrays]]
- [[Subtypes]]
- [[Abstract Data Type]]
