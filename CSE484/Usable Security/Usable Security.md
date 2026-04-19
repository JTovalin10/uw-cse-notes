# CSE484: Usable Security

## Why Usability Matters

People are a critical element of any computer system. Even if a system is technically capable of protecting against an adversary, people may use it in other, less secure ways. A security system that no one uses or that users routinely bypass provides no real protection.

## HTTP Indicators and SSL Warnings

The **lock icon** in a browser's address bar indicates that the page is protected against a network attacker (a man-in-the-middle). It does **not** mean that the website itself is trustworthy or safe — the site could still be a phishing page, just one that happens to use HTTPS.

## Phishing

**Phishing** is when an attacker creates a fake website to trick users into providing credentials or other sensitive information.

- **Active warnings** are shown when a browser detects a known phishing site. However, design choices matter:
  - Making the "I acknowledge" button difficult to find is actually more effective than placing it prominently, because users who see it immediately just click through without reading.
  - **Opinionated design:** Requires the user to explicitly choose "Accept risk and visit" and manage the tracker consent — forcing engagement.
  - **Manipulated design:** Requires the user to accept full responsibility before entering — raising the psychological barrier.

### Reasons Security Warnings Fail

- Users do not trust the warning (it seems too dramatic or cries wolf too often)
- Users ignore it because it is familiar and repetitive
- However, warnings do statistically reduce the number of people entering an insecure site

### Ways Attackers Confuse Users

- Creating a site without HTTPS
- **Typosquatting:** Registering a visually similar domain — e.g., `bankofthevvest.com` instead of `bankofthewest.com` (the double `v` looks like a `w`)
- **Picture-in-picture attacks:** Displaying a fake browser window inside the real browser window — interestingly, more security-trained users are susceptible to this

## Password Managers

Despite knowing they should use different passwords for different accounts, most people reuse the same password — so a single compromised account can expose all of their accounts.

Using a **password manager** is better because it generates and stores unique, strong passwords for each site.

### Password Hashing Scheme

- If you reuse a password and it gets compromised from one site, all your accounts are at risk.
- A clever approach: use `Hash(domain + password)` as your actual password. The hash output will be different for each domain, even if the input `password` component is reused. This way, compromising one site's hash does not expose the hash for another site.

## Related

- [[CSE484/Policy and Access Control/Targets for policy|Targets for Policy]] — the "people" layer is part of the whole-system security view
- [[CSE484/Anonymity and Privacy/Anonymity in data|Anonymity in Data]] — privacy behaviors and user expectations
- [[CSE484/Cryptography/Hashing + Ciphertext Integrity|Hashing and Ciphertext Integrity]] — the hash functions underlying password hashing schemes
- [[CSE484/Machine Learning Security/Machine Learning Security|Machine Learning Security]] — disinformation attacks also target human judgment