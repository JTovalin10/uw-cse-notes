VLANs fix scalability by allowing a single extended LAN to be partitioned into several seemingly separate LANs.

1. Each segment is assigned an ID (color).
2. Packets can only travel from one segment to another if both segments have the same ID.

This has the effect of limiting the number of segments in an extended LAN that will receive any given broadcast packet.

![[Pasted image 20260214220024.png]]

If VLANs are absent, any broadcast packet from any host will reach all other hosts.

## Features
- It is possible to change the logical topology without moving any wires or changing any addresses, making it attractive for network management.
- Easy to support: a 12-bit VLAN ID is inserted into the 802.1Q header specification.

![[Pasted image 20260214220203.png]]
