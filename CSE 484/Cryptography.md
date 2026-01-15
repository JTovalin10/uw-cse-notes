***

## Kerckhoff's Principle

This is a fundamental concept in modern cryptography.

* The security of a cryptographic system (like an encryption algorithm) should depend **only on the secrecy of the key**.
* It should **not** depend on the secrecy of the algorithm itself.

In other words, you should be able to publicly post your algorithm for everyone to see, and as long as your key remains private, your messages should remain secure. This allows for public review and analysis to find flaws, ultimately leading to stronger, more robust algorithms.

* **Watch:** [A short video explaining Kerckhoff's Principle](https://www.youtube.com/watch?v=kDFyR-g0Ah4)

***

## Flavors of Cryptography

Cryptography is generally split into two main types based on how they use keys.

### Symmetric Cryptography (Secret-Key)

* **How it works:** Both parties (e.g., sender and receiver) use a **single, shared secret key** ($K$).
* The same key is used for both encryption and decryption.
* **Challenge:** How do you securely share the secret key in the first place? This is known as the *key distribution problem*.
* **Examples:** AES, DES, ChaCha20



[Image of public key infrastructure diagram]


### Asymmetric Cryptography (Public-Key)

* **How it works:** Each party generates a *key pair* consisting of:
    1.  A **Public Key ($pk$)**: This key can be shared with anyone.
    2.  A **Secret Key ($sk$)** (or Private Key): This key **must** be kept completely private.
* To send a message *to* someone, you encrypt it with *their* **public key**.
* Only that person can decrypt the message, using *their* **secret key**.
* **Correction:** Parties have access to each other's **public key**, *not* their private/secret key. The secrecy of the private key is essential for security.
* **Examples:** RSA, Diffie-Hellman Key Exchange

* **Watch:** [Symmetric vs. Asymmetric Encryption (A High-Level Overview)](https://www.youtube.com/watch?v=A02s5cF2rZ8)

***

## The Role of Randomness

Secure randomness is a critical building block for almost all cryptographic systems. Computers are deterministic, so generating *true* randomness is a hard problem. Cryptography often relies on **pseudorandom number generators (PRNGs)** that are "cryptographically secure," meaning their output is unpredictable without knowing a secret "seed."

### Cryptographic Uses

* Generating secret cryptographic keys (both symmetric and asymmetric).
* Generating a random **Initialization Vector (IV)** or **nonce** for encryption modes to ensure encrypting the same message twice doesn't produce the same ciphertext.

### Other Security-Related Uses

* Shuffling the order of votes in an electronic voting system to protect anonymity.
* Shuffling a deck of cards in a secure online poker game.

***

## Symmetric Encryption: The One-Time Pad

### Goal: Confidentiality

The primary goal of encryption is **confidentiality**: ensuring that an unauthorized party (an "attacker") cannot understand the content of a message.

### The One-Time Pad (OTP)

The **One-Time Pad** is a theoretically perfect, but practically difficult, symmetric encryption technique.

* **How it works:** It's a simple **XOR encryption**.
    * Let $M$ be the plaintext (your message) and $K$ be the secret key.
    * **Encryption:** Ciphertext $C = M \oplus K$
    * **Decryption:** Plaintext $M = C \oplus K$
* **Why it works:** The XOR operation is its own inverse: $M = (M \oplus K) \oplus K$

#### Properties & Advantages

* **Easy to Compute:** The bitwise XOR ($\oplus$) operation is extremely fast for computers.
* **Perfect Secrecy:** This is the OTP's main claim.
    * **Definition:** Given a ciphertext, an attacker with *unlimited* computational power learns **absolutely nothing** about the plaintext. All possible plaintexts of the same length are equally likely.
    * **Example:** If the ciphertext is `1011`, the plaintext could just as likely be `0000` (if the key was `1011`) as it could be `1111` (if the key was `0100`).

#### Conditions & Limitations

The "perfect secrecy" of the OTP only holds if *all* of the following conditions are met. These are its major practical downsides:

1.  **Truly Random Key:** The key $K$ must be generated from a truly random, unpredictable source.
2.  **Key Length:** The key $K$ must be **at least as long as the plaintext** $M$.
3.  **Key Reuse (The "One-Time" part):** The key $K$ can **NEVER** be used more than once.
    * **This is a critical vulnerability.** If a key is reused ($C_1 = M_1 \oplus K$ and $C_2 = M_2 \oplus K$), an attacker can XOR the two ciphertexts together:
    * $C_1 \oplus C_2 = (M_1 \oplus K) \oplus (M_2 \oplus K) = M_1 \oplus M_2$
    * This cancels out the key and reveals the XOR of the two plaintexts, which is often enough to break the encryption (this is called a *two-time pad attack*).
4.  **No Integrity:** The OTP only provides **confidentiality**. It does **not** provide **integrity** or **authentication**.
    * An attacker can't *read* the message, but they *can* flip bits in the ciphertext ($C' = C \oplus \text{AttackMask}$), and this will directly flip the corresponding bits in the decrypted plaintext ($M' = M \oplus \text{AttackMask}$) without the receiver knowing.

* **Watch:** [How the One-Time Pad Works (and Why it's "Perfectly Secure")](https://www.youtube.com/watch?v=2_w-b00-F2I)

***

# Block Ciphers

* A single key can be re-used (with restrictions, e.g., using a fresh IV).
* Not as theoretically secure as the one-time pad.
* **Security:**
    * For a randomly selected key, it should be computationally hard to distinguish the outputs of the block cipher from the outputs of a truly random permutation.
    * Popular block ciphers (like AES) are widely trusted but do not have absolute proof of security (unlike the OTP).

## Standard Block Ciphers

* **DES: Data Encryption Standard**
    * **64-bit** blocks
    * **56-bit** key (technically a 64-bit key, but 8 bits are for parity).
* **3DES (Triple DES)**
    * Two-key 3DES increases the security of DES by using a 112-bit key (2 * 56).
    * **Why not 2DES?** There is minimal gain in security over DES due to the *meet-in-the-middle attack*.
* **AES: Advanced Encryption Standard**
    * Based on the Rijndael algorithm.
    * **128-bit** blocks.
    * Keys can be: **128, 192, or 256 bits**.
    * The new federal standard as of 2001.

***

# Encrypting a Large Message

Block ciphers on their own only encrypt a single, fixed-size block. To encrypt a large message, you must use a **mode of operation**.

# Electronic Code Book (ECB) Mode

* Split the plaintext into block-sized chunks and encrypt each one separately with the same key.

## Issues with ECB

* It has the same issues as a simple substitution cipher. Identical plaintext blocks produce identical ciphertext blocks, which allows for frequency analysis and leaks a lot of information about the plaintext structure.

# Counter (CTR) Mode

* **Security Intuition:**
    * Outputs a block cipher keystream which looks like a random one-time pad.
    * As long as the **Initialization Vector (IV) / nonce** is never reused with the same key, the one-time pad is never reused.
* **Properties:**
    * Parallelizable (for both encryption and decryption).
    * Decryption does not require the block cipher's inverse function.

# Cipher Block Chaining (CBC) Mode

* **Security Intuition:** Ciphertext blocks appear random, and each block's encryption depends on the previous block, which produces unpredictable inputs to the block cipher.
    * Also requires that the **IV is not reused** with the same key.
* **Properties:**
    * Encryption is serial (sequential).
    * Decryption **is parallelizable**.
    * Decryption requires the block cipher's inverse function.

***

# When is an Encryption Scheme "Secure"?

* **Hard to recover the key:** This is a basic requirement.
    * What if an attacker can learn the plaintext *without* learning the key?
* **Hard to recover plaintext from ciphertext:**
    * What if an attacker learns *some* bits or *some function* of the bits?

## How can a Cipher be Attacked?

An attacker is assumed to know the ciphertext and the encryption algorithm (Kerckhoff's Principle).

* **Ciphertext-only attack:** Attacker only has a collection of ciphertexts.
* **KPA: Known-plaintext attack:** Attacker knows some plaintext-ciphertext pairs.
* **CPA: Chosen-plaintext attack:** Attacker can obtain the ciphertext for any plaintext of their choice.
    * **Security against this (IND-CPA):**
        * Ciphertext leaks no information about the plaintext.
        * Even if an attacker *guesses* the plaintext, they cannot verify their guess.
        * Every ciphertext is unique; encrypting the same message twice produces a completely different ciphertext (achieved using a random IV or nonce).
* **CCA: Chosen-ciphertext attack:** Attacker can decrypt any ciphertext *except* the target ciphertext.
    * **Security against this (IND-CCA):**
        * This typically requires **integrity protection** (e.g., a MAC).
        * It is not possible for an attacker to change the plaintext by modifying the ciphertext without being detected.

## The Shape of a Formal Approach

* **IND-CPA: Indistinguishability under Chosen Plaintext Attack**
* **Formalized Cryptographic Game:**
    1.  An adversary submits two different plaintexts, $M_0$ and $M_1$.
    2.  The "challenger" (oracle) flips a coin ($b$), encrypts one of them ($C_b = \text{Enc}(K, M_b)$), and sends the resulting ciphertext $C_b$ back.
    3.  The adversary must guess which message was encrypted (i.e., guess the value of $b$).
    4.  If the adversary cannot guess correctly with a probability significantly better than 50/50, the scheme is considered IND-CPA secure.

### CTR vs. CBC

* CBC and CTR (when used correctly) both offer IND-CPA security.
* CBC has historically been more popular, but CTR is now very common (e.g., in TLS 1.3).
* **CTR encryption is potentially faster** than CBC encryption, since CTR is
    inherently parallelizable, whereas CBC encryption is sequential.
    * CBC decryption, however, **is** parallelizable.
* **CBC requires padding** the message to a length that is a multiple of the block size, whereas **CTR does not**.
    * (Handling padding securely can be tricky and lead to "padding oracle" attacks if not implemented carefully).
* CTR does not require the inverse block cipher operation for decryption, which can be a small advantage (e.g., AES has a slightly different implementation for encryption and decryption).
* 