# CSE 484 — Computer Security

Master navigation hub for CSE 484 notes.

---

## Security Fundamentals

- [[CSE484/Security Fundamentals/What is security|What is Security]] — security mindset, stakeholders, assets, threats, adversaries
- [[CSE484/Security Fundamentals/Threat Model|Threat Model]] — assets, adversaries, vulnerabilities, threats, risk, and defense in depth
- [[CSE484/Security Fundamentals/How Systems Fails|How Systems Fail]] — reliability, usability, design oversights, and intentional attacks
- [[CSE484/Security Fundamentals/Bug, Vulnerabilities, and exploits|Bugs, Vulnerabilities, and Exploits]] — buffer overflows, bounds checking, prevention techniques
- [[CSE484/Security Fundamentals/Root Cause Analysis and Patching|Root Cause Analysis and Patching]] — investigating exploits, CVE/CWE/CVSS, zero-days
- [[CSE484/Security Fundamentals/Other types of attacks|Other Types of Attacks]] — integer overflow, TOCTOU race conditions, timing attacks, defensive principles

---

## Policy and Access Control

- [[CSE484/Policy and Access Control/Targets for policy|Targets for Policy]] — CIA triad (confidentiality, integrity, availability), defining security policies, defenses
- [[CSE484/Policy and Access Control/Groups|Groups]] — mathematical group theory background for asymmetric cryptography

---

## Memory Exploits

- [[CSE484/Memory Exploits/Memory Layout in a Program|Memory Layout in a Program]] — text region, heap, stack, stack frames, calling convention
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout]] — visual diagram (screenshot reference)
- [[CSE484/Memory Exploits/Stack|Stack]] — x86 registers (%ebp, %esp, %EIP) and function call mechanics
- [[CSE484/Memory Exploits/Buffer Overflows|Buffer Overflows]] — stack-based overflow mechanics, shellcode, NOP sled
- [[CSE484/Memory Exploits/Off-by-One Overflow|Off-by-One Overflow]] — corrupting the Saved Frame Pointer, stack pivoting
- [[CSE484/Memory Exploits/Writing Stack with Format Strings|Writing Stack with Format Strings]] — format string vulnerability, `%n` write primitive
- [[CSE484/Memory Exploits/Defenses against buffer overflows|Defenses Against Buffer Overflows]] — stack canaries, ASLR, DEP/W^X, ROP, fuzzing

---

## Debugging Tools

- [[CSE484/Debugging Tools/How to enter GDB|How to Use GDB]] — launching GDB, breakpoints, memory inspection, register inspection

---

## Cryptography

- [[CSE484/Cryptography/Cryptography|Cryptography]] — Kerckhoff's Principle, symmetric vs. asymmetric, OTP, block ciphers (AES/DES), modes (ECB/CTR/CBC), IND-CPA/IND-CCA
- [[CSE484/Cryptography/Hashing + Ciphertext Integrity|Hashing and Ciphertext Integrity]] — MACs, hash functions, HMAC, SHA-2/SHA-3, authenticated encryption (AE/AEAD)
- [[CSE484/Cryptography/Asymmetric Cryptography + key Exchange|Asymmetric Cryptography and Key Exchange]] — Diffie-Hellman protocol, discrete logarithm, CDH problem
- [[CSE484/Cryptography/Public Key Encryption + Digital Signatures|Public Key Encryption and Digital Signatures]] — ElGamal encryption, Schnorr signatures, RSA

---

## Anonymity and Privacy

- [[CSE484/Anonymity and Privacy/Anonymity in data|Anonymity in Data]] — de-identification, pseudonym linkage, data release risk
- [[CSE484/Anonymity and Privacy/Anonymity in networks & messaging|Anonymity in Networks and Messaging]] — proxy servers, onion routing, Tor, mixnets, end-to-end encryption

---

## Side Channel Attacks

- [[CSE484/Side Channel Attacks/Side Channel Attacks|Side Channel Attacks]] — traffic analysis, power analysis, keyboard eavesdropping, cache timing attacks
- [[CSE484/Side Channel Attacks/Spectre|Spectre]] — speculative execution exploit, branch predictor training, cache timing read-out

---

## Machine Learning Security

- [[CSE484/Machine Learning Security/Machine Learning Security|Machine Learning Security]] — evasion attacks, extraction/model stealing, training data inference, generative disinformation

---

## Usable Security

- [[CSE484/Usable Security/Usable Security|Usable Security]] — human factors, SSL warnings, phishing, typosquatting, password managers, password hashing schemes
