# CSE 461 - Computer Networks

Overview and index for all CSE461 notes. Data transmission from physical layer up through application protocols.

## Layer overview

| Layer | Overview | What it covers |
|-------|----------|----------------|
| **Physical** | [[Physical Layer - Performance and Latency]] | Raw bits, media, signals, capacity, encoding |
| **Link** | [[Link Layer Overview]] | Frames, error detection, MAC, switching, VLANs |
| **Network** | [[Network Layer - Internetworking and IP]] | Packets, IPv4/v6, forwarding, multicast, MPLS |
| **Transport** | [[Transport Layer - Transmission Control Protocol (TCP)]] | Reliability, congestion, UDP, RTP, QoS |
| **Routing** | [[Routing Layer - Intradomain Routing (DV and LS)]] | Algorithms, OSPF, BGP, policy-based routing |

## Quick navigation

### Stack and concepts
- [[Layering]] — [[Protocols and Layers]] — [[Encapsulation (stack)]] — [[OSI Layers]]
- [[Host]], [[Router]], [[Application]], [[Link]] — [[Computer Network Names by Scale]]
- [[Network]] — [[Internetwork (IP)]] — [[Store and forward packet switching]] — [[Datagrams vs virtual circuits]]
- [[Routing]] vs [[Forwarding]] — [[Datagram model]] — [[Network service models]]
- [[Types of Links]] — [[Performance Cheat Sheet]]

### Physical Layer
- [[Physical Layer - Performance and Latency]] — BW, Delay, Throughput, BDP
- [[Physical Layer - Media and Links]] — Fiber, Copper, Wireless, Duplex
- [[Physical Layer - Signals and Channel Capacity]] — Nyquist, Shannon, SNR
- [[Physical Layer - Encoding and Modulation]] — NRZ, Manchester, QAM, Clock Recovery

### Link Layer
- [[Link Layer Overview]] — L2/L3 Duality, Framing, MAC
- [[Link Layer - Framing]] — Sentinel, Bit Stuffing, Ethernet Format
- [[Link Layer - Error Detection and Correction]] — Hamming Distance, CRC, Checksum
- [[Link Layer - Reliable Transmission]] — Stop-and-Wait, Sliding Window, ARQ
- [[Link Layer - Multiple Access (Wired)]] — ALOHA, CSMA/CD, Ethernet
- [[Link Layer - Multiple Access (Wireless)]] — CSMA/CA, RTS/CTS, 802.11
- [[Link Layer - Multiplexing (TDM and FDM)]] — Static vs Statistical Multiplexing
- [[Link Layer - Switching and Bridges]] — Backwards Learning, Spanning Tree (STP)
- [[Link Layer - Virtual LANs (VLANs)]] — 802.1Q Tagging, Trunking
- [[Link Layer - Access Networks (PON and Cellular)]] — FTTH, RAN, LTE/5G
- [[Link Layer - Software Defined Networking (SDN)]] — Control/Data Plane, OpenFlow

### Network Layer
- [[Network Layer - Internetworking and IP]] — Hourglass, Datagram vs VC
- [[Network Layer - IPv4 Addressing and Subnetting]] — CIDR, VLSM, DHCP, NAT
- [[Network Layer - IPv6]] — Header, SLAAC, Anycast, Transition
- [[Network Layer - Forwarding and Routing Mechanics]] — LPM, ARP, Fragmentation, ICMP, Tunneling
- [[Network Layer - Network-Side Congestion Control]] — ECN, RED
- [[Network Layer - Multicast]] — IGMP, PIM, Distribution Trees
- [[Network Layer - MPLS]] — Label Switching, Traffic Engineering, VPNs
- [[Network Layer - Mobility]] — Mobile IP, Home/Foreign Agents

### Transport Layer
- [[Transport Layer - Transmission Control Protocol (TCP)]] — Handshake, Flow Control, Sliding Window
- [[Transport Layer - TCP Congestion Control]] — AIMD, Slow Start, Reno, RTO calculation
- [[Transport Layer - UDP and Port Demultiplexing]] — 5-tuple, Port ranges, Ephemeral ports
- [[Transport Layer - Real-Time Transport (RTP and RTCP)]] — Sequencing, Timestamps, Jitter removal
- [[Transport Layer - Resource Allocation and QoS]] — Max-Min Fairness, DiffServ, RSVP
- [[Transport Layer - Advanced Transport (QUIC, SCTP, and RPC)]] — HTTP/3, Multi-streaming
- [[Timeout Misfortune]] — ACK Clock loss, Retransmission Ambiguity

### Routing
- [[Routing Layer - Intradomain Routing (DV and LS)]] — RIP, Dijkstra, Flooding
- [[Routing Layer - Open Shortest Path First (OSPF)]] — Areas, ABRs, LSA types
- [[Routing Layer - Border Gateway Protocol (BGP)]] — Path Vector, Peering, Policies
- [[Routing Layer - Interdomain Concepts]] — AS types, ASN, Aggregation
- [[Routing Layer - Delivery Models]] — Unicast, Broadcast, Multicast, Anycast

### Application Layer
- [[Domain Name System (DNS)]] — Resolution, Root/TLD, Resource Records
- [[HTTP - Protocol Mechanics and Evolution]] — In-depth HTTP/1.1, 2, and 3
- [[World Wide Web - Architecture, Identifiers, and Caching]] — URL syntax, Cookies, Proxies
- [[Page Load Time (PLT)]] — Web performance metrics
- [[Web Services - SOAP, REST, and gRPC]] — Service architectures
- [[Multimedia - RTP, RTCP, and Playout Buffers]] — Real-time transport
- [[Session Control - SIP and SDP]] — Call signaling
- [[QoS and Admission Control - DiffServ and RSVP]] — Resource guarantees
- [[Network Management - SNMP and gNMI]] — Monitoring and telemetry
- [[Overlay Networks - Fundamental Mechanics]] — Virtualization, Tunneling
- [[Routing Overlays]] — Resilient routing, End-system multicast
- [[Peer-to-Peer Networks]] — Unstructured (Gnutella), Structured (DHT/Pastry), BitTorrent
- [[Content Distribution Networks (CDN)]] — Redirection, Edge caching

### Reference
- [[Definitions Overview]] — Term definitions (use for quick lookup)
