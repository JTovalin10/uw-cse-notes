
#Definition Set: A collection of elements (objects)
$$
B= \set{{a,b,c,\set{d}}}
$$
$$
a \in B
$$
- Sets can be elements of other sets
	$$
	A=\set{\set{a,b}, \set{c,d}, \emptyset} \quad B = \set{a,b} \quad B \in A
	$$
- Common Sets
$$
\mathbb{N} = \set{0,1,2,...} \quad \text{Natural numbers}
$$
$$
\mathbb{Z} = \set{...,-2,-1,0,1,2,...} \quad \text{Integers}
$$
$$
\mathbb{Q} = \set{1/2, 1, p/q} \quad \text{rational numbers}
$$
$$
\mathbb{R} = \set{\mathbb{N}, \mathbb{Z}, \mathbb{Q}} \quad \text{Real Numbers}
$$
$$
[n] = \set{1,2,...,n} \quad n \in \mathbb{N}
$$
$$
\emptyset = \set{} \quad \text{Empty Set}
$$
#Definition Equality:
$$A = B \quad := \forall x(x \in A \leftrightarrow x \in B)$$
Another definition: 
$$
A = B \quad \equiv \quad A \subseteq B \quad \land \quad B \subseteq A
$$
#Definition Subset:
$$
A \subseteq B \quad := \forall x(x \in A \rightarrow x \in B)
$$
#Definition Power set: power set of set A is all subsets of A
$$
\mathcal{P}(A) \quad := \set{B : B \subseteq A}
$$
Example: 
$$
A = \set{1,2} \quad \mathcal{P}(A)= \set{\set{1}, \set{2}, \set{1,2}, \emptyset}
$$
#Definition Cartesian Product:
$$
A \times B := \set{(a,b) : a \in A, b \in B}
$$
$$
A \times B := \set{x: \exists a \exists b ((a \in A) \land (b \in B) \land (x = (a,b)))}
$$
Example: 
$$A = \set{1,2} \quad B= \set{a,b} \quad A \times B = \set{(1,a), (1,b), (2,a), (2,b)}$$
