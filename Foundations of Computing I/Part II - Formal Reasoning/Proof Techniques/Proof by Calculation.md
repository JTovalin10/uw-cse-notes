# CSE 311: Proof by Calculation

**Proof by calculation** is a [[Formal Proofs|proof]] technique used to prove an implication where the fact to be shown is an equation or inequality. It works by chaining together known facts and definitions in a sequence of justified steps until the desired result is reached.

- Proves an implication whose conclusion is an equation or inequality.
- Uses known facts and definitions as justification at each step.
  - For example, the defining equation `len(nil) = 0` from [[Functions on Lists|Functions on Lists]] can be used as a definition step.

Each step is annotated with the fact that justifies it, so the whole chain reads as a verifiable derivation. This style of step-by-step justified rewriting is the same one used inside the [[Induction|induction]] step when simplifying $P(k+1)$.

## Related

- [[Formal Proofs|Formal Proofs]]
- [[Induction|Induction]]
- [[Functions on Lists|Functions on Lists]]
- [[Functions on a Set of Strings|Functions on a Set of Strings]]
- [[Foundations of Computing I/Definitions/Proof by Calculation|Proof by Calculation (glossary)]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Proof by calculation | Calculational proof / equational reasoning |
| Justification step | Rewrite step / lemma citation |