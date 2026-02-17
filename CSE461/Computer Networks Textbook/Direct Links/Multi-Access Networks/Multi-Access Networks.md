Ethernet is mainly used in campus networks and data centers and is more formally known as **[[Carrier Sense Multiple Access (CSMA)|CSMA]]/CD** (Carrier Sense, Multi-Access with Collision Detection).

Ethernet is a multi-access network where a set of nodes sends and receives frames over a shared link.
- **Carrier Sense**: all nodes can distinguish between an idle and busy link.
- **Collision Detect**: a node listens as it transmits and can therefore detect when its frame has collided with a frame transmitted by another node.

The algorithm used to control access to a shared Ethernet link is **[[Media Access Control (MAC)]]**. It is typically implemented in hardware on the network adaptor.

## Topics

- [[Ethernet Physical Properties]] — transceivers, repeaters, terminators, and collision domains
- [[Ethernet Frame Format and Addresses]] — frame structure, addressing modes (unicast, broadcast, multicast)
- [[Ethernet Transmitter Algorithm]] — 1-persistent protocol, collision handling, exponential backoff
- [[Ethernet Longevity]] — why Ethernet has endured and the shift to switches
