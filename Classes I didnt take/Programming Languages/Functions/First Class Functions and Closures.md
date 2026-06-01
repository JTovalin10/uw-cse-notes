# CSE341: First Class Functions and Closures

This unit covers the foundational concepts of functional programming in OCaml, focusing on how functions are treated as first-class citizens and the mechanics of lexical scoping and closures.

## Exceptions

**[[Classes I didnt take/Programming Languages/Definitions/Part2/Exception|Exceptions]]** in OCaml are used to handle errors or unusual conditions.

- **Exception Bindings**: Declare new exceptions.
  ```ocaml
  exception Bogus
  exception BadNum of int
  ```
- **Raising Exceptions**: Use the `raise` keyword.
  ```ocaml
  raise Bogus
  raise (BadNum 1)
  ```
- **Catching Exceptions**: Use `try ... with` blocks.
  ```ocaml
  try e with Bogus -> 0 | BadNum n -> n
  ```

### The `exn` Type

OCaml has a single extensible type `exn` for all exceptions. New exception bindings add new variants to this type. A `raise e` expression has a result type of "any type" (polymorphic) because it never actually returns a value — it cancels current execution and unwinds the stack to the nearest handler.

## First-Class Functions

A language has **[[First Class Function|First Class Functions]]** if functions can be used wherever other values (like integers) can be used.

### Higher-Order Functions

A **[[Higher Order Function|Higher Order Function]]** is a function that takes or returns other functions.

```ocaml
let rec n_times (f, n, x) =
  if n = 0 then x
  else f (n_times (f, n - 1, x))

(* val n_times : ('a -> 'a) * int * 'a -> 'a *)
```

### Map and Filter

Two "hall-of-fame" higher-order functions:

- **Map**: Applies a function to every element in a list.
  ```ocaml
  let rec map f xs =
    match xs with
    | [] -> []
    | x :: xs' -> f x :: map f xs'
  ```
- **Filter**: Keeps only elements that satisfy a predicate.
  ```ocaml
  let rec filter f xs =
    match xs with
    | [] -> []
    | x :: xs' -> if f x then x :: filter f xs' else filter f xs'
  ```

## Function Closures and Lexical Scope

The most critical concept in this unit is **[[Classes I didnt take/Programming Languages/Definitions/Part2/Lexical Scope|Lexical Scope]]**: function bodies evaluate in the environment where the function was **defined**, not where it is called.

### The Closure Model

A function value is actually a **[[Function Closure|Function Closure]]**, which is a pair of:

1. The function's code.
2. The environment at the time of definition.

### Why Lexical Scope?

1. **Predictability**: Variable names in a function can be changed (alpha-conversion) without breaking callers.
2. **Type Checking**: Functions can be type-checked based on the environment at their definition site.
3. **Data Encapsulation**: Closures can store private data in their environment.

```ocaml
let x = 1
let f y = x + y (* x is bound to 1 in f's closure *)
let x = 2
let z = f 5 (* evaluates to 6, NOT 7 *)
```

```mermaid
graph LR
    subgraph definition ["At Definition Site"]
        ENV1["env: {x → 1}"]
        FUN["fun y -> x + y"]
        CL["Closure = (code, {x → 1})"]
    end
    subgraph call ["At Call Site"]
        ENV2["env: {x → 2, f → Closure}"]
        CALL["f 5"]
        RES["Result: 1 + 5 = 6"]
    end
    ENV1 --> CL
    FUN --> CL
    CL -->|"closure env used, not caller env"| RES
    CALL --> RES
```

## Currying and Partial Application

**[[Currying|Currying]]** is the practice of having a function take one argument and return a function that takes the next, instead of using tuples.

### Syntactic Sugar

OCaml provides sugar for defining and calling curried functions:

```ocaml
(* Definition sugar *)
let add x y = x + y
(* equivalent to *)
let add = fun x -> fun y -> x + y

(* Call sugar *)
let sum = add 3 4
(* equivalent to *)
let sum = (add 3) 4
```

### Partial Application

**[[Partial Application|Partial Application]]** occurs when we provide fewer arguments than the function expects, receiving a specialized closure back.

```ocaml
let is_non_negative = (<=) 0
let remove_negatives = List.filter (fun x -> x >= 0)
(* Better style using partial application *)
let remove_negatives = List.filter ((<=) 0)
```

### The Value Restriction

A polymorphic function created via partial application may fail to type-check due to the **Value Restriction**.

```ocaml
let pair_with_one = List.map (fun x -> (1, x)) 
(* May cause a 'monomorphism' error if used polymorphically *)
```

Workaround: Use "not-so-unnecessary function wrapping" (Eta expansion).

```ocaml
let pair_with_one xs = List.map (fun x -> (1, x)) xs
```

## Folding

`fold_left` and `fold_right` are powerful iterators that "collapse" a collection into a single value.

```ocaml
let sum = List.fold_left (+) 0 [1; 2; 3] (* 6 *)
```

### Comparison

| Feature | `fold_left` | `fold_right` |
| :--- | :--- | :--- |
| **Direction** | Left-to-right (tail-recursive) | Right-to-left |
| **Accumulator** | First argument to $f$ | Second argument to $f$ |
| **Formula** | $f(...f(f(acc, v_1), v_2)..., v_n)$ | $f(v_1, f(v_2, ...f(v_n, acc)...))$ |

## Related

- [[Mutation and Aliasing|Mutation and Aliasing]]
- [[Delayed Evaluation|Delayed Evaluation]]
- [[Classes I didnt take/Programming Languages/Type Systems/Type Inference|Type Inference]]

## Industry Standard Terms

| Course Term | Industry/Standard Term |
| :--- | :--- |
| First-Class Function | First-Class Function / Function as Value |
| Higher-Order Function | Higher-Order Function / Functor (in some languages) |
| Function Closure | Closure / Lambda Capture |
| Lexical Scope | Lexical Scoping / Static Scoping |
| Currying | Currying / Function Currying |
| Partial Application | Partial Application / Partial Function Application |
| Eta Expansion | Eta Expansion / Function Wrapping (Value Restriction workaround) |
