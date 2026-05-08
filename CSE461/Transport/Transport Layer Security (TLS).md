# CSE461: Transport Layer Security (TLS)

**Transport Layer Security (TLS)** is a cryptographic protocol that provides encrypted, authenticated, and integrity-protected communication between two parties over a network. It sits between the transport layer ([[CSE461/Definitions/Transmission Control Protocol (TCP)|TCP]]) and the application layer, and is the security foundation of HTTPS, email, and most modern internet traffic.

## What TLS Provides
- **Confidentiality** — data is encrypted so eavesdroppers cannot read it
- **Authentication** — the server (and optionally client) is verified via certificates and digital signatures
- **Integrity** — message authentication codes (MACs) detect tampering in transit

## TLS Handshake

The handshake negotiates keys and authenticates the server before any application data flows.

### TLS 1.3 (current standard)
- **1-RTT** for a new connection
- **0-RTT** for resuming a known session (session tickets), at the cost of replay vulnerability
- Combines key exchange and cipher negotiation in a single round trip
- Mandates **[[CSE484/Cryptography/Asymmetric Cryptography + key Exchange|Diffie-Hellman]]** key exchange, providing **perfect forward secrecy** (past sessions cannot be decrypted even if the server's private key is later compromised)

### TLS 1.2 (legacy)
- **2-RTT** handshake — one extra round trip for negotiation
- Supported non-forward-secret key exchange modes (RSA key transport), now deprecated

## Cryptographic Components

| Purpose | Mechanism |
|---|---|
| Key exchange | Diffie-Hellman (ECDHE) |
| Authentication | [[CSE484/Cryptography/Public Key Encryption + Digital Signatures\|Digital signatures]] (RSA or ECDSA) via X.509 certificates |
| Encryption | AES-GCM (authenticated encryption, combines confidentiality + integrity) |
| Integrity | HMAC or AEAD tag built into AES-GCM |

## TLS and Page Load Time

Each new HTTPS connection incurs:
1. TCP handshake: 1 RTT
2. TLS handshake: 1 RTT (TLS 1.3) or 2 RTT (TLS 1.2)
3. HTTP request: 1 RTT

This is a major motivation for [[CSE461/Application/Persistent Connections|persistent connections]] and [[CSE461/Definitions/QUIC|QUIC]], which integrates TLS 1.3 into the transport handshake for **0-RTT or 1-RTT** total connection setup.

## Related
- [[CSE461/Definitions/Transmission Control Protocol (TCP)|TCP]] — TLS runs on top of TCP (except in QUIC)
- [[CSE461/Definitions/QUIC]] — integrates TLS 1.3 natively, eliminating the separate TLS handshake round trip
- [[CSE461/Application/Page Load Time (PLT)]] — TLS handshake is a major PLT component
- [[CSE484/Cryptography/Cryptography]] — symmetric and asymmetric crypto primitives TLS uses
- [[CSE484/Cryptography/Asymmetric Cryptography + key Exchange]] — Diffie-Hellman key exchange used in TLS
- [[CSE484/Cryptography/Public Key Encryption + Digital Signatures]] — certificate-based authentication in TLS
- [[CSE484/Cryptography/Hashing + Ciphertext Integrity]] — HMAC and AES-GCM integrity in TLS
