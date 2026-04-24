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
- [[Layering]]
- [[Protocols and Layers]]
- [[Encapsulation (stack)]] — wrapping data in protocol headers
- [[OSI Layers]]
- [[Host]] — network host definition
- [[Router]] — routing device definition
- [[CSE461/Definitions/Application|Application]] — application layer definition
- [[CSE461/Definitions/Applications|Applications]] — network applications
- [[Link]] — network link definition
- [[Computer Network Names by Scale]] — LAN, WAN, MAN classifications
- Network — Internetwork (IP)
- [[Store and forward packet switching]]
- Datagrams vs virtual circuits
- [[Routing]] — routing definition
- [[Forwarding]] — packet forwarding
- Datagram model
- Network service models
- Types of Links
- Performance Cheat Sheet

### Physical Layer
- [[Physical Layer - Performance and Latency]] — latency and throughput (BW, Delay, Throughput, BDP)
- [[Physical Layer - Media and Links]] — physical media types (Fiber, Copper, Wireless, Duplex)
- [[Physical Layer - Signals and Channel Capacity]] — Shannon capacity and signals (Nyquist, Shannon, SNR)
- [[Physical Layer - Encoding and Modulation]] — signal encoding and modulation (NRZ, Manchester, QAM, Clock Recovery)
- [[Baud Rate]] — signal transitions per second
- [[Signal-to-Noise Ratio (SNR)]] — SNR metric

### Link Layer
- [[Link Layer Overview]] — link layer overview (L2/L3 Duality, Framing, MAC)
- [[Link Layer - Framing]] — frame structure and framing methods (Sentinel, Bit Stuffing, Ethernet Format)
- [[Bit Stuffing]] — escaping special bit sequences in frames
- [[Byte Count]] — frame length field framing
- [[Byte Stuffing]] — escaping special byte sequences in frames
- [[Link Layer - Error Detection and Correction]] — error detection and correction (Hamming Distance, CRC, Checksum)
- [[Checksum]] — additive checksum error detection
- [[Cyclic Redundancy Check (CRC)]] — polynomial-based error detection
- [[Link Layer - Reliable Transmission]] — link-layer reliability mechanisms (Stop-and-Wait, Sliding Window, ARQ)
- [[Acknowledgment (ACK)]] — TCP acknowledgment
- [[Automatic Repeat Request (ARQ)]] — error recovery via retransmission
- [[Sliding Window Protocol]] — window-based flow control
- [[Link Layer - Multiple Access (Wired)]] — wired multiple access protocols (ALOHA, CSMA/CD, Ethernet)
- [[Carrier Sense Multiple Access (CSMA)]] — listen before transmit
- [[Binary Exponential Backoff (BEB)]] — exponential collision avoidance
- [[Link Layer - Multiple Access (Wireless)]] — wireless multiple access protocols (CSMA/CA, RTS/CTS, 802.11)
- [[Multiple Input Multiple Output (MIMO)]] — MIMO antenna technique
- [[Orthogonal Frequency-Division Multiple Access (OFDMA)]] — OFDMA wireless access
- [[Link Layer - Multiplexing (TDM and FDM)]] — TDM and FDM multiplexing (Static vs Statistical Multiplexing)
- [[Multiplexing]] — sharing a channel among multiple users
- [[Frequency Division Multiplexing (FDM)]] — FDM channel division
- [[Time Division Multiplexing (TDM)]] — TDM channel sharing
- [[Statistical Multiplexing]] — statistical sharing of bandwidth
- [[Link Layer - Switching and Bridges]] — switching and bridge operation (Backwards Learning, Spanning Tree (STP))
- [[Link Layer - Virtual LANs (VLANs)]] — VLAN operation (802.1Q Tagging, Trunking)
- [[Virtual Local Area Network (VLAN)]] — VLAN definition
- [[Link Layer - Access Networks (PON and Cellular)]] — PON and cellular access networks (FTTH, RAN, LTE/5G)
- [[Passive Optical Network (PON)]] — PON fiber network
- [[Long-Term Evolution (LTE)]] — LTE cellular standard
- [[Link Layer - Software Defined Networking (SDN)]] — SDN at link layer (Control/Data Plane, OpenFlow)
- [[Software Defined Networking (SDN)]] — SDN definition

