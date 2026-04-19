# CSE484: How Systems Fail

Systems fail for multiple reasons, and understanding these categories helps identify where to focus defenses.

- **Reliability**: deals with accidental failures
  - Example: a race condition could cause a crash
- **Usability**: deals with problems arising from operating mistakes made by users
  - Example: bad logic flow in a UI causes users to take unintended actions
- **Design and goal oversights**: deals with oversights, errors, and omissions during the design process
  - Example: no password reset feature was planned
- **Security**: deals with **intentional** failures created by an **intelligent** adversary
  - Security is specifically about computing in the presence of an adversary
  - However, all of the above categories are related — any reliability or usability flaw can become a security flaw when exploited intentionally

## Related

- [[What is security]] — foundational security mindset
- [[Threat Model]] — adversaries and risk analysis
- [[Bug, Vulnerabilities, and Exploits]] — how bugs become exploitable
- [[Other Types of Attacks]] — integer overflow, TOCTOU, timing attacks