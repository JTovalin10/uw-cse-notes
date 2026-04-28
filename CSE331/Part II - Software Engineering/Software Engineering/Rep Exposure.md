# CSE331: Representation Exposure

**Representation Exposure** (or rep exposure) occurs when a client can obtain a reference to a mutable object that is part of an ADT's internal abstract state. This is a severe bug because it allows the client to break the Representation Invariant (RI) without calling any mutator methods on the ADT.

## How it Happens
- **Returning an alias:** A method returns a direct reference to a mutable field (e.g., `return this.vals;` where `vals` is an array or a `List`).
- **Storing an alias:** A constructor or mutator takes a mutable object and stores it directly without copying (e.g., `this.vals = inputArray;`).

## Why it is Dangerous
- If a client has an alias to the internal mutable state, they can modify it directly.
- The ADT cannot intercept this modification, meaning the RI could be violated without the ADT knowing.
- Bugs caused by rep exposure are incredibly difficult to track down because the failure often occurs far away from the code that caused the mutation.

## How to Prevent Rep Exposure
For mutable internal state, you must avoid aliasing.
1. **Make copies on the way out:** If you need to return mutable internal state, return a copy of the object (e.g., `Arrays.copyOf(this.vals, ...)`).
2. **Make copies on the way in:** If a constructor or method accepts a mutable object that will be stored, make a copy of it and store the copy.
3. **Use Immutable Types:** If your internal state relies on immutable types (like `String` or `Integer`), rep exposure is impossible because the client cannot mutate the object.

## Related
- [[Aliasing]]
- [[Defensive Programming]]
- [[Representation Invariants]]