## Frame Format

- **64-bit preamble** allowing the receiver to synchronize with the signal.
- **Destination and source addresses**, each 48 bits.
- **Packet type field** (demultiplexing key). Each frame carries up to 1500 bytes and at minimum 46 bytes of data.
	- The minimum exists so that collisions can always be detected.
- **32-bit [[Cyclic Redundancy Check (CRC)|CRC]]** for error detection.
- From the host's perspective, an Ethernet frame has a 14-byte header. The sending adaptor attaches the preamble and CRC before transmitting, and the receiving adaptor removes them.

![[Pasted image 20260208021927.png]]

## Addresses

Addresses are burned into ROM. To ensure uniqueness, manufacturers of Ethernet devices are assigned different prefixes, so every address they produce is globally unique.

Every frame transmitted on an Ethernet is received by every adaptor connected to that Ethernet. Each adaptor checks the destination address and passes only matching frames to the host.

- **Promiscuous mode** — delivers all received frames to the host.
- **Unicast** — passes only frames addressed to this adaptor's own address.
- **Broadcast** — an Ethernet address consisting of all 1s.
- **Multicast** — an address with the first bit set to 1 that is not the broadcast address.

Every Ethernet adaptor receives all frames and accepts:
- Frames addressed to its own address
- Frames addressed to the broadcast address
- Frames addressed to a multicast address, if it has been instructed to listen to that address
- All frames, if it has been placed in promiscuous mode

It passes to the host only the frames that it accepts.