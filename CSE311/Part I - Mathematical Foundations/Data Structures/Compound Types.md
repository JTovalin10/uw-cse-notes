# CSE 311: Compound Types

Compound types combine simpler types to form new ones. The three fundamental compound types are **union**, **tuple**, and **record**.

---

## Union: The "Or" Type

A **union** combines types by saying a value can be **one type _or_ another**.

- **Formal Definition:** $A \cup B$ is a value that is either in set $A$ or in set $B$.
- **Simple Analogy:** A basket that can hold either an apple or a banana has type `Apple ∪ Banana`.
- **Example:** A variable storing either a number (`Integer`) or an error message (`String`) would have a union type.

---

## Tuple: The "Ordered Pair" Type

A **tuple** combines types into a **fixed-size, ordered list**. Position identifies each item.

- **Formal Definition:** $A \times B$ is a pair $(a, b)$ where the first item must be from type $A$ and the second from type $B$.
- **Simple Analogy:** A 2D coordinate like $(10, 20)$ — order is crucial; $(10, 20) \neq (20, 10)$.
- **Accessing Parts:** Unpack by position: `let (a, b) := t` gives `a = 10` and `b = 20`.

---

## Record: The "Named Pair" Type

A **record** combines types where each item is identified by a **name**, not its position.

- **Formal Definition:** `{x: A, y: B}` has a field `x` of type $A$ and a field `y` of type $B$.
- **Simple Analogy:** A contact card `{name: "Alex", age: 30}` — you access by label, not position.
- **Accessing Parts:** Use dot notation: `f.x` returns the value of field `x`.

---

## Tuple vs. Record — Position vs. Name

| Property | Tuple | Record |
| --- | --- | --- |
| Access method | Positional (by index) | By name (label) |
| Readability | Anonymous — type `(String, Integer)` gives no clue about meaning | Self-describing — `{name: String, age: Integer}` documents intent |
| Order | Order matters — `(String, Integer)` ≠ `(Integer, String)` | Order irrelevant — fields are equivalent regardless of order |
| Best for | Short-lived data, return values, universally-understood positions (e.g. `(x, y, z)`) | Structured data used in many places; data whose fields may grow |

In summary: a tuple `("Alice", 30)` and a record `{name: "Alice", age: 30}` hold the same raw data, but the record is more explicit, readable, and maintainable.

## Related

- [[Data Types]]
- [[Inductive Data Types]]
- [[Functions]]
- [[What is a Set]]
