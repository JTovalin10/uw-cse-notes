## Dynamic Host Configuration Protocol (DHCP)
- IP addresses cannot be configured by a manufacturer since they don't know what network a device will end up on
- The host needs to know its default router before it can start sending packets
- DHCP allows configuration without requiring a system admin to manually set up each host
- A DHCP server maintains a **pool of available addresses** that it hands out to hosts on demand
	- the admin only needs to allocate a range of IP addresses to each network

**Goal**: minimize the manual configuration required for a host to function.

### How It Works
1. A newly booted or attached host sends a `DHCPDISCOVER` message to `255.255.255.255` (IP broadcast address)
	- received by all hosts and routers on that network
	- routers do not forward these packets to other networks (prevents broadcast to entire Internet)
2. In the simplest case, a DHCP server on the network replies directly to the requesting host
3. If no DHCP server is on the local network, a **relay agent** is used:
	- at least one relay agent exists on each network
	- configured with just one piece of information: the IP address of the DHCP server
	- when it receives a `DHCPDISCOVER`, it unicasts it to the DHCP server
	- awaits the response, then sends it back to the requesting client

![[Pasted image 20260215025140.png]]
![[Pasted image 20260215025159.png]]

See also: [[IP Address Resolution Protocol (ARP)]], [[IP Global Addresses]]
