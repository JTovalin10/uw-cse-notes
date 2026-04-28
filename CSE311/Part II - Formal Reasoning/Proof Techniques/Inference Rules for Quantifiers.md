# CSE 311: Inference Rules for Quantifiers

#Definition **Intro $\exists$**:
If we know $P(c)$ is true for some specific element $c$ in the domain, we can conclude $\exists x P(x)$.
$$
P(c) \text{ for some } c \quad \Rightarrow \quad \exists x P(x)
$$

#Definition **Elim $\exists$**:
If we know $\exists x P(x)$ is true, we can give a *new* name $c$ to an element where $P(c)$ is true.
$$
\exists x P(x) \quad \Rightarrow \quad P(c) \text{ for some special } c
$$
*(Note: $c$ must be a new variable name not used anywhere else in the proof).*

#Definition **Elim $\forall$**:
If we know $\forall x P(x)$ is true, we can conclude $P(a)$ is true for *any* specific element $a$ in the domain.
$$
\forall x P(x) \quad \Rightarrow \quad P(a) \text{ for any } a
$$

#Definition **Intro $\forall$**:
If we assume $a$ is an arbitrary element in the domain and can prove $P(a)$ is true, we can conclude $\forall x P(x)$.
$$
\text{"Let } a \text{ be arbitrary" ... } P(a) \quad \Rightarrow \quad \forall x P(x)
$$

## Related

- [[Formal Proofs]]
- [[What are Quantifiers]]
- [[Scope of Quantifiers]]
