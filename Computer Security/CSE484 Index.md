# CSE 484 — Computer Security

Master navigation hub for CSE 484 notes.

---

## Security Fundamentals

- [[What is security|What is Security]] — security mindset, stakeholders, assets, threats, adversaries
- [[Threat Model|Threat Model]] — assets, adversaries, vulnerabilities, threats, risk, and defense in depth
- [[How Systems Fail|How Systems Fail]] — reliability, usability, design oversights, and intentional attacks
- [[Computer Security/Security Fundamentals/Bug, Vulnerabilities, and exploits|Bugs, Vulnerabilities, and Exploits]] — buffer overflows, bounds checking, prevention techniques
- [[Root Cause Analysis and Patching|Root Cause Analysis and Patching]] — investigating exploits, CVE/CWE/CVSS, zero-days
- [[Computer Security/Security Fundamentals/Other types of attacks|Other Types of Attacks]] — integer overflow, TOCTOU race conditions, timing attacks, defensive principles

---

## Policy and Access Control

- [[Targets for Policy|Targets for Policy]] — CIA triad (confidentiality, integrity, availability), defining security policies, defenses
- [[Groups|Groups]] — mathematical group theory background for asymmetric cryptography

---

## Memory Exploits

- [[Memory Layout in a Program|Memory Layout in a Program]] — text region, heap, stack, stack frames, calling convention
- [[Computer Security/Memory Exploits/Memory Layout|Memory Layout]] — visual diagram (screenshot reference)
- [[Computer Security/Memory Exploits/Stack|Stack]] — x86 registers (%ebp, %esp, %EIP) and function call mechanics
- [[Buffer Overflows|Buffer Overflows]] — stack-based overflow mechanics, shellcode, NOP sled
- [[Off-by-One Overflow|Off-by-One Overflow]] — corrupting the Saved Frame Pointer, stack pivoting
- [[Writing Stack with Format Strings|Writing Stack with Format Strings]] — format string vulnerability, `%n` write primitive
- [[Defenses Against Buffer Overflows|Defenses Against Buffer Overflows]] — stack canaries, ASLR, DEP/W^X, ROP, fuzzing

---

## Debugging Tools

- [[How to enter GDB|How to Use GDB]] — launching GDB, breakpoints, memory inspection, register inspection

---

## Cryptography

- [[Cryptography|Cryptography]] — Kerckhoff's Principle, symmetric vs. asymmetric, OTP, block ciphers (AES/DES), modes (ECB/CTR/CBC), IND-CPA/IND-CCA
- [[Hashing + Ciphertext Integrity|Hashing and Ciphertext Integrity]] — MACs, hash functions, HMAC, SHA-2/SHA-3, authenticated encryption (AE/AEAD)
- [[Asymmetric Cryptography + key Exchange|Asymmetric Cryptography and Key Exchange]] — Diffie-Hellman protocol, discrete logarithm, CDH problem
- [[Public Key Encryption + Digital Signatures|Public Key Encryption and Digital Signatures]] — ElGamal encryption, Schnorr signatures, RSA

---

## Anonymity and Privacy

- [[Anonymity in data|Anonymity in Data]] — de-identification, pseudonym linkage, data release risk
- [[Anonymity in networks & messaging|Anonymity in Networks and Messaging]] — proxy servers, onion routing, Tor, mixnets, end-to-end encryption

---

## Side Channel Attacks

- [[Computer Security/Side Channel Attacks/Side Channel Attacks|Side Channel Attacks]] — traffic analysis, power analysis, keyboard eavesdropping, cache timing attacks
- [[Spectre|Spectre]] — speculative execution exploit, branch predictor training, cache timing read-out

---

## Machine Learning Security

- [[Machine Learning Security|Machine Learning Security]] — evasion attacks, extraction/model stealing, training data inference, generative disinformation

---

## Usable Security

- [[Usable Security|Usable Security]] — human factors, SSL warnings, phishing, typosquatting, password managers, password hashing schemes
