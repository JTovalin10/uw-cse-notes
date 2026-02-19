A 32-bit globally unique identifier assigned to every host in an internetwork.

IP addresses are **hierarchical** — split into two parts:
- **Network part** — identifies which physical network the host is attached to. All hosts on the same network share the same network part.
- **Host part** — uniquely identifies the host within that network.

This hierarchy allows routers to make forwarding decisions using only the network part, rather than tracking every individual host.

Written in **dotted decimal notation** (e.g., `192.168.1.1`) — four decimal numbers separated by dots, each representing 8 bits.

See also: [[IP Global Addresses]], [[Subnet Mask]], [[Longest Prefix Match]], [[IP Datagram Forwarding]]
