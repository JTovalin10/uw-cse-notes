# CSE484: Threat Model

A **threat model** is the structured analysis of a system's security by examining the following components:

## Assets

What are we trying to protect?
- User data
- System availability
- Sensitive business information

## Adversaries

Who might try to attack the system, and why?
- Foreign governments
- Other companies (corporate espionage)
- Hackers (financial gain, notoriety)
- Other users (privilege escalation)

## Vulnerabilities

How might the system be weak?
- Buggy code (e.g., [[Buffer Overflows]])
- Weak passwords
- Social engineering
- Insider threats (employees with legitimate access)

## Threats

What actions might an adversary take to exploit vulnerabilities?

## Risk

How do we assess risk?
- How important are the assets?
- How likely is a successful exploit?
  - Legal and ethical considerations: legal ramifications, company reputation, personal information of customers
  - How many resources would the adversary need to execute the attack?
  - **The attacker only needs to win once** — so build multiple layers of defense

## Defense in Depth

A layered approach to security means no single failure is catastrophic:
- Write code using secure tools and practices
- Limit employee access to data (**least privilege**)
- Enforce strong passwords
- See also: [[CSE484/Policy and Access Control/Targets for policy|Targets for Policy]]

## Related

- [[What is security]] — foundational security mindset
- [[How Systems Fail]] — why systems break down
- [[Bug, Vulnerabilities, and Exploits]] — bugs that become exploitable
- [[CSE484/Policy and Access Control/Targets for policy|Targets for Policy]] — CIA triad and defining security properties
- 