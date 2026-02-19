Key properties of the [[Datagrams|datagram]] model of packet delivery.

- **[[Connectionless]]**: A host can send a packet anywhere at any time — any packet arriving at a switch can be immediately forwarded
- **No delivery guarantees**: The sender has no way of knowing if the network can deliver the packet or if the destination is available
- **Independent forwarding**: Each packet is forwarded independently, even if previous packets went to the same destination
- **Fault tolerance**: A switch or link failure may not be catastrophic if an alternate route exists and the forwarding table can be updated
- **Resource competition**: Each arriving packet competes with all others for buffer space; if no buffers are free, the packet is discarded
	- However, switches can distinguish packets by source/destination pair and allocate buffers fairly

See also: [[Datagrams]], [[Virtual Circuit Switching]]
