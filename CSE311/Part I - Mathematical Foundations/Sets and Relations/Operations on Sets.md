# CSE 311: Set Operations

Set operations can be translated into propositional logic, allowing us to reason about them with the same tools as logical equivalences.

$$A \cup B \quad := \{x : (x \in A) \lor (x \in B)\} \quad \text{Union}$$
$$A \cap B \quad := \{x : (x \in A) \land (x \in B)\} \quad \text{Intersection}$$
$$A \setminus B \quad := \{x : (x \in A) \land (x \notin B)\} \quad \text{Set Difference}$$
$$A \oplus B \quad := \{x : (x \in A) \oplus (x \in B)\} \quad \text{Symmetric Difference}$$
$$A^c \quad := \{x : (x \in U) \land (x \notin A)\} \quad \text{Complement (where } U \text{ is the universal set)}$$

## Laws of Set Operations

**De Morgan's Laws:**
- $\overline{A \cup B} = \overline{A} \cap \overline{B}$
- $\overline{A \cap B} = \overline{A} \cup \overline{B}$

**Distributive Laws:**
- $A \cap (B \cup C) = (A \cap B) \cup (A \cap C)$
- $A \cup (B \cap C) = (A \cup B) \cap (A \cup C)$

## Related

- [[What is a Set]]
- [[Logical Equivalence(s)]]
- [[DeMorgans Laws]]
- [[Sets and Logic]]
