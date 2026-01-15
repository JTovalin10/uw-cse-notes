**Regular Expressions over** $\Sigma$
- Basis
	- $\varepsilon$  is a regular expression
	- $a$ is a regular expression for any $a \in \Sigma$
- Recursive Step
	- If **A** and **B** are regular expressions, then so are 
		- $A \cup B$
		- AB
		- $A^*$
# Each if a pattern
- $\varepsilon$ matches only the empty string
- a only matches one-character string a
- etc
$L\set{\varepsilon} = \set{\varepsilon}$
$L(A^* ) = U_{n=0} ^ \infty L(A^n )$
- $A^n$ 
	- $A^0 = \set{\varepsilon}$
	- $A^{n+1} = A^n A$
# $x^*$ examples
- 001*
	- {00, 001, 0011, 00111, ...}
- 0* 1*
	- Any number of 0's followed by any number of 1's