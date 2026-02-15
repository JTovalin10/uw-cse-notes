## What is an Internetwork
Also known as an internet, it is an arbitrary collection of networks interconnected to provide some host-to-host packet delivery service.

For this section:
- #define **network**: a directly connected or [[Switched Network]]
- #define **internetwork**: an interconnected collection of networks
	- referred to as a "network of networks" as it is made up of smaller networks
- #define **routers**: nodes that interconnect the networks, also called gateways
- #define **physical network**: the underlying networks that are interconnecting
- #define **logical internet**: the network built out of a collection of physical networks

![[Pasted image 20260215014750.png]]

## Internet Protocol
- IP is the key tool used today to build scalable, heterogeneous internetworks
- Runs on all nodes (both hosts and routers) in a collection of networks
- Defines the infrastructure that allows these nodes and networks to function as a single logical internetwork

![[Pasted image 20260215015053.png]]

## Topics
- [[IP Service Model]] - best-effort datagram delivery, "run over anything"
- [[IP Packet Format]] - version, HLen, TOS, TTL, flags, offset, protocol, checksum, addresses
- [[IP Fragmentation and Reassembly]] - handling packets too large for a network's [[Maximum Transmission Unit (MTU)]]
- [[IP Global Addresses]] - hierarchical addressing, Class A/B/C
- [[IP Datagram Forwarding]] - forwarding algorithm, next hop router, [[Forwarding Table]]
- [[Subnetting]] - subnet masks, subnet numbers
- [[Classless Interdomain Routing  (CIDR)]] - classless interdomain routing, aggregate routes, longest prefix match
- [[IP Address Resolution Protocol (ARP)]] - address resolution protocol, translating IP to link-level addresses
- [[Dynamic Host Configuration Protocol (DHCP)]] - automatic address assignment
- [[Internet Control Message Protocol (ICMP)]] - error reporting and control messages
- [[Virtual Private Networks (VPN)]] - virtual private networks
- [[IP Tunneling]] - encapsulation, virtual point-to-point links
