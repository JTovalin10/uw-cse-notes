# CSE 331 — Software Design and Implementation

Master navigation hub for CSE 331 notes. For a course overview and goals see the [[Software Design and Implementation/README|README]].

---

## Part I — Software Specifications

### Software Specifications

- [[Floyd Logic|Floyd Logic]] — formal reasoning about program state and correctness
- [[Hoare Triples|Hoare Triples]] — {Precondition} Statement {Postcondition} notation
- [[Kinds of Specifications|Kinds of Specifications]] — different specification approaches
- [[Pre and Post Conditions|Pre and Post Conditions]] — contracts defining method behavior
- [[Postcondition|Postcondition]] — expected program state after statement execution
- [[Propositions|Propositions]] — logical statements that can be true or false
- [[Stronger Assertions|Stronger Assertions]] — more restrictive preconditions or postconditions
- [[Software Design and Implementation/Part I - Software Specifications/Software Specifications/Writing Methods Specs in Java|Writing Method Specs in Java]] — writing specs in Java

### Definitions

- [[@effects|@effects]] — JavaDoc annotation describing method side effects
- [[@modifies|@modifies]] — JavaDoc annotation listing modified mutable arguments
- [[Exclusive and Exhaustive|Exclusive and Exhaustive]] — non-overlapping cases covering all possibilities
- [[Facts|Facts]] — immutable values and objects in specifications
- [[Restricting Domain|Restricting Domain]] — limiting input domain in specifications
- [[Side Conditions|Side Conditions]] — conditions on inputs beyond @requires

---

## Part II — Software Engineering

### Software Engineering

- [[The Need for Software Design|The Need for Software Design]] — why design precedes implementation
- [[Software Implementation|Software Implementation]] — writing code from design
- [[Abstract Data Type|Abstract Data Type]] — data type defined by behavior and specs
- [[Types of Operations|Types of Operations]] — creators, producers, observers, mutators
- [[Documenting an ADT Implementation|Documenting an ADT Implementation]] — explaining ADT representation
- [[Representation Invariants|Representation Invariants]] — properties ensuring valid ADT state
- [[Abstract Function|Abstract Function]] — maps concrete field values to the abstract value
- [[Mutation|Mutation]] — changing object or variable state
- [[Local Variable Mutation|Local Variable Mutation]] — modifying local variable state
- [[Mutations of Arguments|Mutations of Arguments]] — modifying method arguments
- [[Mutations in ADT|Mutations in ADT]] — handling mutation in abstract data types
- [[Testing|Testing]] — verifying software correctness
- [[Types of Tests|Types of Tests]] — unit, integration, and regression tests
- [[Debugging|Debugging]] — identifying and fixing program errors

### Java Programming

- [[Software Design and Implementation/Part II - Software Engineering/Java Programming/Conditionals|Conditionals]] — if-else control flow in Java
- [[Equality|Equality]] — overriding equals and hashCode
- [[Software Design and Implementation/Part II - Software Engineering/Java Programming/Loops|Loops]] — loop control flow in Java
- [[Loop invariants with pictures|Loop invariants with pictures]] — visual array algorithms
- [[Array Reasoning|Array Reasoning]] — prefix, suffix, and for-any facts
- [[Loop to Tail Recursion|Loop to Tail Recursion]] — translating loops to recursive functions
- [[Subtypes|Subtypes]] — type inheritance and polymorphism
- [[Composition|Composition]] — "has-a" class containment as an alternative to inheritance
- [[Generics|Generics]] — generic type-safe classes and interfaces
- [[Generic Methods|Generic Methods]] — type-parameterized method definitions
- [[Wildcards|Wildcards]] — bounded/unbounded generic type wildcards
- [[Type Erasure and Arrays|Type Erasure and Arrays]] — generic type removal at runtime
- [[Software Design and Implementation/Part II - Software Engineering/Java Programming/Pattern Matching|Pattern Matching]] — matching values against patterns in Java
- [[Visualizing Array Algorithms|Visualizing Array Algorithms]] — mental models for array processing

---

## Suggested Reading Order

**Specifications (Part I):**
Pre and Post Conditions → Postcondition → Propositions → Hoare Triples → Floyd Logic → Stronger Assertions → Kinds of Specifications → Writing Method Specs in Java.

**Software Engineering (Part II):**
The Need for Software Design → Software Implementation → Abstract Data Type → Types of Operations → Representation Invariants → Documenting an ADT Implementation → Mutation (→ Local Variable Mutation → Mutations of Arguments → Mutations in ADT) → Testing → Types of Tests → Debugging.

**Java Programming (Part II):**
Conditionals → Loops → Visualizing Array Algorithms → Subtypes → Generics → Generic Methods → Wildcards → Type Erasure and Arrays → Pattern Matching.
tching.
