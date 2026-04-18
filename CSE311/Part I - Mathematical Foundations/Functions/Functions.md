# CSE 311: Functions

In many formal systems and programming languages, we distinguish between declaring what a function's type is and defining what it actually does.

## Defining a Function

A complete function definition has two parts: the **type signature** and the **implementation**.

### 1. Type Signature (The "What")

First, we declare the function's type. This specifies the type of input it accepts and the type of output it returns. The colon `:` is read as "has the type".

- **Syntax**: `function_name : (input_type) -> output_type`
- **Example**: A function named `double` that takes a Natural Number ($\mathbb{N}$) and returns a Natural Number.

$$\text{double} : \mathbb{N} \rightarrow \mathbb{N}$$

### 2. Implementation (The "How")

Next, we define how the output is calculated from the input. The `:=` symbol means "is defined as".

- **Syntax**: `function_name(input_name) := expression`
- **Example**: The implementation of `double` takes an input `n` and computes `2n`.

$$\text{double}(n) := 2n$$

Here, the left-hand side names the input `n`, and the right-hand side defines how to compute the output using `n`.

---

## Using Custom Types in Functions

We can define our own custom data types and use them in function signatures.

### 1. Defining a Custom Type

Define a `Point` type using a **record** with two fields, `x` and `y`, both Real Numbers ($\mathbb{R}$):

$$\text{type Point} := \{x : \mathbb{R},\ y : \mathbb{R}\}$$

### 2. Using the Type in a Function

Now use `Point` as a type. `shiftX` takes a `Point` and an amount and returns a new `Point` shifted horizontally:

- **Type Signature**:
$$\text{shiftX} : (\text{Point},\ \mathbb{R}) \rightarrow \text{Point}$$

- **Implementation**:
$$\text{shiftX}(p,\ \text{amount}) := \{x : x(p) + \text{amount},\ y : y(p)\}$$

This constructs a new `Point` where the `x` value is shifted by `amount` and `y` is unchanged.

## Related

- [[Data Types]]
- [[Compound Types]]
- [[Functions on Lists]]
- [[Functions on a Set of Strings]]
- [[Composition]]
