## IP Fragmentation and Reassembly
- Each network technology has its own idea of how large a packet can be (e.g., 1500 vs 9000 bytes)
- This is a problem when providing a uniform host-to-host service model over heterogeneous networks

### Solution
Two options:
1. Make all IP [[Datagrams]] small enough to fit inside one packet on any network
2. Provide a means to fragment and reassemble packets that are too big

We use the [[Maximum Transmission Unit (MTU)]] -- the largest IP datagram that can be carried in a frame.
- The host can choose any datagram size
	- a reasonable choice is the MTU of the network to which the host is directly attached
- Fragmentation is only necessary if the path to the destination includes a network with a smaller MTU
	- occurs when a router receives a datagram that it wants to forward over a network that has an MTU smaller than the received datagram

### Reassembly
- All fragments carry the same ID in the **Ident** field
- The Ident is chosen by the sending host
- It is intended to be unique among all datagrams that might arrive at the destination from this source over some reasonable time period
- Since all fragments contain this ID, it is easy to reassemble them
- If the host does not receive all fragments, it gives up and discards all fragments that arrived
	- no attempt to recover missing fragments

![[Pasted image 20260215021005.png]]

It is important to note:
1. Each fragment is itself a self-contained IP [[Datagrams]] that is transmitted over a sequence of physical networks independently of other fragments
2. Each IP datagram is re-encapsulated for each physical network over which it travels

![[Pasted image 20260215021219.png]]

See also: [[IP Packet Format]], [[IP Service Model]]
