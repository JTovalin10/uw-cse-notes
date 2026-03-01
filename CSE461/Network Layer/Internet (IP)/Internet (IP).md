# Internet (IP) Overview

IP interconnects networks into a single logical internetwork. Hides differences in service model, addressing, QoS, packet sizes.

## Core topics

- [[Internetwork (IP)]] — What an internetwork is
- [[Internet Protocol (IP) overview]] — IP as narrow waist
- [[Internet Reference Model]] — IP abstracts lower layers
- [[Connecting Datagram and VC Networks]] — Mapping addresses to VCs
- [[Host Networking]] — Host IP configuration (address, subnet mask, gateway, DNS)
- [[IP Datagram Forwarding]] — How packets get routed
- [[IP Packets]] — Format, fragmentation, MTU

## Subdirectories

| Directory | Contents |
|-----------|----------|
| **Addressing** | [[IP Address]], [[Subnetting]], [[Classless Interdomain Routing (CIDR)]], [[IP Global Addresses]] |
| **Protocols** | [[IP Address Resolution Protocol (ARP)]] (IPv4), [[Neighbor Discovery Protocol (NDP)]] (IPv6), [[Dynamic Host Configuration Protocol (DHCP)]], [[Internet Control Message Protocol (ICMP)]], [[Traceroute]] |
| **Packets** | [[IP Packet Format]], [[IP Service Model]], [[IP Fragmentation and Reassembly]], [[Maximum Transmission Unit (MTU)]] |
| **Routers** | [[Router]], [[Next Hop Router]] |
| **Tunneling** | [[Tunneling]], [[IP Tunneling]], [[Virtual Private Networks (VPN)]] |
| **NAT and Middleboxes** | [[Network Address Translation (NAT) box]], [[Middlebox]] |

## IP versions

| Version | Note |
|---------|------|
| **[[IPv4]]** | 32-bit addresses; dotted-quad; CIDR |
| **[[IPv6]]** | 128-bit addresses; streamlined header |

## IP enhancements

- [[Multicast]] — One-to-many, many-to-many
- [[Multiprotocol Label Switching]] — Label switching
- [[Routing Among Mobile Devices]] — Mobile IP
