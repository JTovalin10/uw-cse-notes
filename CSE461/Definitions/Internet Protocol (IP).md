i## Internet Protocol (IP)
The network-layer protocol that provides the [[Datagram]] delivery service for the Internet. IP defines addressing (32-bit addresses in IPv4, 128-bit in IPv6) and handles routing packets across heterogeneous networks through [[Encapsulation]].

## IPv4
Uses 32-bit addresses
written in dotted quad notation where four 8-bit numbers separated by dots
- 0 <= n <= 255
- 18.31.0.1 = A.B.C.D
### Prefix
Addresses are allocated in blocks called **prefixes**
- L-bit prefix have the same top L bits
- there are $2^{32-L}$ addresses aligned on $2^{32-L}$ boundry
![[Pasted image 20260218203454.png]]
it is written in IP address / length
address is the lowest address in the prefix, the lengtgh is the prefix biots
- 128.13.9.9/16 -> 128.13.0.0 -> 128.13.255.255
- the prefix bits tell us which bits identify the network hence /x means the last x bits represent the network and the rest the host
#### Classless IP Addressing
![[Classful IP Addressing.png]]
### IPv4 header
![[IPv4.png]]

Key properties of IP's service model:
- [[Connectionless]] (datagram-based)
- Best-effort delivery (no guarantees on reliability, ordering, or timing)
- Supports [[IP Fragmentation and Reassembly|fragmentation]] when packets exceed a link's [[Maximum Transmission Unit (MTU)|MTU]]

See also: [[IP Service Model]], [[IP Packet Format]]

## IPv6
128-bit address which is most of header
uses new notation which is:
- 8 groups of 4 hex digits (16 bits)
- omit leading zeros, group of zeros
- 2001:0db8:0000:0000:0000:ff00:0042:8329 ->2001:db8::ff00:42:8329
![[Pasted image 20260218211600.png]]
## Other changes
1. only public addresses
	1. no more [[Network Address Translation (NAT) box]]
2. streamlined header processing
	1. no [[CSE461/Definitions/Checksum|Checksum]]
3. flow label to group of packets
4. IPSec by default
5. better firt with advance features
does not fix [[Address Resolution Protocol (ARP)]] nor [[CSE461/Network Layer/Internet (IP)/Protocols/Dynamic Host Configuration Protocol (DHCP)|Dynamic Host Configuration Protocol (DHCP)]]
