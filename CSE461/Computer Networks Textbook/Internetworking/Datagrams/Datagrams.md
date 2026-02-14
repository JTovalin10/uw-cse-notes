## Main Idea
Every packet contains enough info to enable any switch to decide how to get it to its destination.

## How It Works
Every packet carries the complete destination address. Switches use a [[Forwarding Table]] to determine the next hop. While forwarding itself is straightforward, the hard part is [[Routing]] — building and maintaining those tables as the network scales.

![[Pasted image 20260214014134.png]]

## Characteristics
- **[[Connectionless]]**: A host can send a packet anywhere at any time — any packet arriving at a switch can be immediately forwarded
- **No delivery guarantees**: The sender has no way of knowing if the network can deliver the packet or if the destination is available
- **Independent forwarding**: Each packet is forwarded independently, even if previous packets went to the same destination
- **Fault tolerance**: A switch or link failure may not be catastrophic if an alternate route exists and the forwarding table can be updated
- **Resource competition**: Each arriving packet competes with all others for buffer space; if no buffers are free, the packet is discarded
	- However, switches can distinguish packets by source/destination pair and allocate buffers fairly

## Alternative: Virtual Circuits
Datagrams are [[Connectionless]] — but the other major approach is [[Virtual Circuit Switching]], which sets up a connection before sending any data. This gives smaller per-packet headers and the ability to reserve resources, at the cost of setup latency and fragility to link failures. See [[VC Resource Allocation and QoS]] for how VCs handle resource guarantees and how the two models compare.
