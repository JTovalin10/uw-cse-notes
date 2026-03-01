# Internet Protocol (IP)

Network-layer protocol providing [[Datagram]] delivery for the Internet. Defines addressing and routes packets across heterogeneous networks via [[Encapsulation]].

## IPv4

See [[IPv4]]. 32-bit addresses in dotted-quad notation.

- Four 8-bit numbers separated by dots (e.g., 18.31.0.1 = A.B.C.D)
- Each octet: 0 ≤ n ≤ 255

### Prefix

Addresses allocated in blocks called **prefixes**.

- L-bit prefix → same top L bits
- $2^{32-L}$ addresses, aligned on $2^{32-L}$ boundary
- Written as `address/length` — address = lowest in prefix, length = prefix bits
- Example: 128.13.9.9/16 → 128.13.0.0 to 128.13.255.255
- /x means first x bits = network, rest = host

![[Pasted image 20260218203454.png]]
![[Classful IP Addressing.png]]

### IPv4 header

![[IPv4.png]]

### Service model

- [[Connectionless]] (datagram-based)
- Best-effort delivery (no reliability, ordering, or timing guarantees)
- [[IP Fragmentation and Reassembly|Fragmentation]] when packets exceed [[Maximum Transmission Unit (MTU)|MTU]]

See also: [[IP Service Model]], [[IP Packet Format]]

## IPv6

See [[IPv6]]. 128-bit addresses; most of header is address. New notation:

- 8 groups of 4 hex digits (16 bits each)
- Omit leading zeros; collapse consecutive zero groups
- Example: 2001:0db8:0000:0000:0000:ff00:0042:8329 → 2001:db8::ff00:42:8329

![[Pasted image 20260218211600.png]]

### Changes from IPv4

- Only public addresses — no [[Network Address Translation (NAT) box]]
- Streamlined header — no [[Checksum]]
- Flow label to group packets
- IPSec by default
- Better fit for advanced features

Uses [[Neighbor Discovery Protocol (NDP)]] instead of [[Address Resolution Protocol (ARP)]] for address resolution. Uses a form of DHCP (DHCPv6) for some use cases; stateless autoconfiguration covers many cases.
