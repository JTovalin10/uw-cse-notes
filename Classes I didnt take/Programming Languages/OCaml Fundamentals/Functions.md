# CSE341: Functions

Functions are the most important building block in functional programming. They abstract computation by parameterizing over parts of an [[Expression|Expression]].

## Function Bindings

### Syntax

```ocaml
let f ((x1 : t1), ..., (xN : tN)) = e
```

For recursive functions, the `rec` keyword is added:

```ocaml
let rec f ((x1 : t1), ..., (xN : tN)) = e
```

### Type Checking

Function types are written with arrows: `t1 * ... * tN -> t`. To type-check a function:

1. OCaml type-checks the body `e` in a **[[Classes I didnt take/Programming Languages/Definitions/Part0/Static Environment|Static Environment]]** extended with the arguments `x1 : t1`, ..., `xN : tN`.
2. If `rec` is present, the environment is also extended with `f : t1 * ... * tN -> t` to allow recursive calls to itself.
3. If `e` evaluates to type `t`, the overall function binding adds `f : t1 * ... * tN -> t` to the outer static environment.

### Evaluation

A function is a value. When a function binding is evaluated, the function itself is added to the **[[Classes I didnt take/Programming Languages/Definitions/Part0/Dynamic Environment|Dynamic Environment]]**. If `rec` is present, `f` is also bound within its own body `e` to allow for self-referential execution.

## Function Calls

### Syntax

```
f (e1, ..., eN)
```

### Semantics

1. **Type Checking:** Evaluate the types of `e1` through `eN`. Verify that `f` is a function whose expected parameter types exactly match the types of `e1` through `eN`. The resulting type of the call is the return type of `f`.
2. **Evaluation:**
   - Evaluate `e0` (the function) and arguments `e1` ... `eN` to values `v1` ... `vN` in the current dynamic environment.
   - Evaluate the body of the function `e` in an extended dynamic environment where parameters `x1` ... `xN` map to arguments `v1` ... `vN`.

```ocaml
let rec pow ((base: int), (exp: int)) =
  if exp = 0 then 1
  else base * pow (base, exp - 1)
```

## Related

- [[Variable Bindings|Variable Bindings]]
- [[Syntax and Semantics|Syntax and Semantics]]
- [[First Class Functions and Closures|First Class Functions and Closures]]

## Industry Standard Terms

| Course Term | Industry/Standard Term |
| :--- | :--- |
| Function Binding | Function Definition / Named Function |
| `rec` keyword | Recursive Function Declaration |
| Type-checking body | Static Analysis / Type Verification |
