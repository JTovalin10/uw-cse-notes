# IPv6
## History
this came about as during the early 2000's we were running out of [[IPv4]] addresses--even with the current solutions it wasnt enough. Hence, we decided to increase the number of addresses from $2^{32}$ to $2^{128}$. It is important to note that it is also virtually impossible to achieve 100% address utilization efficeny so we may consume the entire address space before the $2^{32}$ addresses are used
## Packet format
uses 128-bits instead of IPv4's 32-bit and is simplier than it as it aimed to remove unnecessary functionality from the protocol.
- features large addresses
	- 128 bits most of header
- new notation
	- 8 groups of 4 hex digits (16 digits)
	- omits leading zeros
- only public addresses
	- no more [[Network Address Translation (NAT) box]]
- streamlined header processing
	- no more [[CSE461/Link Layer/Error Detection and Correction/Checksum]]
- flow label to group packet
- IPSec by deafult
- can use better features
Fields:
- version
	- set to 6 for IPv6 so that header-processing software can immediatlery decide which header format to hlook for
- Diff Serv/TrafficClass
- flow label
	- both FL and TC are qualityt of service issues
- ppayload length
	- the length of the packet excludi0ng the ehader (bytes)
- nextheadr
	- cleverly repalces both the IP optionand the protocl fields of IPv4. I foptions are required then they are carried in one or more special headerers following the IP header which is indeicated by the vlaue of NExtHEaDer fields if theer are no speciual headerrs then this is the demiux key idenfitying ht ehigh lvel protocl running over IP (TCP or UDP)
- fragmentation is an optional heade
- hop limit
	- [[CSE461/Network Layer/Internet (IP)/Packets/Time to Live (TTL)|Time to Live (TTL)]]
- the rest of the header is taken up by source and destination address as each are 16 bytes or 128 bits each.
![[Screenshot 2026-02-18 at 12.59.22 PM.png]]
optional header fields are better as the router doesnt need to parse the entire options fields. Ipv6 treats options as extension headers that must appear in a specifc order so each router can quiclly determine if any options are relevent to it.which is determined by looking at the nextheader field. this means that option processing is superior in IPv6 than Ipv4
![[IPv6 fragmentation extension header.png]]
## Translation
IPv6 and IPv4 are fundamentally IPv4. We still need to support IPv4 so what we can do is:
1. dual stack (speak IPv4 and 6)
2. translators (convert packets)
3. [[Tunneling]]
## Downside
due to 128 bit it increases the size of packets

## Addresses and Routing
### address Space Allocation
IPv6 is classless but uses leading bits to specify different uses of IPv6 addresses
n. First, the entire functionality of IPv4’s three main address classes (A, B, and C) is contained inside the “everything else” range. Global Unicast Addresses, as we will see shortly, are a lot like classless IPv4 addresses, only much longer. These are the main ones of interest at this point, with over 99% of the total IPv6 address space available to this important form of address. (At the time of writing, IPv6 unicast addresses are being allocated from the block that begins `001`, with the remaining address space—about 87%—being reserved for future use.)

The multicast address space is (obviously) for multicast, thereby serving the same role as class D addresses in IPv4. Note that multicast addresses are easy to distinguish—they start with a byte of all 1s. We will see how these addresses are used in a later section.
![[Pasted image 20260228235824.png]]
The idea behind link-local use addresses is to enable a host to construct an address that will work on the network to which it is connected without being concerned about the global uniqueness of the addres
### Address Notation
it uses the standard notation from IPv4 ```x:x:x:x:x:x:x:x``` where each x is a 16-bit piece of the address. However, with IPv6, we are allowed to comapct the address by comitting all the 0 fields
```
47CD:0000:0000:0000:0000:0000:A456:0124 -> 47CD::A456:0124
```
If we have a IPv4 mapped to a IPv6 address we can dop the following:
```
128.96.33.81 -> ::FFFF:128.96.33.81
```
where the alst 32 bits are written in IPv4 notation rather than a paiur of hexademcial numbers seperated by a colon. the leading double dolon indicates leading 0's
## Global Unicast addresses
To understand how it works and how it provides scalability, it is helpful to define some new terms. We may think of a nontransit AS (i.e., a stub or multihomed AS) as a _subscriber_, and we may think of a transit AS as a _provider_. Furthermore, we may subdivide providers into _direct_ and _indirect_. The former are directly connected to subscribers. The latter primarily connect other providers, are not connected directly to subscribers, and are often known as _backbone_ _networks_.

TAs with CIDR, the goal of the IPv6 address allocation plan is to provide aggregation of routing information to reduce the burden on intradomain routers. Again, the key idea is to use an address prefix—a set of contiguous bits at the most significant end of the address—to aggregate reachability information to a large number of networks and even to a large number of autonomous systems. The main way to achieve this is to assign an address prefix to a direct provider and then for that direct provider to assign longer prefixes that begin with that prefix to its subscribers. Thus, a provider can advertise a single prefix for all of its subscribers.

Of course, the drawback is that if a site decides to change providers, it will need to obtain a new address prefix and renumber all the nodes in the site. This could be a colossal undertaking, enough to dissuade most people from ever changing providers. For this reason, there is ongoing research on other addressing schemes, such as geographic addressing, in which a site’s address is a function of its location rather than the provider to which it attaches. At present, however, provider-based addressing is necessary to make routing work efficiently.

IPv6 comes with a advantage over IPv4 when it comes to this as it does nto havea  large installed base of assigned addresses to fitr into its plans
![[IPv6 provider-based unicast address.png]]

## Advanced Capabilities
### Autoconfiguration
IPv4 has this but with [[CSE461/Network Layer/Internet (IP)/Protocols/Dynamic Host Configuration Protocol (DHCP)|Dynamic Host Configuration Protocol (DHCP)]]. IPv6 uses a stateless configuration where we want to do the following:
1. obtain an interface ID that is unqiue on the link to which the host is attached
2. obtain the correct address prefix for this subnet
### Source-Directed-Routing
one of IPv6 extension header is the routing header. Without this header the routing for IPv6 differs little from IPv4 under CIDR. this contrains a lsit of addresses that represent nodes or topological areas that the pacjket should visit en route to its detination. this providesd a way f implementing provider selection on a apcket-by-packet bvasis. This providers can choose cheaper or more reliable or better security. 
anycast: to provide the ability to specify topologucal entitries rather than indivual nodess.
## Extra
we still need [[Neighbor Discovery Protocol (NDP)]] (replaces [[IP Address Resolution Protocol (ARP)|ARP]] for IPv6 address resolution) and [[Dynamic Host Configuration Protocol (DHCP)]] but no longer need [[Network Address Translation (NAT) box]]
