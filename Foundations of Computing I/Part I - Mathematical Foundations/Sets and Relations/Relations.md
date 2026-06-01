# CSE 311: Relations

A **relation** $R$ on a [[What is a Set|set]] $A$ is itself a set of ordered pairs $(a, b)$ where $a, b \in A$, i.e., $R \subseteq A \times A$ — a subset of the Cartesian product. Each property below is stated as a formal logical sentence using [[What are Quantifiers|quantifiers]].

## Properties of Relations

#Definition **Relation Composition**: Let $R$ be a relation on a set $A$.
$$R \circ R = \{(a,b) \mid \exists c\, ((a,c) \in R \land (c,b) \in R)\}$$

#Definition **Transitive**: $R$ is transitive if
$$\forall a \in A,\ \forall b \in A,\ \forall c \in A\, (((a,b) \in R \land (b,c) \in R) \rightarrow (a,c) \in R)$$

#Definition **Antisymmetric**: $R$ is antisymmetric if
$$\forall a \in A,\ \forall b \in A\, (((a,b) \in R \land (b,a) \in R) \rightarrow a = b)$$

#Definition **Symmetric**: $R$ is symmetric if
$$\forall a \in A,\ \forall b \in A\, ((a,b) \in R \rightarrow (b,a) \in R)$$

#Definition **Reflexive**: $R$ is reflexive if
$$\forall a \in A\, ((a,a) \in R)$$

## Related

- [[What is a Set|What is a Set]]
- [[Foundations of Computing I/Part I - Mathematical Foundations/Functions/Functions|Functions]]
- [[What are Quantifiers|What are Quantifiers]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Relation | Binary relation |
| Relation composition ($R \circ R$) | Relational join / transitive step |
| Reflexive + symmetric + transitive | Equivalence relation |
| Reflexive + antisymmetric + transitive | Partial order |
