# CSE341: Mutation and Objects

Implementing object-oriented features requires a foundation in state and mutation. In functional languages, mutation is often added via "refs" (references).

## Implementing Mutation (The "How")

There are two primary ways to implement mutation in an interpreter: using the host language's mutation or manually modeling a **Heap**.

### Method 1: Host Language Refs
The simplest way is to map the guest language's refs directly to OCaml's `ref` type.
```ocaml
type value =
  | Int of int
  | Ref of value ref

let interpret env e =
  match e with
  | AllocRef e -> Ref (ref (interpret env e))
  | ReadRef e -> (match interpret env e with Ref r -> !r)
  | WriteRef (e1, e2) -> 
      (match interpret env e1 with Ref r -> r := interpret env e2; Nil)
```

### Method 2: Manual Heap Modeling
To understand the underlying mechanics, we can model the heap as a mapping from **Addresses** to **Values**. The interpreter must then pass the heap state through every recursive call.

#### Formal Mechanism: State Passing
The signature of the interpreter changes from:
`interpret : env -> expr -> value`
to:
`interpret : env -> heap -> expr -> (value * heap)`

#### Mechanism Steps
1. **AllocRef**:
   - Evaluate the expression to get the initial value.
   - Find a "fresh" address in the current heap.
   - Bind the address to the value in the heap.
   - Return the address and the *new* heap.
2. **ReadRef**:
   - Evaluate the expression to get an address.
   - Look up the address in the current heap.
3. **WriteRef**:
   - Evaluate the address expression.
   - Evaluate the new value expression.
   - Return a new heap where the address is bound to the new value.

### Simplified Explanation
Mutation is hard to implement because it "breaks" the simple tree-like evaluation of expressions. Instead of just looking at the current environment, the interpreter now needs to keep track of a global "notebook" (the heap) that stores the current state of every reference.

---

## From Mutation to Objects

Objects can be viewed as a collection of state (fields) and behavior (methods).

### Object Identity
Mutation is what gives objects **Identity**. Two objects might have the same field values, but if they reside at different heap addresses, they are distinct. Changing one does not affect the other.

### Method Dispatch
Methods can be implemented using **[[CSE341/Definitions/Part5/Closure|Closures]]** stored in the object's fields. "Sending a message" to an object is then equivalent to looking up a closure in the object's record and calling it.

### The `self` Variable
To implement `self` (or `this`), the method closure must have access to the object's own address. This can be achieved by binding `self` in the environment stored within the method closure at the time the object is created.

---

## Related
- [[CSE341/Trefoil Advanced/First-Class Functions|First-Class Functions]]
- [[CSE341/Definitions/Part5/Dynamic Environment|Dynamic Environment]]
