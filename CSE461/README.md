# CSE 461 - Computer Networks

## Course Overview

CSE 461 covers the fundamentals of computer networking. The course explores how data is transmitted across networks, from the physical layer up through application protocols, following the layered network model.

**→ [[CSE461 Index]] — main index and navigation**

## Topics Covered

### Stack and Concepts
- [[Layering]] — Abstraction and modularity.
- [[Protocols and Layers]] — Peer interfaces vs. Service interfaces.
- [[Encapsulation (stack)]] — PDUs (Segment, Packet, Frame, Bits).
- [[OSI Layers]] — The 7-layer theoretical model.

### Physical Layer
- [[Physical Layer - Performance and Latency]] — BW, Delay, Throughput, BDP.
- [[Physical Layer - Media and Links]] — Fiber, Copper, Wireless, Duplex.
- [[Physical Layer - Signals and Channel Capacity]] — Nyquist, Shannon, SNR.
- [[Physical Layer - Encoding and Modulation]] — NRZ, Manchester, QAM, Clock Recovery.

### Link Layer
- [[Link Layer Overview]] — Framing, MAC addresses, L2/L3 duality.
- [[Link Layer - Framing]] — Sentinel vs. Bit-stuffing vs. Clock-based.
- [[Link Layer - Error Detection and Correction]] — Hamming codes, CRC, Checksum.
- [[Link Layer - Reliable Transmission]] — Sliding Window, Stop-and-Wait, ARQ.
- [[Link Layer - Multiple Access (Wired)]] — CSMA/CD, Ethernet, BEB.
- [[Link Layer - Multiple Access (Wireless)]] — CSMA/CA, RTS/CTS, 802.11.
- [[Link Layer - Switching and Bridges]] — Spanning Tree (STP), Backwards Learning.
- [[Link Layer - Virtual LANs (VLANs)]] — 802.1Q Tagging, Trunking.
- [[Link Layer - Access Networks (PON and Cellular)]] — FTTH, RAN, LTE/5G.
- [[Link Layer - Software Defined Networking (SDN)]] — Control vs. Data Plane.

### Network Layer
- [[Network Layer - Internetworking and IP]] — Hourglass model, Datagram vs. VC.
- [[Network Layer - IPv4 Addressing and Subnetting]] — CIDR, VLSM, DHCP, NAT.
- [[Network Layer - IPv6]] — Header format, SLAAC, Anycast.
- [[Network Layer - Forwarding and Routing Mechanics]] — LPM, ARP, Fragmentation, ICMP.
- [[Network Layer - Multicast]] — IGMP, PIM, Distribution Trees.
- [[Network Layer - MPLS]] — Label Switching, VPNs, Traffic Engineering.
- [[Network Layer - Mobility]] — Mobile IP, Triangle Routing.

### Transport Layer
- [[Transport Layer - Transmission Control Protocol (TCP)]] — Handshake, Flow Control, Reliability.
- [[Transport Layer - TCP Congestion Control]] — AIMD, Slow Start, Reno, RTO calculation.
- [[Transport Layer - UDP and Port Demultiplexing]] — Ports, 5-tuple, ephemeral ports.
- [[Transport Layer - Real-Time Transport (RTP and RTCP)]] — Sequencing, Jitter, Intermedia sync.
- [[Transport Layer - Resource Allocation and QoS]] — Max-Min Fairness, DiffServ, RSVP.
- [[Transport Layer - Advanced Transport (QUIC, SCTP, and RPC)]] — HTTP/3, Multi-streaming.

### Routing
- [[Routing Layer - Intradomain Routing (DV and LS)]] — RIP, Dijkstra, Flooding.
- [[Routing Layer - Open Shortest Path First (OSPF)]] — Areas, ABRs, LSA types.
- [[Routing Layer - Border Gateway Protocol (BGP)]] — Path Vector, Peering, Policies.
- [[Routing Layer - Interdomain Concepts]] — AS types, ASN, Aggregation.

### Application Layer
- [[Domain Name System (DNS)]] — Resolution, Root/TLD, Any-cast.
- [[HTTP - Protocol Mechanics and Evolution]] — HTTP/1.1, 2, and 3.
- [[World Wide Web - Architecture, Identifiers, and Caching]] — URL syntax, Cookies, Proxies.
- [[Page Load Time (PLT)]] — Latency components and optimization.
- [[Web Services - SOAP, REST, and gRPC]] — Cloud architecture.
- [[Multimedia - RTP, RTCP, and Playout Buffers]] — Real-time delivery.
- [[Overlay Networks - Fundamental Mechanics]] — Virtualization, Tunneling.
- [[Peer-to-Peer Networks]] — Gnutella, DHT/Pastry, BitTorrent.
- [[Content Distribution Networks (CDN)]] — Redirection, Edge caching.
