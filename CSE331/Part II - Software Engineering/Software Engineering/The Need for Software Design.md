# CSE331: The Need for Software Design

Large-scale software must be correct **and**:

- easy to **test**
- easy to **understand**
- easy to **change**

Without explicit design, these qualities degrade as the codebase grows. Design is what keeps correctness achievable over time.

# Abstraction

An **abstraction** hides details in part of the code — a high-level description that avoids low-level detail.

## Procedural Abstraction

Procedural abstraction is provided for a method via its **specification**:

- Must describe the input/output behavior.
- Need not describe every detail of *how* it works.

## Abstraction Barrier

- The **implementer** promises their code satisfies the specification.
- The **client** promises not to depend on hidden details.

This two-sided contract is what lets both sides change independently.

# Specification

A good specification is **precise**:

- There can be no confusion about the required behavior.
- A vague spec turns into de-facto bug reports every time the implementation changes.

See [[CSE331/Part I - Software Specifications/Software Specifications/Kinds of Specifications|Kinds of Specifications]].

# AI and Abstraction

- At present, AI does not respect the abstraction barrier — it will happily reach past the spec into implementation details.
  - It should be possible to fix this in the future.
- Writing specs is **necessary**:
  - You must distinguish details that are **incidental** vs **essential**.
  - AI cannot read your mind.

## Related

- [[Abstract Data Type]]
- [[Software Implementation]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Kinds of Specifications|Kinds of Specifications]]
- [[CSE331/Part I - Software Specifications/Software Specifications/Pre and Post Conditions|Pre and Post Conditions]]
- [[Documenting an ADT Implementation]]
