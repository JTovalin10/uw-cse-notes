# CSE 311: Regular Expressions

#Definition A **regular expression** over an [[Strings|alphabet]] $\Sigma$ is defined recursively, following the basis-plus-recursive-step pattern of a [[Recursive Definition of Sets|recursive definition]]:

- **Basis**
	- $\varepsilon$ is a regular expression
	- $a$ is a regular expression for any $a \in \Sigma$
- **Recursive Step**
	- If $A$ and $B$ are regular expressions, then so are:
		- $A \cup B$ (union / alternation)
		- $AB$ (concatenation)
		- $A^*$ (Kleene star)

## What Each Pattern Matches

- $\varepsilon$ matches only the empty string
- $a$ matches only the one-character string $a$
- $L(\varepsilon) = \{\varepsilon\}$
- $L(A^*) = \bigcup_{n=0}^{\infty} L(A^n)$

Where $A^n$ is defined recursively:
- $A^0 = \{\varepsilon\}$
- $A^{n+1} = A^n A$

## $x^*$ Examples

- $001^*$
	- $\{00,\ 001,\ 0011,\ 00111,\ \ldots\}$
- $0^*1^*$
	- Any number of $0$'s followed by any number of $1$'s

The set of strings a regular expression matches is its [[Set of Strings|language]] (a subset of $\Sigma^*$). Every language describable by a regular expression is exactly the class of **regular languages** — the same languages recognized by a [[Deterministic Finite Automata|DFA]] or [[Nondeterministic Finite Automata|NFA]]. The strictly more powerful [[Context-Free Grammars|context-free grammars]] can describe languages no regular expression can.

## Related

- [[Strings|Strings]]
- [[Set of Strings|Set of Strings]]
- [[Recursive Definition of Sets|Recursive Definition of Sets]]
- [[Deterministic Finite Automata|Deterministic Finite Automata]]
- [[Nondeterministic Finite Automata|Nondeterministic Finite Automata]]
- [[Context-Free Grammars|Context-Free Grammars]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Regular expression | Regex |
| Union / alternation ($\cup$) | `|` in regex syntax |
| Kleene star ($A^*$) | `*` quantifier |
| Regular language | Regular language / Type-3 language |