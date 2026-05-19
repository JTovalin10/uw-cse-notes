# CSE 311: Rooted Binary Trees Functions

Functions defined recursively on [[CSE311/Part I - Mathematical Foundations/Data Structures/Rooted Binary Tree Definition|rooted binary trees]]. Each function has one equation for the basis (a single node) and one for the recursive step (a node with subtrees $T_1$ and $T_2$), mirroring the structure of the type definition.

## Size

The **size** counts the total number of nodes in the tree.

$$\text{size}(\bullet) := 1$$

$$\text{size}\!\left(\vcenter{\hbox{$\begin{array}{c} \bullet \\ /\quad\backslash \\ T_1\quad T_2 \end{array}$}}\right) := 1 + \text{size}(T_1) + \text{size}(T_2)$$

A single node contributes $1$; a compound tree counts its own root ($1$) plus the sizes of both subtrees.

## Height

The **height** is the length of the longest root-to-node path.

$$\text{height}(\bullet) := 0$$

$$\text{height}\!\left(\vcenter{\hbox{$\begin{array}{c} \bullet \\ /\quad\backslash \\ T_1\quad T_2 \end{array}$}}\right) := 1 + \max(\text{height}(T_1),\ \text{height}(T_2))$$

A single node has height $0$ (no edges below it); a compound tree adds $1$ edge to whichever subtree is taller.

## Related

- [[CSE311/Part I - Mathematical Foundations/Data Structures/Rooted Binary Tree Definition|Rooted Binary Tree Definition]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Structural Induction|Structural Induction]]
- [[CSE311/Part I - Mathematical Foundations/Data Structures/Inductive Data Types|Inductive Data Types]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Size | Node count |
| Height | Tree depth / height |
