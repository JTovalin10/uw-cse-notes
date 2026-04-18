# CSE 311: Rooted Binary Tree Functions

Functions defined recursively on [[Rooted Binary Tree Definition|rooted binary trees]].

## Size

$$\text{size}(\bullet) := 1$$

$$\text{size}\!\left(\vcenter{\hbox{$\begin{array}{c} \bullet \\ /\quad\backslash \\ T_1\quad T_2 \end{array}$}}\right) := 1 + \text{size}(T_1) + \text{size}(T_2)$$

## Height

$$\text{height}(\bullet) := 0$$

$$\text{height}\!\left(\vcenter{\hbox{$\begin{array}{c} \bullet \\ /\quad\backslash \\ T_1\quad T_2 \end{array}$}}\right) := 1 + \max(\text{height}(T_1),\ \text{height}(T_2))$$

## Related

- [[Rooted Binary Tree Definition]]
- [[Structural Induction]]
- [[Inductive Data Types]]
