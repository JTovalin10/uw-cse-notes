# Message Authentication Code (MAC)

* **MAC (sometimes called a tag):** A short piece of information used to authenticate a message.

# Achieving Integrity

* **Message Authentication Schemes:** A tool for protecting message **integrity** (ensuring the message hasn't been tampered with) and **authenticity** (proving who the message came from).
* When the receiver gets the message, they must recompute the MAC on the message using the same shared secret key.
* They then verify if their computed MAC is equal to the MAC attached to the message.
* Only someone who knows the secret **Key ($K$)** can compute the correct MAC for a given message.

# Hash Functions

* A hash function $H$ is a **lossy compression function**. It maps an arbitrary-sized input to a fixed-size output.
* **Birthday Attack:** Brute-forcing a *collision* (finding two different inputs that hash to the same output) takes roughly $O(2^{n/2})$ operations, not $O(2^n)$, where $n$ is the output size in bits.

## Properties of Cryptographic Hash Functions:

* **One-Way (Pre-image Resistance):**
    * The hash should be hard to invert.
    * Given an output $y$, it should be computationally infeasible to find any input $x$ such that $H(x) = y$.
* **Collision Resistance (Strong Collision Resistance):**
    * Should be hard to find two different inputs $x \neq x'$ such that $H(x) = H(x')$.
* **Indifferentiability (Random Oracle Model):**
    * Informal: The outputs of the hash function should look "random" and unpredictable, as if they were chosen by a perfectly random function (an "ideal model").

# Hashing vs. Encryption

* **Hashing is one-way:** There is no "un-hash" function or key to recover the original input.
    * **Encryption is two-way:** Ciphertext can be decrypted back to plaintext using the correct decryption key.
* **Hashing is deterministic:**
    * Hashing the same input twice *always* produces the same hash value.
    * **Secure encryption is probabilistic:** Encrypting the same input twice produces two different ciphertexts (due to the use of a random IV or nonce).

# MAC via Hashing (e.g., HMAC)

* A common way to build a MAC is by combining a secret key with a hash function.
* A naive (and insecure) attempt might look like: `Tag = Hash(K || message)`
* *Note: The actual secure construction, **HMAC**, is more complex: `HMAC(K, m) = H((K' \oplus opad) || H((K' \oplus ipad) || m))`*

# Common Hash Functions

* **SHA-2:** A family of hashes including SHA-256, SHA-512, SHA-224, and SHA-384. **(Secure)**
* **SHA-3:** The current standard, released by NIST in August 2015. **(Secure)**
* **MD5 (Message Digest 5):** **Do NOT use for security.**
    * 128-bit output.
    * Known to be vulnerable to collision attacks (broken).
* **SHA-1 (Secure Hash Algorithm 1):** **Do NOT use for security.**
    * 160-bit output.
    * Theoretically broken and practical collision attacks have been demonstrated.

# Authenticated Encryption (AE)

* If we want both **confidentiality** (encryption) and **integrity/authenticity** (MAC), we must combine an encryption scheme and a MAC.
* This is called **Authenticated Encryption (AE)** or Authenticated Encryption with Associated Data (AEAD).
* It is crucial to combine them in a secure way (e.g., "Encrypt-then-MAC"). Modern schemes like AES-GCM are designed to do both in one efficient operation.