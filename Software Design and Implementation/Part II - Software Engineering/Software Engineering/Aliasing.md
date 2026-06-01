# CSE331: Aliasing

**Aliases** are extra references to the same object in memory. 

- Aliases are **fine** when objects are **immutable** (we don't care if someone else reads the data, and no one can mutate it).
- Aliases are **scary** when objects are **mutable** (anyone who mutates the object can cause failures far from the bug, making debugging painful).

## Easy Ways to Stay Safe

1. **Do not mutate heap state:** Don't need to think about aliasing at all.
2. **Do not allow aliases to mutable state:**
   - Do not hand out aliases yourself (return copies instead of the internal reference).
   - Make a copy of anything you want to keep (from arguments passed into constructors or methods).
   - For CSE 331, mutable aliasing across files is considered a **bug**.

## Two-Stage Approach (Advanced)
- A mutable object has only one reference (**owner**) that is allowed to use and mutate it.
- The object is eventually "frozen", making it immutable (no longer necessary to track ownership).
- Example: Java's `StringBuilder` (mutable, careful!) vs `String` (immutable, safe). `StringBuilder.toString()` returns the value as a frozen `String`.

## Unmodifiable Views
Java provides methods like `Collections.unmodifiableList()`. This returns a "view" of the underlying list.
- It is **not** a copy of the data.
- It changes whenever the underlying list changes.
- This can lead to difficult bugs (e.g., do not use such a view as a key in a map).
- Often done for performance ($O(1)$ instead of $O(n)$ to copy), but it is safer to stick to immutable objects or copying.

## Rules of Thumb
- **Client Side (e.g., UI):** Data is small. Aliasing is common. **Rule: Avoid mutation.** Create new values instead.
- **Server Side:** Data is large. Aliasing is avoidable. **Rule: Avoid aliases.** Do not allow aliases to your data; hand out copies.

## Related
- [[Mutation]]
- [[Mutations in ADT]]