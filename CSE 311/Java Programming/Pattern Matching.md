
Pattern matching is a powerful way to define a function by specifying different rules for different kinds of input. Instead of a single expression for all inputs, you can **destructure** the input data and provide a specific implementation for each **case** or "pattern".

## Core Principles
For a function definition using pattern matching to be valid, its rules must be:
* **Exclusive:** Any given input can match **only one** pattern.
* **Exhaustive:** **Every possible** input must match one of the patterns.

This ensures that the function has a clear, unambiguous output for all possible inputs.

***

## Examples of Pattern Matching

### 1. Matching on Records
You can match on the structure of a record to bind its field values to variables.

* **Example:** A `dist` function on a `Point` type, where `Point := {x: R, y: R}`.
    The pattern `{x: x, y: y}` destructures the input point, naming its components `x` and `y` for use in the function body.
    $$
    \text{dist}(\{x: x, y: y\}) := (x^2 + y^2)^{1/2}
    $$

### 2. Matching on Enums (Constructors)
You can define a function by providing a rule for each constructor of an enum type.

* **Example:** A `not` function on the Boolean type $\mathbb{B} := \text{T} \mid \text{F}$.
    There is one rule for the `T` input and one for the `F` input. Together, they are exhaustive and exclusive.
    $$
    \text{not}(\text{T}) := \text{F}
    $$   $$
    \text{not}(\text{F}) := \text{T}
    $$

### 3. Matching on Inductive Types (Recursion)
Pattern matching is the natural way to define recursive functions on inductive types like the Natural Numbers ($\mathbb{N}$).

* **Example:** Defining `double` without using multiplication.
    The patterns cover the **base case** (`0`) and the **inductive step** (`n+1`), making the definition exhaustive for all natural numbers.
    $$
    \text{double}(0) := 0
    $$   $$
    \text{double}(n + 1) := \text{double}(n) + 2
    $$

### 4. Nested Matching (Matching on Partial Data)
You don't have to match the whole value; you can match on specific values *inside* a structure.

* **Example:** A function `f` that operates on a `Dir` type, where `type Dir := {x: R, b: B}`.
    The function's behavior depends only on the boolean field `b`. The pattern matches a `Dir` record but also specifies the required value for `b`, while binding `x` to a variable.
    $$
    f : (\text{Dir}) \rightarrow \mathbb{R}
    $$   $$
    f(\{x: x, b: \text{T}\}) := x
    $$   $$
    f(\{x: x, b: \text{F}\}) := -x
    $$

***

## Pattern Matching and Type Inference
A key feature is that you generally do not need to declare the types of variables used within a pattern.

As long as the function's overall type signature is declared (e.g., `f : (Dir) -> R`), the system can **infer** the types of any variables in the patterns. In the example above, we don't need to say `x` has type $\mathbb{R}$; this is known because the input to `f` must be of type `Dir`.

*** 

[[Functions]]