To keep routing scalable, the amount of information stored and exchanged per node must be minimized. IP achieves this through hierarchical [[IP Address|addressing]] — routers track networks, not individual hosts.

## Key Principles

1. Every IP datagram contains the full [[IP Address]] of the destination host.
2. The network part of an IP address uniquely identifies a single physical network.
3. All hosts and routers sharing the same network part are on the same physical network and can communicate directly.
4. Every physical network has at least one [[Router]] also connected to another network, enabling inter-network packet exchange.

## Forwarding Algorithm

A datagram travels from source to destination through zero or more routers. At each hop, the node:

1. Compares the network part of the destination address against the network part of each of its own interfaces
	- Hosts typically have one interface; routers have two or more
2. **Match found** → destination is on the same physical network, deliver directly
3. **No match** → consult the [[Forwarding Table]] to find the [[Next Hop Router]] and forward there

## Longest Prefix Match

Forwarding table entries may have overlapping prefixes. For each packet, the router applies [[Longest Prefix Match]] — it selects the most specific entry (longest prefix) containing the destination address and forwards to the next hop for that entry.

See also: [[IP Address]], [[Subnetting]], [[Classless Interdomain Routing (CIDR)]], [[Longest Prefix Match]], [[Next Hop Router]]
