# CSE 311: Context-Free Grammars

A **Context-Free Grammar (CFG)** is a set of substitution rules involving:
- A finite set $V$ of **variables** that can be replaced.
- An alphabet $\Sigma$ of **terminal symbols** that can't be replaced.
- One variable, usually $S$, designated as the **start symbol**.

The substitution rules (or productions) for a variable $A$ are written as:
$$A \to w_1 \mid w_2 \mid \cdots \mid w_k$$
where each $w_i$ is a string of variables and terminals, i.e., $w_i \in (V \cup \Sigma)^*$.

## How CFGs generate strings
- Begin with the start symbol $S$.
- If there is some variable $A$ in the current string, replace it by one of the $w_i$'s in the rules for $A$.
- Repeat until no variables are left.

The set of strings a CFG describes are all strings containing no variables that can be generated in this manner.

## Examples
**Binary Palindromes:**
$$S \to \varepsilon \mid 0 \mid 1 \mid 0S0 \mid 1S1$$

**Matched Parentheses:**
$$S \to (S) \mid SS \mid \varepsilon$$

**Equal number of 0s and 1s:**
$$S \to SS \mid 0S1 \mid 1S0 \mid \varepsilon$$

## CFGs vs Regular Expressions
Every language described by a Regular Expression has a CFG that recognizes it ($RE \subseteq CFG$). However, CFGs are strictly more powerful than REs. For example, binary palindromes and strings with equal numbers of 0s and 1s can be described by CFGs but cannot be described by any regular expression (they are not regular languages).

## Related
- [[Regular Expressions]]
- [[Strings]]
