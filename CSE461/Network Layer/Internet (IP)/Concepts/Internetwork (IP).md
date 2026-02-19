An arbitrary collection of networks interconnected to provide host-to-host packet delivery. It hides differences in:
- Service model
- Addressing
- Quality of service
- Packet sizes
- Security

…with a common protocol ([[Internet Protocol (IP)|IP]]).

![[Pasted image 20260215014750.png]]

## Internet Protocol (IP)
- [[Internet Protocol (IP)|IP]] is the key tool used today to build scalable, heterogeneous internetworks
- Runs on all nodes (both hosts and routers) in a collection of networks
- Defines the infrastructure that allows these nodes and networks to function as a single logical internetwork

![[Pasted image 20260215015053.png]]

## Key Terms
- [[Network (Internetwork Definition)]] — a directly connected or [[Switched Network]]
- [[Internetwork]] — an interconnected collection of networks ("network of networks")
- [[Router]] — nodes that interconnect networks, also called gateways
- [[Physical Network]] — the underlying networks being interconnected
- [[Logical Internet]] — the network built from a collection of physical networks

## Topics

### [[IP Packets]]
- [[IP Service Model]] — best-effort datagram delivery, "run over anything"
- [[IP Packet Format]] — version, HLen, TOS, TTL, flags, offset, protocol, checksum, addresses
- [[IP Fragmentation and Reassembly]] — handling packets too large for a network's [[Maximum Transmission Unit (MTU)|MTU]]

### [[IP Addressing]]
- [[IP Global Addresses]] — hierarchical addressing, Class A/B/C
- [[Subnetting]] — subnet masks and subnet numbers
- [[Classless Interdomain Routing (CIDR)]] — aggregate routes, longest prefix match

### Forwarding
- [[IP Datagram Forwarding]] — forwarding algorithm, next hop router, [[Forwarding Table]]

### [[IP Protocols]]
- [[IP Address Resolution Protocol (ARP)]] — translating IP to link-level addresses
- [[Dynamic Host Configuration Protocol (DHCP)]] — automatic address assignment
- [[Internet Control Message Protocol (ICMP)]] — error reporting and control messages

### [[IP Tunneling Overview]]
- [[Virtual Private Networks (VPN)]] — private networks over shared infrastructure
- [[IP Tunneling]] — encapsulation, virtual point-to-point links
