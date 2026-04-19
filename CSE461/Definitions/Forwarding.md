# CSE461: Forwarding

**Forwarding** is the act of receiving a packet on one link of a [[Switch]] and transmitting it on another. The switch reads an identifier in the packet header and uses a [[Forwarding Table]] to decide which output link to use.

Distinct from [[CSE461/Definitions/Routing|Routing]] — forwarding is the **data-plane** action (fast, local), while routing is the **control-plane** process that builds the tables forwarding relies on (slow, network-wide).

![[Screenshots/Datagram Forwarding.png]]

## Related
- [[Forwarding Table]] — the lookup structure used during forwarding
- [[Routing]] — builds the forwarding tables
- [[Next Hop Router]] — where a packet is sent to next
- [[Network Layer - Forwarding and Routing Mechanics]] — LPM and forwarding details
