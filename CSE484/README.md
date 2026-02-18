# CSE 484 - Computer Security

## Course Overview

CSE 484 covers the principles and practices of computer security. The course explores vulnerabilities, attacks, defenses, and the security mindset needed to build and analyze secure systems.

## Topics Covered

### Security Fundamentals
- Security mindset: stakeholders, assets, threats, adversaries
- Security policy and goals
- Threat modeling
- How systems fail
- Bugs, vulnerabilities, and exploits
- Root cause analysis and patching
- Types of attacks

### Memory Exploits
- Memory layout in programs (stack, heap, data, code)
- Stack structure and function calls
- Buffer overflows
  - How buffer overflow attacks work
  - Stack smashing and return address overwriting
  - Shellcode and NOP sleds
- Format string vulnerabilities
- Off-by-one overflow
- Defenses against buffer overflows (ASLR, stack canaries, DEP/NX)

### Policy and Access Control
- Security policy targets
- Access control models
- Groups and permissions

### Cryptography
- Symmetric and asymmetric cryptography
- Hashing and ciphertext integrity
- Key exchange protocols
- Public key encryption
- Digital signatures

### Anonymity and Privacy
- Anonymity in data (de-identification, k-anonymity)
- Anonymity in networks and messaging
- Privacy-preserving techniques

### Side Channel Attacks
- Introduction to side channels
- Spectre and other speculative execution attacks
- Timing attacks

### Machine Learning Security
- Adversarial machine learning
- Attacks on ML models

### Usable Security
- Human factors in security
- Security usability trade-offs

### Debugging Tools
- Using GDB for security analysis
