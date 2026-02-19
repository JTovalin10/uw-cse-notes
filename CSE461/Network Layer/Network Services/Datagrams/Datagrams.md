Every packet contains enough info to enable any switch to decide how to get it to its destination. You can think of this as a postal letter — the address is on every envelope.
- packets contain a destination address; each router uses it to forward pacjets
![[Datagrams.png]]
Every packet carries the complete destination address.  Each Switches use a [[Forwarding Table]]  keyed by address to determine the next hop. While forwarding itself is straightforward, the hard part is [[Routing]] — building and maintaining those tables as the network scales.
- note: this gives next hop for each destination address but it may change

![[Pasted image 20260214014134.png]]

## Topics

- [[Datagram Characteristics]] — connectionless, fault tolerance, resource competition
- [[Virtual Circuit Switching]] — the alternative connection-oriented model
- [[Virtual Circuit Resource Allocation and QoS]] — how VCs handle resource guarantees and how the two models compare
