# CSE 331 - Software Design and Implementation

## Course Overview

> *Explores concepts and techniques for design and construction of reliable and maintainable software systems in modern high-level languages: specifications; program structure and design; program-correctness approaches, including testing; and event-driven programming.*

CSE 331 bridges formal reasoning with practical software engineering, teaching you how to write software that is correct, understandable, and easy to maintain.

**Key Goals:**
- Write precise specifications that define expected program behavior
- Use formal reasoning (Hoare Triples, Floyd Logic) to verify correctness
- Design and implement Abstract Data Types (ADTs)
- Apply abstraction principles to manage complexity
- Build and test reliable software in Java

---

## Topics Covered

### Part I - Software Specifications

#### Software Specifications
Formal tools for describing what code should do, independent of how it does it.
- Pre and postconditions
- Hoare Triples `{P} S {Q}`
- Floyd Logic and program state reasoning
- Stronger vs. weaker assertions
- Kinds of specifications
- Writing method specs in Java (`@requires`, `@effects`, `@modifies`)

#### Definitions
Key concepts and annotation conventions used throughout the course.
- `@effects` and `@modifies` annotations
- Side conditions
- Restricting domains
- Exclusive and exhaustive case analysis

---

### Part II - Software Engineering

#### Software Engineering
Principles and techniques for building well-structured, maintainable software.
- The need for software design
- Abstract Data Types (ADTs) and types of operations
- Representation invariants
- Documenting ADT implementations
- Mutation: local variables, arguments, and ADTs
- Testing strategies and types of tests
- Debugging

#### Java Programming
Practical Java features used to implement software engineering concepts.
- Pattern matching
- Conditionals and loops
- Subtypes and inheritance
- Generics and generic methods
- Wildcards
- Type erasure and arrays
- Visualizing array algorithms

---

## Folder Structure

```
CSE331/
├── Part I - Software Specifications/
│   ├── Definitions/
│   └── Software Specifications/
└── Part II - Software Engineering/
    ├── Java Programming/
    └── Software Engineering/
```

---

## Key Takeaways

1. **Specifications are contracts**: A good spec precisely defines behavior without over-constraining the implementation
2. **Abstraction manages complexity**: ADTs separate what a type does from how it does it
3. **Formal reasoning catches bugs**: Hoare Triples let you prove code is correct before running it
4. **Design for change**: Representation invariants and clean abstractions make software easier to modify and test
