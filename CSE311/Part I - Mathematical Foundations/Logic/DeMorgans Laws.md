# CSE 311: De Morgan's Laws

## Propositional Logic

$$\neg (p \land q) \quad \equiv \quad \neg p \lor \neg q$$
$$\neg (p \lor q) \quad \equiv \quad \neg p \land \neg q$$

## Quantifiers

$$\neg \forall x P(x) \quad \equiv \quad \exists x \neg P(x)$$
$$\neg \exists x P(x) \quad \equiv \quad \forall x \neg P(x)$$

### With Domain Restriction

De Morgan's Laws respect domain restrictions by leaving them in place and only negating the other parts:
$$\neg \exists x (P(x) \land R(x)) \quad \equiv \quad \forall x (P(x) \rightarrow \neg R(x))$$
$$\neg \forall x (P(x) \rightarrow R(x)) \quad \equiv \quad \exists x (P(x) \land \neg R(x))$$

## Related

- [[Logical Equivalence(s)]]
- [[What are Quantifiers]]
- [[Boolean Algebra]]
