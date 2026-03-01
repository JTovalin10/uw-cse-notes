# IPv6

128-bit addresses; successor to [[IPv4]]. See [[Internet Protocol (IP)#Prefixes]] for prefix basics.

## History

- Early 2000s: [[IPv4]] exhaustion — even with CIDR/NAT, not enough
- Address space: $2^{32}$ → $2^{128}$
- 100% utilization impossible — allocation inefficiency, reserved blocks, and sparse assignment mean space may exhaust before all addresses are used

## IPv6 header

128-bit addresses; simpler than IPv4 (removed unnecessary features).
- features large addresses
	- 128 bits most of header
- new notation
	- 8 groups of 4 hex digits (16 digits)
	- omits leading zeros
- only public addresses
	- no more [[Network Address Translation (NAT) box]]
- streamlined header processing
	- no more [[Checksum]]
- flow label to group packet
- **IPSec by default** — built-in encryption and authentication for IPv6 packets
- better fit with advanced features
Fields:
- version
	- set to 6 for IPv6 so that header-processing software can immediately decide which header format to look for
- **Diff Serv/TrafficClass** — Differentiated Services field for [[Quality of Service (QoS)]]
- **flow label** — groups packets for special handling (e.g., same path, QoS)
- payload length
	- the length of the packet excluding the header (bytes)
- nextheader
	- Replaces IP options + protocol fields of IPv4
	- Options → extension headers (chained via NextHeader)
	- If no options: demux key for [[Transmission Control Protocol (TCP)|TCP]]/[[User Datagram Protocol (UDP)|UDP]]
- fragmentation is an optional header
- hop limit
	- [[Time to Live (TTL)]]
- the rest of the header is taken up by source and destination address as each are 16 bytes or 128 bits each.
![[Screenshot 2026-02-18 at 12.59.22 PM.png]]

- Options as extension headers — fixed order; router checks NextHeader only when needed
- Optional processing superior to IPv4 (no full parse of options)
![[IPv6 fragmentation extension header.png]]
## Translation

IPv4 coexists with IPv6. Options:

- **Dual stack** — speak both IPv4 and IPv6
- **Translators** — convert packets
- **[[IP Tunneling Overview|Tunneling]]** — encapsulate one in the other

## Downside

- 128-bit addresses increase packet size

## Addresses and Routing
### Address space allocation
- [[Classless Interdomain Routing (CIDR)|Classless]]; leading bits specify use
- **Global Unicast** — entire functionality of IPv4’s [[IP Address Classes (Classful Addressing)|three main address classes (A, B, and C)]] is contained inside the “everything else” range. Global Unicast Addresses, as we will see shortly, are a lot like [[Classless Interdomain Routing (CIDR)|classless]] [[IPv4]] addresses, only much longer. These are the main ones of interest at this point, with over 99% of the total IPv6 address space available to this important form of address. (At the time of writing, IPv6 unicast addresses are allocated from the block beginning `001` — the 3-bit prefix for global unicast; other leading bits reserve space for multicast, link-local, etc.)

- **[[Multicast Overview|Multicast]]** — for multicast; same role as [[IP Address Classes (Classful Addressing)|Class D]] addresses in IPv4; multicast addrs easy to distinguish—start with byte of all 1s
![[Pasted image 20260228235824.png]]
- **Link-local** — host constructs address for local network; no global uniqueness needed
### Address notation

- Standard: `x:x:x:x:x:x:x:x` (each x = 16 bits)
- Compact: omit leading zeros, collapse consecutive zero groups
```
47CD:0000:0000:0000:0000:0000:A456:0124 -> 47CD::A456:0124
```
If we have an IPv4 address mapped to IPv6 we can do the following:
```
128.96.33.81 -> ::FFFF:128.96.33.81
```
- IPv4-mapped: last 32 bits in IPv4 notation; leading `::` = leading zeros
## Global Unicast addresses
To understand how it works and how it provides scalability, it is helpful to define some new terms. We may think of a nontransit [[Autonomous System (AS)|AS]] (i.e., a stub or multihomed [[Autonomous System (AS)|AS]]) as a _subscriber_, and we may think of a transit [[Autonomous System (AS)|AS]] as a _provider_. Furthermore, we may subdivide providers into _direct_ and _indirect_. The former are directly connected to subscribers. The latter primarily connect other providers, are not connected directly to subscribers, and are often known as _backbone_ _networks_.

As with [[Classless Interdomain Routing (CIDR)|CIDR]], the goal of the IPv6 address allocation plan is to provide aggregation of [[Routing]] information to reduce the burden on intradomain routers. Again, the key idea is to use an address prefix—a set of contiguous bits at the most significant end of the address—to aggregate reachability information to a large number of networks and even to a large number of [[Autonomous System (AS)|autonomous systems]]. The main way to achieve this is to assign an address prefix to a direct provider and then for that direct provider to assign longer prefixes that begin with that prefix to its subscribers. Thus, a provider can advertise a single prefix for all of its subscribers.

**Provider-based addressing** means addresses encode the provider; the drawback: if a site changes providers, it must obtain a new prefix and **renumber** all nodes — a colossal undertaking that dissuades most from ever changing providers. For this reason, there is ongoing research on other addressing schemes, such as geographic addressing, in which a site’s address is a function of its location rather than the provider to which it attaches. At present, however, provider-based addressing is necessary to make routing work efficiently.

IPv6 comes with an advantage over [[IPv4]] when it comes to this as it does not have a large installed base of assigned addresses to fit into its plans
![[IPv6 provider-based unicast address.png]]

## Advanced Capabilities
### Autoconfiguration

IPv4 uses [[Dynamic Host Configuration Protocol (DHCP)]]; IPv6 has stateless config.

- Obtain interface ID unique on the link
- Obtain correct address prefix for this [[Subnet]]
### [[Source Routing|Source-Directed-Routing]]

Routing header extension. Without it, [[Routing]] like IPv4 under [[Classless Interdomain Routing (CIDR)|CIDR]].

- Contains list of nodes/topological areas packet must visit
- Provider selection per-packet (cheaper, more reliable, better security)
- **Anycast** — specify topological entities rather than individual nodes
## Extra

- Still need: [[Neighbor Discovery Protocol (NDP)]] (replaces [[IP Address Resolution Protocol (ARP)|ARP]]), [[Dynamic Host Configuration Protocol (DHCP)]]
- No longer need: [[Network Address Translation (NAT) box]]
