# CSE 311: Set of Strings ($\Sigma^*$)

The set $\Sigma^*$ of strings over the alphabet $\Sigma$ is defined recursively.

- Example: $\{0,1\}^*$ contains all binary strings:
	- $0, 1, 01, 10, 11, 000, 001, \ldots$

$$\Sigma^* \text{ is defined as:}$$
$$\text{Basis: } \varepsilon \in \Sigma^* \quad (\varepsilon \text{ is the empty string "")}$$
$$\text{Recursion: if } w \in \Sigma^* \text{ and } a \in \Sigma,\ \text{then } wa \in \Sigma^*$$

The recursion says: take any existing string $w$ and append any character $a$ from the alphabet — the result $wa$ is also in $\Sigma^*$.

## Related

- [[Strings]]
- [[Recursive Definition of Sets]]
- [[Regular Expressions]]
- [[Functions on a Set of Strings]]
