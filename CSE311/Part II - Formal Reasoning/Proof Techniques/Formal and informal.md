# CSE 311: Formal vs. Informal Descriptions

A **formal** system is built on a precise set of rules for its **syntax** (how expressions are written) and **semantics** (what they mean). The goal is to eliminate all ambiguity so that a statement or expression can only be interpreted in one way. This is crucial for computers and mathematical proofs.

**Key Characteristics:**

- **Unambiguous**: Each statement has exactly one meaning.
- **Rule-Based**: Follows a strict grammar and logic.
- **Symbolic**: Often uses specialized symbols and notation.

**Examples:**

- The type definition `type Beat := {count : N, up : B}` is **formal**.
- The function pattern `dance({count: 0, up: T}) := 1` is **formal**. It is a piece of code that a machine or another computer scientist can parse and understand precisely.

---

## Informal Descriptions

An **informal** description uses natural language to explain what a formal system does or means. It prioritizes clarity and understanding for a human reader over machine-level precision. It often uses analogies and simplifies complex ideas.

**Key Characteristics:**

- **Intuitive**: Aims to build understanding and give a "feel" for the concept.
- **Uses Natural Language**: Written in English, Spanish, etc.
- **Can be Ambiguous**: May rely on context and shared understanding to make sense.

**Examples:**

- The explanation "**Exclusive** means the patterns don't overlap" is **informal**.
- Describing a pattern's purpose, such as "this line handles the case where the count is zero and up is true," is an **informal** explanation of the formal code.

## Related

- [[Formal Proofs]]
- [[Proof by Calculation]]