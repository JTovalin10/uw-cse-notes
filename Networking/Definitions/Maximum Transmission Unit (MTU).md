## Maximum Transmission Unit (MTU)
The largest packet size (in bytes) that a network link can carry. Different link technologies have different MTUs (e.g., Ethernet's MTU is 1500 bytes).

When a router needs to forward a packet onto a link with a smaller MTU than the packet size, it must fragment the packet. This is why IP supports [[IP Fragmentation and Reassembly|fragmentation and reassembly]].

See also: [[IP Fragmentation and Reassembly]]
