# CSE341: Trefoil Functions and Scoping

Trefoil v3 introduces top-level bindings and first-class-ish functions. A critical design decision in any language with functions is the choice of **scoping discipline**.

## Top-Level Bindings

Bindings in Trefoil are introduced with `define`. Unlike `let`, which is an expression that returns a value, `define` is a **binding** that modifies the global [[CSE341/Definitions/Part4/Environment|Environment]].

```ocaml
type binding =
  | ExprBinding of expr                (* Evaluate an expression *)
  | VarBinding of string * expr        (* (define x 10) *)
  | FnBinding of string * string * expr (* (define (f x) (+ x 1)) *)
```

### Interpretation of Bindings
Evaluating a list of bindings results in a final [[CSE341/Definitions/Part4/Environment|Environment]].

```ocaml
let interpret_binding env binding : env =
  match binding with
  | VarBinding (s, e) ->
      let v = interpret env e in
      bind s (VarEntry v) env
  | FnBinding (f_name, arg_name, body) ->
      (* Store the function along with the CURRENT environment *)
      bind f_name (FnEntry (arg_name, body, env)) env
```

## Scoping: Lexical vs Dynamic

The most important concept in Trefoil v3 is the distinction between [[CSE341/Definitions/Part4/Lexical Scope|Lexical Scope]] and [[CSE341/Definitions/Part4/Dynamic Scope|Dynamic Scope]].

### Dynamic Scope
In dynamic scope, a function is evaluated in the environment of its **caller**.
- **Implementation**: When calling a function, extend the *current* environment with the argument binding.
- **Problem**: Variables can be "shadowed" or "captured" by the caller, making behavior unpredictable and breaking modularity.

### Lexical Scope (The Trefoil Standard)
In lexical scope, a function is evaluated in the environment where it was **defined**.
- **Mechanism**: The language uses a [[CSE341/Definitions/Part4/Closure|Closure]]. A closure stores:
  1. The argument name.
  2. The function body.
  3. The **defining environment** (the environment that existed when the `define` was executed).
- **Formal Definition**: To call function `f` with argument `e`:
  1. Evaluate `e` to `v` in the *current* environment.
  2. Look up `f` in the current environment to get its closure `(arg_name, body, def_env)`.
  3. Evaluate `body` in `def_env` extended with `arg_name -> v`.

```ocaml
| FnCall (f_name, arg_expr) -> (
    match lookup f_name env with
    | Some (FnEntry (arg_name, body, defining_env)) ->
        let arg_value = interpret env arg_expr in
        (* Bind argument in the DEFINING environment, not the current one *)
        let extended_env = bind arg_name (VarEntry arg_value) defining_env in
        interpret extended_env body
    | _ -> failwith "not a function")
```

## Recursion in Trefoil

Implementing recursion requires a small tweak to the lexical scope implementation. If a function `f` is defined in environment `E`, its closure normally contains `E`. However, `f` itself is not in `E` yet (it's being added *to* `E`). Thus, `f` cannot call itself.

### The "Recursion Fix"
To support recursion, the function name must be added to the environment used during the call.

```ocaml
| Some (FnEntry (arg_name, body, defining_env)) ->
    let arg_value = interpret env arg_expr in
    (* 1. Start with the defining environment *)
    (* 2. Bind the function name to its own closure (for recursion) *)
    let env_with_fn = bind f_name (FnEntry (arg_name, body, defining_env)) defining_env in
    (* 3. Bind the argument *)
    let final_env = bind arg_name (VarEntry arg_value) env_with_fn in
    interpret final_env body
```

### Simplified Explanation: The Recursive "Cheat"
When a function calls itself, the interpreter "re-injects" the function's own definition into the environment before running the body. This ensures that any reference to the function's name inside its own body resolves correctly.

## Scope Walkthrough Example

```racket
(define x 1)
(define (f y) (+ x y))
(define x 10)
(f 5)
```

1. **Lexical Scope Result**: `6`. 
   - `f` was defined when `x` was `1`. The closure for `f` captures `x=1`.
2. **Dynamic Scope Result**: `15`. 
   - `f` is called when `x` is `10`. It uses the current value of `x`.

### Implementation Trade-offs
| Feature | Lexical Scope | Dynamic Scope |
|---------|---------------|---------------|
| Predictability | High (check source code) | Low (check call stack) |
| Tooling | Easy to analyze statically | Difficult to analyze |
| Implementation | Requires [[CSE341/Definitions/Part4/Closure|Closures]] | Simpler (no closures) |
| Standard in | OCaml, Racket, Java, C++ | Emacs Lisp (by default) |

### Related
- [[CSE341/Trefoil Basics/Trefoil Language Design]]
- [[CSE341/Definitions/Part4/Lexical Scope]]
- [[CSE341/Definitions/Part4/Dynamic Scope]]
- [[CSE341/Definitions/Part4/Closure]]
