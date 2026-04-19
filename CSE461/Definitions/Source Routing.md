# CSE461: Source Routing

In **source routing**, the sender specifies the full path (list of ports/switch IDs) in the packet header. Each switch reads the next hop from the header and forwards accordingly.

- No [[Forwarding Table]] needed at intermediate switches — all routing decisions are made by the source
- Sender must have knowledge of the network topology
- Less common than [[Connectionless]] (datagram) or [[Virtual Circuit (VC)]] switching

![[Screenshots/Source routing in a switched network.png]]

![[Screenshots/three ways to handle headers for source routing.png]]

## Related
- [[Strict Source Route]] — all intermediate nodes are explicitly specified
- [[Loose Source Route]] — only waypoints are specified; routing between them is left to the network
- [[Forwarding Table]] — what source routing bypasses
- [[Connectionless]] — the datagram alternative