### Network Layer
- [[Network Layer - Internetworking and IP]] — IP and internetworking (Hourglass, Datagram vs VC)
- [[Internet Protocol (IP)]] — IP protocol definition
- [[Network Layer - IPv4 Addressing and Subnetting]] — IPv4 addressing (CIDR, VLSM, DHCP, NAT)
- [[Classless Interdomain Routing (CIDR)]] — variable-length subnet masks
- [[Dynamic Host Configuration Protocol (DHCP)]] — automatic IP assignment
- [[Subnet Mask]] — subnet mask definition
- [[Subnet]] — subnet definition
- [[Network Layer - IPv6]] — IPv6 protocol (Header, SLAAC, Anycast, Transition)
- [[Network Layer - Forwarding and Routing Mechanics]] — how forwarding and routing work (LPM, ARP, Fragmentation, ICMP, Tunneling)
- [[Address Resolution Protocol (ARP)]] — MAC-to-IP resolution
- [[Internet Control Message Protocol (ICMP)]] — ICMP error messages
- [[Maximum Transmission Unit (MTU)]] — max packet size
- [[Time to Live (TTL)]] — packet hop limit
- [[Network Layer - Mobility]] — mobile IP (Home/Foreign Agents)
- [[Network Layer - MPLS]] — MPLS label switching (Traffic Engineering, VPNs)
- [[Network Layer - Multicast]] — multicast routing (IGMP, PIM, Distribution Trees)

### Transport Layer
- [[Transport Layer - Transmission Control Protocol (TCP)]] — TCP in depth (Handshake, Flow Control, Sliding Window)
- [[Transmission Control Protocol (TCP)]] — TCP definition
- [[Advertised Window (rwnd)]] — TCP receiver window size
- [[Transport Layer - TCP Congestion Control]] — TCP congestion control algorithms (AIMD, Slow Start, Reno, RTO calculation)
- [[Congestion Window (cwnd)]] — TCP congestion window
- [[ssthresh]] — TCP slow start threshold
- [[Transport Layer - UDP and Port Demultiplexing]] — UDP and port demuxing (5-tuple, Port ranges, Ephemeral ports)
- [[User Datagram Protocol (UDP)]] — UDP definition
- [[Transport Layer - Real-Time Transport (RTP and RTCP)]] — real-time streaming (Sequencing, Timestamps, Jitter removal)
- [[Transport Layer - Resource Allocation and QoS]] — resource allocation (Max-Min Fairness, DiffServ, RSVP)
- [[Quality of Service (QoS)]] — QoS definition
- [[Transport Layer - Advanced Transport (QUIC, SCTP, and RPC)]] — QUIC, SCTP, RPC (HTTP/3, Multi-streaming)
- [[Timeout Misfortune]] — TCP timeout issues (ACK Clock loss, Retransmission Ambiguity)

### Routing
- [[Routing Layer - Intradomain Routing (DV and LS)]] — distance-vector and link-state (RIP, Dijkstra, Flooding)
- [[Routing Information Protocol (RIP)]] — RIP distance-vector protocol
- [[Routing Layer - Open Shortest Path First (OSPF)]] — OSPF details (Areas, ABRs, LSA types)
- [[Open Shortest Path First (OSPF)]] — OSPF link-state protocol
- [[Routing Layer - Border Gateway Protocol (BGP)]] — BGP interdomain routing (Path Vector, Peering, Policies)
- [[Routing Layer - Interdomain Concepts]] — interdomain routing concepts (AS types, ASN, Aggregation)
- [[Autonomous System (AS)]] — autonomous system in routing
- [[Routing Layer - Delivery Models]] — unicast, broadcast, multicast, anycast

### Application Layer
- [[Domain Name System (DNS)]] — DNS overview (Resolution, Root/TLD, Resource Records)
- [[DNS protocol]] — DNS protocol mechanics
- [[Iterative vs Recursive Queries]] — DNS query resolution styles
- [[Root Nameservers]] — DNS root nameservers
- [[HTTP - Protocol Mechanics and Evolution]] — HTTP versions and mechanics (In-depth HTTP/1.1, 2, and 3)
- [[World Wide Web - Architecture, Identifiers, and Caching]] — URL syntax, Cookies, Proxies
- [[Web Caching]] — web proxy caching
- [[Web Proxies]] — forward and reverse web proxies
- [[Page Load Time (PLT)]] — web page load time optimization (Web performance metrics)
- [[Web Services - SOAP, REST, and gRPC]] — web service protocols (Service architectures)
- [[Multimedia - RTP, RTCP, and Playout Buffers]] — multimedia streaming protocols (Real-time transport)
- [[Session Control - SIP and SDP]] — SIP and SDP protocols (Call signaling)
- [[QoS and Admission Control - DiffServ and RSVP]] — quality of service mechanisms (Resource guarantees)
- [[Network Management - SNMP and gNMI]] — network management protocols (Monitoring and telemetry)
- [[Overlay Networks - Fundamental Mechanics]] — overlay network mechanics (Virtualization, Tunneling)
- [[Routing Overlays]] — overlay routing techniques (Resilient routing, End-system multicast)
- [[Peer-to-Peer Networks]] — P2P architecture (Unstructured, Structured, BitTorrent)
- [[Content Distribution Networks (CDN)]] — CDN architecture and purpose (Redirection, Edge caching)
- [[Caching]] — caching at the application layer

### Reference
- [[Definitions Overview]] — index of CSE461 definitions
