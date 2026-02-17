## Carrier Sense Multiple Access (CSMA)
A [[Media Access Control (MAC)|MAC]] protocol where a node **listens to the channel before transmitting**. If the channel is busy, the node waits; if idle, it transmits.

Variants:
- **CSMA/CD (Collision Detection)** — used in wired Ethernet; sender detects collisions during transmission and aborts immediately, then uses [[Binary Exponential Backoff (BEB)|BEB]] to retry
- **CSMA/CA (Collision Avoidance)** — used in wireless (WiFi); sender tries to avoid collisions since they can't be reliably detected over radio
