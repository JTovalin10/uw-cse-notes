in many formal systems and programming languages, we distinguish between declaring what a function's type is and defining what it actually does.

## Defining a Function

A complete function definition has two parts: the type signature and the implementation.

### 1. Type Signature (The "What")

First, we declare the function's type. This specifies the type of input it accepts and the type of output it returns. The colon `:` is read as "has the type".

- **Syntax**: `function_name : (input_type) -> output_type`
    
- **Example**: A function named `double` that takes a Natural Number (N) and returns a Natural Number.
    
    double:(N)→N
    

###  2. Implementation (The "How")

Next, we define how the output is calculated from the input. The `:=` symbol means "is defined as".

- **Syntax**: `function_name(input_name) := expression`
    
- **Example**: The implementation of `double` takes an input `n` and computes the output `2n`.
    
    double(n):=2n
    
    Here, the left-hand side gives the name `n` to the input, and the right-hand side explains how to calculate the output using `n`.
    

---

## Using Custom Types in Functions

We can first define our own custom data types and then use them as inputs or outputs in our function signatures.

###  1. Defining a Custom Type

Let's define a `Point` type using a **record**. It will contain two fields, `x` and `y`, which are both Real Numbers (R).

type Point:={x:R,y:R}

### ### 2. Using the Type in a Function

Now that `Point` is defined, we can use it as a type in a new function. Let's create a function `shift_x` that takes a `Point` and a number (`amount`) and returns a new `Point` shifted horizontally.

- **Type Signature**:
    
    $$ 
    \text{shiftX} : (\text{Point}, \mathbb{R})\rightarrow \text{Point}
    $$
- **Implementation**:
    
    $$ 
  shiftX(p,amount):={x:x(p)+amount,y:y(p)}
    $$
    
    This definition takes a point `p` and a number `amount`. It constructs a **new** `Point` record where the new `x` value is the original point's x-value (`p.x`) plus the amount, and the `y` value remains the same.