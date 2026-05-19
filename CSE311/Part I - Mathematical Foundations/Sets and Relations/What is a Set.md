# CSE 311: Sets

#Definition A **set** is a collection of elements (objects).
$$B = \{a, b, c, \{d\}\}$$
$$a \in B$$
- Sets can be elements of other sets:
$$A = \{\{a,b\},\ \{c,d\},\ \emptyset\} \quad B = \{a,b\} \quad B \in A$$

## Common Sets

$$\mathbb{N} = \{0,1,2,\ldots\} \quad \text{Natural numbers}$$
$$\mathbb{Z} = \{\ldots,-2,-1,0,1,2,\ldots\} \quad \text{Integers}$$
$$\mathbb{Q} = \{1/2, 1, p/q\} \quad \text{Rational numbers}$$
$$\mathbb{R} \quad \text{Real numbers (includes } \mathbb{N}, \mathbb{Z}, \mathbb{Q}\text{)}$$
$$[n] = \{1,2,\ldots,n\} \quad n \in \mathbb{N}$$
$$\emptyset = \{\} \quad \text{Empty set}$$

## Key Definitions

Each definition below is stated formally with [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What are Quantifiers|quantifiers]]; see [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Sets and Logic|Sets and Logic]] for why logical and set reasoning coincide.

#Definition **Equality**:
$$A = B \quad := \forall x(x \in A \leftrightarrow x \in B)$$
Another equivalent definition:
$$A = B \quad \equiv \quad A \subseteq B \quad \land \quad B \subseteq A$$

#Definition **Subset**:
$$A \subseteq B \quad := \forall x(x \in A \rightarrow x \in B)$$

#Definition **Power set**: the power set of set $A$ is the set of all subsets of $A$.
$$\mathcal{P}(A) \quad := \{B : B \subseteq A\}$$
Example:
$$A = \{1,2\} \quad \mathcal{P}(A) = \{\{1\},\ \{2\},\ \{1,2\},\ \emptyset\}$$

#Definition **Cartesian Product**:
$$A \times B := \{(a,b) : a \in A,\ b \in B\}$$
$$A \times B := \{x : \exists a\, \exists b\, ((a \in A) \land (b \in B) \land (x = (a,b)))\}$$
Example:
$$A = \{1,2\} \quad B = \{a,b\} \quad A \times B = \{(1,a),\ (1,b),\ (2,a),\ (2,b)\}$$

## Related

- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Operations on Sets|Operations on Sets]]
- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Sets and Logic|Sets and Logic]]
- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Recursive Definition of Sets|Recursive Definition of Sets]]
- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What is a Predicate|What is a Predicate]]
- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Relations|Relations]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Set | Set / `Set` collection |
| Subset ($\subseteq$) | `issubset()` |
| Power set ($\mathcal{P}(A)$) | Set of all subsets |
| Cartesian product ($A \times B$) | Cross product / `itertools.product` |
