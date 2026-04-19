# CSE484: Root Cause Analysis and Patching

## How to Investigate an Exploit

When analyzing a suspected exploit, start by asking:
- What is different between a normal interaction and the exploit?
- What parts of the code are relevant to that interaction?
  - Add logging and debugging to narrow down the location
- Develop theories about what is happening
- Test your theories

## Goals of Root Cause Analysis

- **Identify what the exploit accomplishes** — what does the attacker gain?
- **Identify the major steps the exploit takes** — what sequence of actions does it require?
- **Find the specific code components responsible** — this is the **vulnerability**
  - Consider that an exploit might leverage missing features, not just buggy code
- **Find "nearby" bugs** — if you find the most-responsible line of code, is adjacent code also vulnerable?

## Terminology

- **Zero-day (0-day):** A vulnerability that is made known to the public at the same time (or before) the vendor is notified. No patch exists yet.
- **CVE Number (Common Vulnerabilities and Exposures):** A standardized identifier assigned to each publicly known security vulnerability.
- **CWE (Common Weakness Enumeration):** A community-maintained list of software and hardware weakness types (e.g., CWE-121: Stack-based Buffer Overflow).
- **CVSS (Common Vulnerability Scoring System):** A numerical score (0–10) meant to represent the severity of a vulnerability. Has very limited utility in practice — scores barely correlate with real-world impact.

## Related

- [[Bug, Vulnerabilities, and Exploits]] — what bugs become vulnerabilities
- [[How Systems Fails]] — categories of failure
- [[Threat Model]] — risk assessment 