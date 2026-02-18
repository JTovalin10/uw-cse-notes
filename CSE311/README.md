# CSE 331 - Software Design and Implementation

## Course Overview

> *Explores concepts and techniques for design and construction of reliable and maintainable software systems in modern high-level languages: specifications; program structure and design; program-correctness approaches, including testing; and event-driven programming (e.g., graphical user interface).*

CSE 331 bridges mathematical foundations with practical software engineering, teaching you how to reason about program correctness and build robust, maintainable systems.

**Key Goals:**
- Write software that is correct, easy to test, understand, and change
- Use formal reasoning to verify program behavior
- Apply abstraction principles to manage complexity
- Design and implement Abstract Data Types (ADTs)
- Build event-driven applications with graphical user interfaces

---

## Topics Covered

### Logic & Boolean Algebra
Foundational propositional logic used throughout the course for reasoning about program behavior.
- Truth tables and logical equivalences
- DeMorgan's Laws
- Tautologies and normal forms (CNF/DNF)
- Digital circuit connections

### Predicates and Quantifiers
Extending propositional logic to reason about collections of objects.
- Predicate definitions and usage
- Universal (∀) and existential (∃) quantifiers
- Scope rules and nested quantifiers
- Translating English to formal logic

### Sets and Relations
Mathematical structures for modeling data and relationships.
- Set operations (union, intersection, complement)
- Relations and their properties
- Recursive set definitions
- Connections between sets and logic

### Proof Techniques
Formal methods for establishing correctness.
- Mathematical induction (base case, inductive step)
- Strong induction
- Structural induction (for recursive data types)
- Proof by calculation

### Number Theory
Discrete math concepts relevant to computing.
- Modular arithmetic
- Extended Euclidean algorithm
- n-bit integer representation

### Data Structures
Formal definitions of common structures.
- Inductive data types
- Lists and list operations
- Rooted binary trees
- Compound types

### Functions
Mapping and transformation concepts.
- Function definitions and properties
- Functions on lists and strings
- Abstract functions (connecting implementation to specification)
- Function composition

### Automata and Languages
Formal language theory basics.
- Strings and string operations
- Sets of strings
- Regular expressions

---

## Software Engineering

### Design Principles
- **Abstraction**: Hiding implementation details behind clean interfaces
- **Abstraction Barrier**: Separating implementer responsibilities from client expectations
- **Specifications**: Precise descriptions of expected behavior

### Abstract Data Types (ADTs)
- Concrete state vs. abstract state
- Representation invariants
- Documenting ADT implementations
- Types of operations (creators, observers, mutators)

### Program Correctness
- **Hoare Triples**: `{P} S {Q}` - precondition, code, postcondition
- **Floyd Logic**: Reasoning about program states
- Forward and backward reasoning
- Weakest preconditions and strongest postconditions

### Testing & Debugging
- Types of tests (unit, integration, etc.)
- Testing strategies
- Debugging techniques
- Mutation testing

### Mutation & Side Effects
- Local variable mutation
- Mutations of arguments
- Mutations in ADT implementations
- The `@modifies` and `@effects` annotations

---

## Java Programming

Practical implementation of the theoretical concepts.
- Pattern matching
- Conditionals and loops (with correctness reasoning)
- Subtypes and inheritance
- Generics and generic methods
- Wildcards
- Type erasure and arrays

---

## Folder Structure

```
CSE 331/
├── Automata and Languages/
├── Data Structures/
├── Definitions/
├── Functions/
├── Java Programming/
├── Logic/
├── Number Theory/
├── Predicates and Quantifiers/
├── Proof Techniques/
├── Screenshots/
├── Sets and Relations/
├── Software Engineering/
└── Software Specifications/
```

---

## Key Takeaways

1. **Specifications matter**: Good specs are precise and distinguish essential from incidental details
2. **Abstraction is fundamental**: It enables managing complexity in large systems
3. **Formal reasoning works**: Induction and Hoare logic provide tools to prove correctness
4. **Design for change**: Code should be easy to understand, test, and modify
