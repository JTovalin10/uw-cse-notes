# CSE341: Structs and Pattern Matching

In Trefoil, **[[CSE341/Definitions/Part5/Struct|Structs]]** provide a way to define custom data types. A struct definition automatically generates a constructor, a type-checking predicate, and field accessors.

## Implementation by Desugaring

One powerful way to implement structs is through **[[CSE341/Definitions/Part5/Desugaring|Desugaring]]**. Instead of adding a new primitive type to the core interpreter, we can translate struct definitions into existing language features like pairs (cons cells) and symbols.

### Formal Definition of Struct Desugaring
Given a struct definition:
`(struct foo field1 field2 ... fieldN)`

It can be desugared into:
1. **Constructor**: A function `foo` that takes $N$ arguments and returns a tagged list.
2. **Predicate**: A function `foo?` that checks if its argument is a list starting with the symbol `'foo`.
3. **Accessors**: Functions `foo-field1`, `foo-field2`, etc., that extract the corresponding elements from the tagged list.

### Concrete Walkthrough: Single-Field Struct
Consider a struct for integers:
`(struct int n)`

This behaves as if the user had typed:
```racket
(define (int x) (cons 'int x))
(define (int? x) (if (pair? x) (= (car x) 'int) false))
(define (int-n x) (cdr x))
```

### Simplified Explanation
Structs are just fancy wrappers around pairs. The first element of the pair is a "tag" (a symbol like `'foo`) that tells the interpreter what kind of data it's looking at.

---

## Pattern Matching

**Pattern Matching** provides a concise way to branch based on the structure of data. In Trefoil, the `match` expression allows deconstructing structs.

### Mechanism
A `match` expression evaluates an expression and compares the resulting value against several patterns. When a match is found, the variables in the pattern are bound to the corresponding fields of the struct, and the branch body is executed.

### Example: Evaluator using Match
Using `struct` and `match` significantly simplifies writing an interpreter for a language with multiple expression types.

```racket
(struct int n)
(struct add e1 e2)
(struct mul e1 e2)

(define (interp e)
  (match e
    ((int i) i)
    ((add e1 e2) (+ (interp e1) (interp e2)))
    ((mul e1 e2) (* (interp e1) (interp e2)))))
```

### Physical Implementation Details
In the interpreter's `match` implementation:
1. Evaluate the expression to be matched.
2. For each pattern `(struct-name fields...)`:
   - Check if the value's tag matches `struct-name`.
   - Verify the number of fields matches the struct definition.
   - Bind each field value to the corresponding variable name in a new **[[CSE341/Definitions/Part5/Dynamic Environment|Dynamic Environment]]**.
   - Evaluate the branch body in this extended environment.

---

## Related
- [[CSE341/Trefoil Advanced/First-Class Functions|First-Class Functions]]
- [[CSE341/Definitions/Part5/Desugaring|Desugaring]]
- [[CSE341/Definitions/Part5/Struct|Struct]]
