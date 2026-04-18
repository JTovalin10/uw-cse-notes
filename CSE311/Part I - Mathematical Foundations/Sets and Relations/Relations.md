# CSE 311: Relations

A **relation** $R$ on a set $A$ is a set of ordered pairs $(a, b)$ where $a, b \in A$, i.e., $R \subseteq A \times A$.

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

- [[What is a Set]]
- [[Functions]]
