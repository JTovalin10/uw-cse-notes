# MAC via Hashing

* A common (but naive) construction is `Tag = H(key || Message)`.
* The security of such constructions depends on strong properties of the hash function $H$.
* A known-secure construction like **HMAC** is generally preferred.
* Modern hash functions like **SHA-3** are designed to satisfy strong properties like **indifferentiability** (behaving like a true random function).

# Applications of Public Key Crypto

* **Encryption for Confidentiality**
    * Anyone can encrypt a message using the recipient's **public key**.
        * (With symmetric crypto, one must know the *secret* key to encrypt).
    * Only someone who knows the corresponding **private key** can decrypt.
* **Key Management is Simpler**
    * The secret (private key) is stored only in one place (by the owner).
* **Digital Signatures**
    * Provides integrity (message wasn't changed), authenticity (sender is verified), and non-repudiation (sender can't deny sending).
* **Session Key Establishment / "Key Exchange"**
    * Two parties exchange messages to agree on a shared secret "session key."
    * They then switch to faster **symmetric cryptography** (using that new key) for the rest of the conversation.

# Hardness Assumptions over Groups

* Let $G$ be a cyclic group of prime order $p$ with a generator $g$.
* **Discrete Logarithm (DL) Problem:**
    * Pick a random secret $x$.
    * Compute the public value $X = g^x \pmod{p}$.
    * **Problem:** Given $g$, $p$, and $X$, it is computationally hard to find $x$.
* **Computational Diffie-Hellman (CDH) Problem:**
    * Pick two random secrets, $x$ and $y$.
    * Compute $X = g^x \pmod{p}$ and $Y = g^y \pmod{p}$.
    * **Problem:** Given $g$, $p$, $X$, and $Y$, it is computationally hard to compute the shared secret $g^{xy} \pmod{p}$.

# Diffie-Hellman Protocol

* **Goal:** Alice and Bob want to agree on a shared secret key, but they have never met and share no prior secrets.
* **Public Information:** All parties know the group $G$, its order $p$, and a generator $g$.
* **Protocol:**
    1.  **Alice:**
        * Chooses a random private key $a$.
        * Computes her public key $A = g^a \pmod{p}$.
        * Sends $A$ to Bob.
    2.  **Bob:**
        * Chooses a random private key $b$.
        * Computes his public key $B = g^b \pmod{p}$.
        * Sends $B$ to Alice.
    3.  **Shared Secret Calculation:**
        * **Alice computes:** $S = B^a \pmod{p} = (g^b)^a \pmod{p} = g^{ab} \pmod{p}$.
        * **Bob computes:** $S = A^b \pmod{p} = (g^a)^b \pmod{p} = g^{ab} \pmod{p}$.
    * Both now share the same secret key $S$.
* **Vulnerability:** This protocol **does not** protect from **Person-in-the-Middle (PITM)** attacks.