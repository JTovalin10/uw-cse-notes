#Definition Relation Composition
Let R be a relation on a set A
$$R \circ R = \set{(a,b) \mid \exists c ((a,c) \in R \land (c,b) \in R))}$$
#Definition Transitive
$$\forall a \in A, \forall b \in A, \forall c \in A (((a,b) \in R \land (b,c) \in R) \rightarrow (a,c) \in R)$$
#Definition antisymmetric
$$\forall a \in A, \forall b \in A (((a,b( \in R \land (b,a) \in R) \rightarrow a=b$$
#Definition symmetric
$$\forall a \in A, \forall b \in A ((a,b) \in R \rightarrow (b,a) \in R)$$
#Definition Reflexive
$$\forall a \in A ((a,a) \in R)$$