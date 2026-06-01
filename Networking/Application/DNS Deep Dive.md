# Application: DNS Deep Dive

### Formal Definition
The **Domain Name System (DNS)** is a hierarchical and decentralized naming system for computers, services, and other resources connected to the Internet. It translates human-readable hostnames (example.com) into IP addresses.

---

## 1. Resolution Logic
- **Recursive Resolver**: The server the client talks to (e.g., 8.8.8.8). It does the "legwork" of asking other servers until it finds the answer.
- **Iterative Query**: The resolver asks a server (e.g., Root), which says "I don't know, but ask the .com TLD server." The resolver then asks the TLD server itself.

## 2. Record Types
| Type | Name | Purpose |
| :--- | :--- | :--- |
| **A** | Address | IPv4 address of a host. |
| **AAAA** | Quad-A | IPv6 address of a host. |
| **CNAME** | Canonical Name | Alias of one name to another (example.com -> server1.hosting.com). |
| **MX** | Mail Exchange | Points to the mail server for the domain. |
| **NS** | Name Server | Specifies the authoritative servers for a zone. |
| **PTR** | Pointer | Reverse DNS (IP -> Hostname). |
| **TXT** | Text | Arbitrary data (used for SPF, DKIM, and site verification). |

## 3. DNS over UDP vs TCP
- **UDP (Port 53)**: Standard for small queries. Fast, but limited to 512 bytes (extended to 4096 via EDNS0).
- **TCP (Port 53)**: Used for Zone Transfers (AXFR) or when responses exceed UDP limits.
- **DoH/DoT**: Modern encryption (Port 443/853) to prevent eavesdropping and hijacking.

## 4. Security Risks
- **DNS Spoofing/Cache Poisoning**: Forging a response to a resolver to redirect traffic to a malicious IP. Mitigated by **DNSSEC**.
- **Amplification Attack**: A type of DDoS where a small spoofed query (UDP) triggers a massive response to the victim's IP.

## 5. TTL Tradeoffs
- **Low TTL (e.g., 60s)**: High agility (quick failover), but high latency (more lookups) and high load on servers.
- **High TTL (e.g., 86400s)**: High performance (cached), but slow to react to infrastructure changes.

### Related
- [[Domain Name System (DNS)]]
- [[Iterative vs Recursive Queries]]
