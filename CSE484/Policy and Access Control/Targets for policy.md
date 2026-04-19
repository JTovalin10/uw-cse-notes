# CSE484: Targets for Policy (CIA Triad)

## Common General Security Goals: “CIA”

The **CIA triad** is the foundational framework for defining security goals:

### Confidentiality

The **concealment of information** — ensuring unauthorized parties cannot access it.
- Prevents packet sniffing
- Prevents eavesdropping
- Prevents illegal copying

### Integrity

The **prevention of unauthorized changes** to data or systems.
- Prevents unauthorized assumption of another's identity
- Ensures data has not been tampered with in transit

### Availability

The **ability to use information or resources** when needed.
- The system must still work despite an adversary
- Adversaries may overwhelm or crash servers (e.g., a Denial of Service attack) to disrupt infrastructure

## Defining Security Policies

A security policy should take the form:

> **Asset Name** should have **security property** against **adversary** with **adversary resources**

This makes policies precise and testable.

## Toward Defenses

A threat of a response may deter some attackers. The three categories of response are:

- **Prevention** — stop an attack before it happens
- **Detection** — detect an ongoing or past attack
- **Response and Resilience** — respond to and recover from an attack

## Whole-System View

Security must be considered at every layer:
- **Cryptography** — protecting data in transit and at rest
- **Implementation** — secure coding practices
- **People** — training, social engineering awareness
- **Physical security** — protecting hardware and facilities
- Everything in between

**Security is only as strong as the weakest link.**

## Related

- [[What is security]] — the security mindset
- [[Threat Model]] — assets, adversaries, risk, and defense in depth
- [[CSE484/Cryptography/Cryptography|Cryptography]] — the cryptographic layer of a secure system
- [[CSE484/Usable Security/Usable Security|Usable Security]] — the “people” layer