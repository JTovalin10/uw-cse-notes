# CSE484: Groups (Mathematical Background for Cryptography)

A **group** is a mathematical structure used throughout asymmetric cryptography (Diffie-Hellman, RSA, elliptic curves). A group consists of a set $G$ of elements and an operation $\oplus$ satisfying the following axioms:

- **Closure:** For all $a, b \in G$, the result $a \oplus b$ is also in $G$.
- **Associativity:** $(a \oplus b) \oplus c = a \oplus (b \oplus c)$
- **Identity:** There exists an identity element $I$ such that $a \oplus I = a$ for all $a$.
- **Inverse:** For every $a \in G$, there exists $a^{-1}$ such that $a \oplus a^{-1} = I$.
- **Order:** The number of elements in the group, denoted $|G|$.
- **Cyclic (optional, but very useful):** A group is **cyclic** if there exists a **generator** $g$ such that $\{g, g^2, g^3, \dots, g^{|G|}\} = G$. That is, every element can be expressed as a power of $g$.

Cyclic groups of prime order are the foundation of the **Discrete Logarithm** hardness assumption used in Diffie-Hellman and related protocols.

## Related

- [[CSE484/Cryptography/Asymmetric Cryptography + key Exchange|Asymmetric Cryptography and Key Exchange]] — Diffie-Hellman and the discrete logarithm problem
- [[CSE484/Cryptography/Public Key Encryption + Digital Signatures|Public Key Encryption and Digital Signatures]] — RSA and Schnorr signatures built on group theory