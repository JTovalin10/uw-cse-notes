# CSE 311: Inductive Data Types

The most powerful way to define a new type is by combining basic types (unions, tuples, records) with **recursion**. This allows us to define complex, self-referential data structures whose size is not fixed in advance.

An inductive type definition looks like this:
$$\text{type } T := A \mid B(u : \mathbb{N}) \mid C(v : \mathbb{N},\ w : T) \mid D(x : \mathbb{N},\ y : T,\ z : T)$$

The vertical bar `|` represents a **disjoint union** — a value of type $T$ must be exactly one of the listed possibilities. Unlike a standard union, the variants are always considered distinct even if they share underlying data types.

---

## Constructors

The labels `A`, `B`, `C`, `D` are called **constructors** — the distinct "shapes" a value of type $T$ can take.

- They are **not** function calls; they are tags that define the structure of the data.
- They can optionally take arguments (like a tuple or record) to store data.
- Arguments can be of the type being defined (`T`), enabling recursion.

---

## Types of Constructors by Structure

### Zero-Argument: Enum-like

A constructor with no arguments acts as a simple constant. If all constructors take no arguments, the type is an enumeration.

- **Example:** `type Color := Red | Green | Blue`

### One Recursive Argument: List-like

A constructor with one recursive argument forms linear, chain-like structures — like a linked list.

- **Classic Example:**
    ```
    type IntList := Nil | Cons(head: Integer, tail: IntList)
    ```
    `Nil` ends the list; `Cons` extends it by one element.

### Two or More Recursive Arguments: Tree-like

A constructor with two or more recursive arguments allows branching, tree-like structures.

- **Classic Example:**
    ```
    type IntTree := Leaf(value: Integer) | Node(value: Integer, left: IntTree, right: IntTree)
    ```
    `Leaf` is the base case; `Node` branches into two sub-trees.

---

## Related

- [[Data Types]]
- [[Compound Types]]
- [[Recursive Definition of Sets]]
- [[List of Integers]]
- [[Rooted Binary Tree Definition]]
- [[Structural Induction]]
