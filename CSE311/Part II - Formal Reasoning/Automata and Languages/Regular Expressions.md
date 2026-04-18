# CSE 311: Regular Expressions

#Definition A **regular expression** over $\Sigma$ is defined recursively:

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

## Related

[[Strings]] · [[Set of Strings]] · [[Recursive Definition of Sets]]