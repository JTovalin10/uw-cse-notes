A protocol that maps a network-layer address (e.g., an IP address) to a link-layer address (e.g., an Ethernet MAC address). When a host needs to send a packet to another host on the same network, it broadcasts an ARP request asking "who has this IP?" The host with that IP responds with its MAC address. Results are cached in an ARP table to avoid repeated broadcasts.

