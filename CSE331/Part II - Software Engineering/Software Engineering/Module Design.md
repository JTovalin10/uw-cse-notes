# CSE331: Module Design

"Designing modules is the heart of software design." — Michael Ernst

In Java, a "module" is typically a file or a top-level class.

## Core Principles

Modules should have **high cohesion** and **low coupling**.

### Cohesion
**Cohesion** means the parts go together.
- They all serve one purpose or represent one concept.
- Primarily about the **specification**.
- Example: An ADT, `java.util.Arrays`.
- Non-example: One class for sorting, drawing, and printing.

### Coupling
**Coupling** means the parts are only understandable together.
- You must learn both to understand either.
- Primarily about the **implementation**.
- Example: An immutable ADT.
- Non-example: A mutable ADT that allows aliases (must understand how all aliases are used to know if it's correct).

## Why Coupling is Bad
- Makes code **less understandable** (spaghetti code, "god class").
- Makes code **hard to change** (all interrelated parts may require changes).
- Creates potential for **painful debugging** (bugs in one piece can cause failures in another).

## Related
- [[Subclasses]] (a common source of tight coupling)
- [[The Need for Software Design]]