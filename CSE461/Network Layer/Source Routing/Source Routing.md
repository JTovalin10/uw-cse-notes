The source host provides all network topology info needed to switch a packet across the network.

## How It Works
1. **Port numbering**: Assign a number to each output of each switch and place that number in the packet header. On arrival, the switch reads the port number and transmits on that output.
	- Problem: this only works for a single switch — if the path crosses multiple switches, the header needs to carry info for all of them
2. **Ordered port list**: Place an ordered list of switch ports in the header and rotate the list so the next switch in the path is always at the front.
	- Each switch only needs to read the front entry, solving the multi-switch problem
	- ![[Pasted image 20260214021808.png]]

## Issues
- Source must know enough about the topology to build a correct header
- Header size is unbounded — must hold one entry per switch on the path, so no upper bound on header size

## Benefit
Can be used in both [[Connectionless|datagram]] and [[Virtual Circuit (VC)]] networks.

## Header Consumption
Once the ordered port list is in the header, switches need a way to consume it. There are three approaches — rotation, stripping, and pointer — each with different tradeoffs for efficiency and whether the destination can reconstruct the return path. See [[Header Variations]].

## Strict vs Loose
Not all source routes require full path knowledge. A [[Strict Source Route]] specifies every node, while a [[Loose Source Route]] only specifies waypoints and lets the network fill in the gaps — useful when the source can't know the full topology.
