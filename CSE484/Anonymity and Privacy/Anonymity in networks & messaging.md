# CSE484: Anonymity in Networks and Messaging

## Web Browsing and the Anonymity Problem

Normal web browsing exposes the user's IP address to every server they contact, making requests easily linkable to an identity.

![[Screenshot 2025-12-02 at 4.02.53 PM.png]]

## Proxy Server

A **proxy server** acts as an intermediary — the client sends traffic to the proxy, which forwards it to the destination. The destination only sees the proxy's IP address.

- Simple but the proxy operator knows both the sender and the destination.
- Single point of failure and trust.

![[Screenshot 2025-12-02 at 4.09.05 PM.png]]

## Onion Routing

**Onion routing** routes traffic through multiple relays, with each relay knowing only the previous and next hop (not the full path). The message is encrypted in layers — each relay peels off one layer.

![[Screenshot 2025-12-02 at 4.09.25 PM.png]]

## Tor: Randomized Onion Routing

**Tor** is the most widely used implementation of onion routing. It uses a randomly selected path through a network of volunteer relays.

![[Screenshot 2025-12-02 at 4.12.53 PM.png]]

### Issues Against Tor

Tor has known weaknesses — particularly **traffic analysis attacks** at the network level (e.g., an attacker who can observe both the entry and exit of the Tor network can correlate timing to de-anonymize users).

![[Screenshot 2025-12-02 at 4.13.19 PM.png]]

## Synchronous Mix Server

A **mix server** collects a batch of messages, reorders them, and forwards them — breaking the link between input order and output order.

![[Screenshot 2025-12-02 at 4.13.47 PM.png]]

## Synchronous Mixnets

A **mixnet** chains multiple mix servers together for stronger anonymity guarantees.

![[Screenshot 2025-12-02 at 4.14.18 PM.png]]

### Disadvantages of Mixnets

- **High latency** — the system must batch together and decrypt a large number of messages before forwarding them, introducing significant delay.

## End-to-End Encrypted Messaging

**End-to-end encryption (E2EE)** ensures that only the sender and recipient can read the message — not the service provider or any relay in between.

![[Screenshot 2025-12-02 at 4.15.17 PM.png]]

## Related

- [[CSE484/Anonymity and Privacy/Anonymity in data|Anonymity in Data]] — anonymity in datasets and re-identification
- [[CSE484/Side Channel Attacks/Side Channel Attacks|Side Channel Attacks]] — traffic analysis is a side-channel on networks
- [[CSE461/Transport Layer/Transport Layer Security (TLS)|TLS]] — encryption in transit, which E2EE builds on