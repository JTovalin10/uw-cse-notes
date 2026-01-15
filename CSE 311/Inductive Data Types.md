# Building with Recursion

The most powerful way to define a new type is by combining basic types (unions, tuples, records) with **recursion**. This allows us to define complex, self-referential data structures whose size is not fixed in advance.

An inductive type definition looks something like this:
$$
\text{type T} := A \mid B(u : \mathbb{N}) \mid C (v : \mathbb{N}, w : T) \mid D(x : \mathbb{N}, y : T, z : T)
$$
The vertical bar `|` represents a **disjoint union**. This means that a value of type `T` must be exactly one of the listed possibilities (`A`, `B`, `C`, or `D`). Unlike a standard union, the values of these different possibilities are always considered distinct, even if they contain common underlying data types.

***

## Constructors

The labels `A`, `B`, `C`, and `D` are called **constructors**. They are the distinct "shapes" or "variants" that a value of type `T` can have.

* They are **not function calls**; they are tags that define the structure of the data.
* They can optionally take arguments (like a tuple or record) to store data.
* Critically, their arguments can be of the type being defined (`T`), which is what allows for recursion.

***

## Types of Constructors by Structure

The number of recursive arguments a constructor takes often determines the kind of data structure it can build.

### ### Zero-Argument: Enum-like
A constructor with no arguments, like `A`, acts as a simple, constant value. If all constructors for a type had zero arguments, the type would be an enumeration (`enum`).

* **Example:** `type Color := Red | Green | Blue`

### ### One Recursive Argument: List-like
A constructor with one argument of its own type, like `C(v: \mathbb{N}, w: T)`, can be used to form linear, chain-like structures. Each new value links to the next, much like a linked list.

* **Classic Example:** A list of integers.
    ```
    type IntList := Nil | Cons(head: Integer, tail: IntList)
    ```
    Here, `Nil` is the zero-argument constructor (the end of the list), and `Cons` is the recursive constructor that builds the chain.

### ### Two or More Recursive Arguments: Tree-like
A constructor with two or more arguments of its own type, like `D(x: \mathbb{N}, y: T, z: T)`, allows for the creation of branching, tree-like structures.

* **Classic Example:** A binary tree of integers.
    ```
    type IntTree := Leaf(value: Integer) | Node(value: Integer, left: IntTree, right: IntTree)
    ```
    Here, `Leaf` is a base case, and `Node` is the recursive constructor that branches into two new sub-trees.

***
[[Data Types]]
[[Compound Types]]