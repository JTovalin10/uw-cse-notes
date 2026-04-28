# CSE 331 — Software Design and Implementation

Master navigation hub for CSE 331 notes. For a course overview and goals see the [[CSE331/README|README]].

---

## Part I — Software Specifications

### Software Specifications

- [[CSE331/Part I - Software Specifications/Software Specifications/Floyd Logic|Floyd Logic]] — formal reasoning about program state and correctness
- [[CSE331/Part I - Software Specifications/Software Specifications/Hoare Triples|Hoare Triples]] — {Precondition} Statement {Postcondition} notation
- [[CSE331/Part I - Software Specifications/Software Specifications/Kinds of Specifications|Kinds of Specifications]] — different specification approaches
- [[CSE331/Part I - Software Specifications/Software Specifications/Pre and Post Conditions|Pre and Post Conditions]] — contracts defining method behavior
- [[CSE331/Part I - Software Specifications/Software Specifications/Postcondition|Postcondition]] — expected program state after statement execution
- [[CSE331/Part I - Software Specifications/Software Specifications/Propositions|Propositions]] — logical statements that can be true or false
- [[CSE331/Part I - Software Specifications/Software Specifications/Stronger Assertions|Stronger Assertions]] — more restrictive preconditions or postconditions
- [[CSE331/Part I - Software Specifications/Software Specifications/Writing Methods Specs in Java|Writing Method Specs in Java]] — writing specs in Java

### Definitions

- [[CSE331/Part I - Software Specifications/Definitions/@effects|@effects]] — JavaDoc annotation describing method side effects
- [[CSE331/Part I - Software Specifications/Definitions/@modifies|@modifies]] — JavaDoc annotation listing modified mutable arguments
- [[CSE331/Part I - Software Specifications/Definitions/Exclusive and Exhaustive|Exclusive and Exhaustive]] — non-overlapping cases covering all possibilities
- [[CSE331/Part I - Software Specifications/Definitions/Facts|Facts]] — immutable values and objects in specifications
- [[CSE331/Part I - Software Specifications/Definitions/Restricting Domain|Restricting Domain]] — limiting input domain in specifications
- [[CSE331/Part I - Software Specifications/Definitions/Side Conditions|Side Conditions]] — conditions on inputs beyond @requires

---

## Part II — Software Engineering

### Software Engineering

- [[CSE331/Part II - Software Engineering/Software Engineering/The Need for Software Design|The Need for Software Design]] — why design precedes implementation
- [[CSE331/Part II - Software Engineering/Software Engineering/Software Implementation|Software Implementation]] — writing code from design
- [[CSE331/Part II - Software Engineering/Software Engineering/Abstract Data Type|Abstract Data Type]] — data type defined by behavior and specs
- [[CSE331/Part II - Software Engineering/Software Engineering/Types of Operations|Types of Operations]] — creators, producers, observers, mutators
- [[CSE331/Part II - Software Engineering/Software Engineering/Documenting an ADT Implementation|Documenting an ADT Implementation]] — explaining ADT representation
- [[CSE331/Part II - Software Engineering/Software Engineering/Representation Invariants|Representation Invariants]] — properties ensuring valid ADT state
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutation|Mutation]] — changing object or variable state
- [[CSE331/Part II - Software Engineering/Software Engineering/Local Variable Mutation|Local Variable Mutation]] — modifying local variable state
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutations of Arguments|Mutations of Arguments]] — modifying method arguments
- [[CSE331/Part II - Software Engineering/Software Engineering/Mutations in ADT|Mutations in ADT]] — handling mutation in abstract data types
- [[CSE331/Part II - Software Engineering/Software Engineering/Testing|Testing]] — verifying software correctness
- [[CSE331/Part II - Software Engineering/Software Engineering/Types of Tests|Types of Tests]] — unit, integration, and regression tests
- [[CSE331/Part II - Software Engineering/Software Engineering/Debugging|Debugging]] — identifying and fixing program errors

### Java Programming

- [[CSE331/Part II - Software Engineering/Java Programming/Conditionals|Conditionals]] — if-else control flow in Java
- [[CSE331/Part II - Software Engineering/Java Programming/Equality|Equality]] — overriding equals and hashCode
- [[CSE331/Part II - Software Engineering/Java Programming/Loops|Loops]] — loop control flow in Java
- [[CSE331/Part II - Software Engineering/Java Programming/Loop invariants with pictures|Loop invariants with pictures]] — visual array algorithms
- [[CSE331/Part II - Software Engineering/Java Programming/Array Reasoning|Array Reasoning]] — prefix, suffix, and for-any facts
- [[CSE331/Part II - Software Engineering/Java Programming/Loop to Tail Recursion|Loop to Tail Recursion]] — translating loops to recursive functions
- [[CSE331/Part II - Software Engineering/Java Programming/Subtypes|Subtypes]] — type inheritance and polymorphism
- [[CSE331/Part II - Software Engineering/Java Programming/Generics|Generics]] — generic type-safe classes and interfaces
- [[CSE331/Part II - Software Engineering/Java Programming/Generic Methods|Generic Methods]] — type-parameterized method definitions
- [[CSE331/Part II - Software Engineering/Java Programming/Wildcards|Wildcards]] — bounded/unbounded generic type wildcards
- [[CSE331/Part II - Software Engineering/Java Programming/Type Erasure and Arrays|Type Erasure and Arrays]] — generic type removal at runtime
- [[CSE331/Part II - Software Engineering/Java Programming/Pattern Matching|Pattern Matching]] — matching values against patterns in Java
- [[CSE331/Part II - Software Engineering/Java Programming/Visualizing Array Algorithms|Visualizing Array Algorithms]] — mental models for array processing

---

## Suggested Reading Order

**Specifications (Part I):**
Pre and Post Conditions → Postcondition → Propositions → Hoare Triples → Floyd Logic → Stronger Assertions → Kinds of Specifications → Writing Method Specs in Java.

**Software Engineering (Part II):**
The Need for Software Design → Software Implementation → Abstract Data Type → Types of Operations → Representation Invariants → Documenting an ADT Implementation → Mutation (→ Local Variable Mutation → Mutations of Arguments → Mutations in ADT) → Testing → Types of Tests → Debugging.

**Java Programming (Part II):**
Conditionals → Loops → Visualizing Array Algorithms → Subtypes → Generics → Generic Methods → Wildcards → Type Erasure and Arrays → Pattern Matching.
tching.
