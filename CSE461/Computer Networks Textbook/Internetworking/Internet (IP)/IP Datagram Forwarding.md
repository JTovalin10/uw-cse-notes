## IP Datagram Forwarding
To achieve scalability we must reduce the amount of information that is stored in each node and exchanged between nodes.

### Main Ideas
1. Every IP datagram contains the IP address of the destination host.
2. The network part of an IP address uniquely identifies a single physical network that is part of the larger Internet.
3. All hosts and routers that share the same network part of their address are connected to the same physical network and can thus communicate with each other by sending frames over that network.
4. Every physical network that is part of the Internet has at least one router that, by definition, is also connected to at least one other physical network; this router can exchange packets with hosts or routers on either network.

### Algorithm
- A datagram is sent from a source host to a destination host, possibly passing through several routers along the way
- Any node (host or router) first checks whether it is connected to the same physical network as the destination
	- it compares the network part of the destination address with the network part of each of its network interfaces
	- hosts normally have only one interface; routers normally have two or more
- If a match occurs, the destination is on the same physical network and the packet can be delivered directly
- If no match, the node needs to forward the [[Datagrams]] to a router
	- each node must choose the best router with a reasonable chance of getting the datagram closer to its destination
	- this is called the **next hop router**
	- the node consults its [[Forwarding Table]] to find this

See also: [[IP Global Addresses]], [[Subnetting]], [[Classless Interdomain Routing  (CIDR)]]
