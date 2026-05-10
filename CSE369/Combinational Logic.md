# Course: Combinational Logic

Combinational logic is a type of digital logic where the output is a pure function of the present inputs only. There is no memory or internal state.

## Core Concepts

### Logic Gates
**Logic Gates** are the basic building blocks of digital circuits. They perform Boolean operations on one or more binary inputs to produce a single binary output. They are idealized models of computation or physical electronic devices implementing a Boolean function.

- **AND**: Output is high only if all inputs are high.
- **OR**: Output is high if at least one input is high.
- **NOT**: Inverts the input.
- **NAND/NOR**: Universal gates that can implement any Boolean function.
- **XOR**: Output is high if the number of high inputs is odd.

### Boolean Algebra
Logic circuits can be represented mathematically using Boolean algebra.
- **Sum-of-Products (SOP)**: A logic expression consisting of ORed terms, where each term is an ANDed group of variables (e.g., $F = AB + CD$).
- **Product-of-Sums (POS)**: A logic expression consisting of ANDed terms, where each term is an ORed group of variables (e.g., $F = (A+B)(C+D)$).

## Implementation

### Formal Definition
A combinational circuit is defined by its **Truth Table**, which is a mathematical table used in logic which sets out the functional values of logical expressions on each of their functional arguments—that is, for each combination of values taken by their logical variables. For $n$ inputs, there are $2^n$ rows.

### Simplified Explanation
The output changes immediately (ignoring propagation delay) based on what you feed into the inputs right now.

## Related
- [[CSE369/Karnaugh Maps|Karnaugh Maps]]
- [[CSE369/Building Blocks|Building Blocks]]
- [[CSE351/Number Representation|Number Representation]]
