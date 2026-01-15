# Applications of Public Key Cryptography

-   Encryption for confidentiality
-   Digital signatures for integrity
-   Session key establishment / key exchange

## Public key Encryption

Alice ($pk_A, sk_A$) wants to send a message $m$ to Bob ($pk_B, sk_B$).

1.  Alice computes ciphertext: $c = E(pk_B, m)$
2.  Alice sends $c$ to Bob.
3.  Bob receives $c$.
4.  Bob decrypts message: $m = D(sk_B, c)$

### From Diffie-Hellman

This scheme is also known as ElGamal encryption.

* Let $g$ be a generator for $\mathbb{Z}_p^*$, $p$ is a prime
* Alice: $sk_A = a$, $pk_A = g^a \mod p$
* Bob: $sk_B = b$, $pk_B = g^b \mod p$
* To encrypt $m \in \mathbb{Z}_p^*$, Alice picks random $k \in \mathbb{Z}_{p-1}$
* Ciphertext $c = (c_1, c_2) = (g^k \mod p, m \cdot (pk_B)^k \mod p) = (g^k \mod p, m \cdot g^{bk} \mod p)$
* Bob decrypts $c = (c_1, c_2)$:
    * $m = c_2 \cdot (c_1^{sk_B})^{-1} \mod p$
    * $m = c_2 \cdot (c_1^b)^{-1} \mod p$
    * $m = (m \cdot g^{bk}) \cdot ( (g^k)^b )^{-1} = m \cdot g^{bk} \cdot g^{-bk} = m \mod p$

# Signatures

## Digital Signature

-   No one should be able to forge signatures from Bob's $pk$ without Bob's $sk$!

Bob ($pk_B, sk_B$) wants to sign a message $m$ and send it to Alice ($pk_A, sk_A$).

1.  Bob computes signature: $\sigma = Sign(sk_B, m)$
2.  Bob sends $(m, \sigma)$ to Alice.
3.  Alice receives $(m, \sigma)$.
4.  Alice verifies: $Verify(pk_B, m, \sigma) \to \text{yes/no}$

## Schnorr Signature

* Let $g$ be a generator for $\mathbb{Z}_p^*$, $p$ is a prime
* Let $H: \{0,1\}^* \to \mathbb{Z}_p$ be a hash function
* Bob: $sk_B = b$, $pk_B = g^b \mod p$
* To sign $m \in \{0,1\}^*$, Bob picks random $k \in \mathbb{Z}_p$
* Compute $r = g^k \mod p$
* Compute $e = H(m, r) \in \mathbb{Z}_p$
* Compute $s = k + b \cdot e \mod p$
* Signature is $\sigma = (e, s)$
* Verify $\sigma = (e, s)$ on $m$:
    * Compute $r' = g^s \cdot (pk_B)^{-e} \mod p$
    * Check if $H(m, r') = e$
* **Why is this correct?**
    * $r' = g^{k+be} \cdot (g^b)^{-e} = g^{k+be} \cdot g^{-be} = g^k = r \mod p$
    * So $H(m, r') = H(m, r) = e$

# RSA Cryptosystem

* **Key generation:**
    * Pick 2 large primes $p, q$ (e.g., 1024 bits each)
    * Compute $n = pq$
    * Compute $\phi(n) = (p-1)(q-1)$
    * Pick $e$ such that $gcd(e, \phi(n)) = 1$
    * Compute $d = e^{-1} \mod \phi(n)$
    * Public key: $pk = (n, e)$
    * Secret key: $sk = (n, d)$ (or $(p, q, d)$)
* **Encryption of $m \in \mathbb{Z}_n^*$:**
    * $c = m^e \mod n$
* **Decryption of $c$:**
    * $m = c^d \mod n$

### Why is RSA Secure?

* **RSA problem:**
    * given $c$, $n=pq$, and $e$ such that $gcd(e, \phi(n))=1$, find $m$ such that $m^e \equiv c \mod n$
* **Factoring problem:**
    * given positive integer $n$, find primes $p_1, \dots, p_k$ such that $n = p_1^{e_1} p_2^{e_2} \cdots p_k^{e_k}$
* **If factoring is easy, then RSA problem is easy**
    * (knowing factors means you can compute $d$ = inverse of $e \mod (p-1)(q-1)$)