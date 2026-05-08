# CSE 461 - Computer Networks

Overview and index for all CSE461 notes. Data transmission from physical layer up through application protocols.

## Layer overview

| Layer | Overview | What it covers |
|-------|----------|----------------|
| **Physical** | [[CSE461/Physical Layer/Physical Layer - Performance and Latency|Physical Layer - Performance and Latency]] | Raw bits, media, signals, capacity, encoding |
| **Link** | [[CSE461/Link Layer/Link Layer Overview|Link Layer Overview]] | Frames, error detection, MAC, switching, VLANs |
| **Network** | [[CSE461/Network Layer/Network Layer - Internetworking and IP|Network Layer - Internetworking and IP]] | Packets, IPv4/v6, forwarding, multicast, MPLS |
| **Transport** | [[CSE461/Transport/Transport Layer - Transmission Control Protocol (TCP)|Transport Layer - Transmission Control Protocol (TCP)]] | Reliability, congestion, UDP, RTP, QoS |
| **Routing** | [[CSE461/Routing Layer/Routing Layer - Intradomain Routing (DV and LS)|Routing Layer - Intradomain Routing (DV and LS)]] | Algorithms, OSPF, BGP, policy-based routing |

## Quick navigation

### Stack and concepts
- [[CSE461/Definitions/Layering|Layering]]
- [[CSE461/Definitions/Protocols and Layers|Protocols and Layers]]
- [[CSE461/Definitions/Encapsulation (stack)|Encapsulation (stack)]] — wrapping data in protocol headers
- [[CSE461/Definitions/OSI Layers|OSI Layers]]
- [[CSE461/Definitions/Host|Host]] — network host definition
- [[CSE461/Definitions/Router|Router]] — routing device definition
- [[CSE461/Definitions/Application|Application]] — application layer definition
- [[CSE461/Definitions/Applications|Applications]] — network applications
- [[CSE461/Definitions/Link|Link]] — network link definition
- [[CSE461/Definitions/Computer Network Names by Scale|Computer Network Names by Scale]] — LAN, WAN, MAN classifications
- Network — Internetwork (IP)
- [[CSE461/Definitions/Store and forward packet switching|Store and forward packet switching]]
- [[CSE461/Network Layer/Network Layer - Internetworking and IP#2. Network Service Models|Datagrams vs virtual circuits]]
- [[CSE461/Definitions/Routing|Routing]] — routing definition
- [[CSE461/Definitions/Forwarding|Forwarding]] — packet forwarding
- [[CSE461/Network Layer/Network Layer - Internetworking and IP#The Datagram Model (Connectionless)|Datagram model]]
- [[CSE461/Network Layer/Network Layer - Internetworking and IP#2. Network Service Models|Network service models]]
- [[CSE461/Physical Layer/Physical Layer - Media and Links|Types of Links]]
- [[CSE461/Physical Layer/Physical Layer - Performance and Latency#Performance Math Cheat Sheet|Performance Cheat Sheet]]

### Physical Layer
- [[CSE461/Physical Layer/Physical Layer - Performance and Latency|Physical Layer - Performance and Latency]] — latency and throughput (BW, Delay, Throughput, BDP)
- [[CSE461/Physical Layer/Physical Layer - Media and Links|Physical Layer - Media and Links]] — physical media types (Fiber, Copper, Wireless, Duplex)
- [[CSE461/Physical Layer/Physical Layer - Signals and Channel Capacity|Physical Layer - Signals and Channel Capacity]] — Shannon capacity and signals (Nyquist, Shannon, SNR)
- [[CSE461/Physical Layer/Physical Layer - Encoding and Modulation|Physical Layer - Encoding and Modulation]] — signal encoding and modulation (NRZ, Manchester, QAM, Clock Recovery)
- [[CSE461/Definitions/Baud Rate|Baud Rate]] — signal transitions per second
- [[CSE461/Definitions/Signal-to-Noise Ratio (SNR)|Signal-to-Noise Ratio (SNR)]] — SNR metric

### Link Layer
- [[CSE461/Link Layer/Link Layer Overview|Link Layer Overview]] — link layer overview (L2/L3 Duality, Framing, MAC)
- [[CSE461/Link Layer/Link Layer - Framing|Link Layer - Framing]] — frame structure and framing methods (Sentinel, Bit Stuffing, Ethernet Format)
- [[CSE461/Link Layer/Link Layer - Framing#Bit Stuffing Algorithm|Bit Stuffing]] — escaping special bit sequences in frames
- [[CSE461/Link Layer/Link Layer - Framing#Byte Counting|Byte Count]] — frame length field framing
- [[CSE461/Link Layer/Link Layer - Framing#Sentinel-Based (Character Stuffing)|Byte Stuffing]] — escaping special byte sequences in frames
- [[CSE461/Link Layer/Link Layer - Error Detection and Correction|Link Layer - Error Detection and Correction]] — error detection and correction (Hamming Distance, CRC, Checksum)
- [[CSE461/Definitions/Checksum|Checksum]] — additive checksum error detection
- [[CSE461/Definitions/Cyclic Redundancy Check (CRC)|Cyclic Redundancy Check (CRC)]] — polynomial-based error detection
- [[CSE461/Link Layer/Link Layer - Reliable Transmission|Link Layer - Reliable Transmission]] — link-layer reliability mechanisms (Stop-and-Wait, Sliding Window, ARQ)
- [[CSE461/Definitions/Acknowledgment (ACK)|Acknowledgment (ACK)]] — TCP acknowledgment
- [[CSE461/Definitions/Automatic Repeat Request (ARQ)|Automatic Repeat Request (ARQ)]] — error recovery via retransmission
- [[CSE461/Definitions/Sliding Window Protocol|Sliding Window Protocol]] — window-based flow control
- [[CSE461/Link Layer/Link Layer - Multiple Access (Wired)|Link Layer - Multiple Access (Wired)]] — wired multiple access protocols (ALOHA, CSMA/CD, Ethernet)
- [[CSE461/Definitions/Carrier Sense Multiple Access (CSMA)|Carrier Sense Multiple Access (CSMA)]] — listen before transmit
- [[CSE461/Definitions/Binary Exponential Backoff (BEB)|Binary Exponential Backoff (BEB)]] — exponential collision avoidance
- [[CSE461/Link Layer/Link Layer - Multiple Access (Wireless)|Link Layer - Multiple Access (Wireless)]] — wireless multiple access protocols (CSMA/CA, RTS/CTS, 802.11)
- [[CSE461/Definitions/Multiple Input Multiple Output (MIMO)|Multiple Input Multiple Output (MIMO)]] — MIMO antenna technique
- [[CSE461/Definitions/Orthogonal Frequency-Division Multiple Access (OFDMA)|Orthogonal Frequency-Division Multiple Access (OFDMA)]] — OFDMA wireless access
- [[CSE461/Link Layer/Link Layer - Multiplexing (TDM and FDM)|Link Layer - Multiplexing (TDM and FDM)]] — TDM and FDM multiplexing (Static vs Statistical Multiplexing)
- [[CSE461/Definitions/Multiplexing|Multiplexing]] — sharing a channel among multiple users
- [[CSE461/Definitions/Frequency Division Multiplexing (FDM)|Frequency Division Multiplexing (FDM)]] — FDM channel division
- [[CSE461/Definitions/Time Division Multiplexing (TDM)|Time Division Multiplexing (TDM)]] — TDM channel sharing
- [[CSE461/Definitions/Statistical Multiplexing|Statistical Multiplexing]] — statistical sharing of bandwidth
- [[CSE461/Link Layer/Link Layer - Switching and Bridges|Link Layer - Switching and Bridges]] — switching and bridge operation (Backwards Learning, Spanning Tree (STP))
- [[CSE461/Definitions/Hardware Switch|Hardware Switch]] — hardware-based switching (ASICs, TCAM)
- [[CSE461/Definitions/Software Switch|Software Switch]] — software-based switching (CPU)
- [[CSE461/Link Layer/Link Layer - Virtual LANs (VLANs)|Link Layer - Virtual LANs (VLANs)]] — VLAN operation (802.1Q Tagging, Trunking)
- [[CSE461/Definitions/Virtual Local Area Network (VLAN)|Virtual Local Area Network (VLAN)]] — VLAN definition
- [[CSE461/Link Layer/Link Layer - Access Networks (PON and Cellular)|Link Layer - Access Networks (PON and Cellular)]] — PON and cellular access networks (FTTH, RAN, LTE/5G)
- [[CSE461/Definitions/Passive Optical Network (PON)|Passive Optical Network (PON)]] — PON fiber network
- [[CSE461/Definitions/Long-Term Evolution (LTE)|Long-Term Evolution (LTE)]] — LTE cellular standard
- [[CSE461/Link Layer/Link Layer - Software Defined Networking (SDN)|Link Layer - Software Defined Networking (SDN)]] — SDN at link layer (Control/Data Plane, OpenFlow)
- [[CSE461/Definitions/Software Defined Networking (SDN)|Software Defined Networking (SDN)]] — SDN definition

### Network Layer
- [[CSE461/Network Layer/Network Layer - Internetworking and IP|Network Layer - Internetworking and IP]] — IP and internetworking (Hourglass, Datagram vs VC)
- [[CSE461/Definitions/Internet Protocol (IP)|Internet Protocol (IP)]] — IP protocol definition
- [[CSE461/Network Layer/Network Layer - IPv4 Addressing and Subnetting|Network Layer - IPv4 Addressing and Subnetting]] — IPv4 addressing (CIDR, VLSM, DHCP, NAT)
- [[CSE461/Definitions/Classless Interdomain Routing (CIDR)|Classless Interdomain Routing (CIDR)]] — variable-length subnet masks
- [[CSE461/Definitions/Dynamic Host Configuration Protocol (DHCP)|Dynamic Host Configuration Protocol (DHCP)]] — automatic IP assignment
- [[CSE461/Definitions/Subnet Mask|Subnet Mask]] — subnet mask definition
- [[CSE461/Definitions/Subnet|Subnet]] — subnet definition
- [[CSE461/Network Layer/Network Layer - IPv6|Network Layer - IPv6]] — IPv6 protocol (Header, SLAAC, Anycast, Transition)
- [[CSE461/Network Layer/Network Layer - Forwarding and Routing Mechanics|Network Layer - Forwarding and Routing Mechanics]] — how forwarding and routing work (LPM, ARP, Fragmentation, ICMP, Tunneling)
- [[CSE461/Definitions/Address Resolution Protocol (ARP)|Address Resolution Protocol (ARP)]] — MAC-to-IP resolution
- [[CSE461/Definitions/Internet Control Message Protocol (ICMP)|Internet Control Message Protocol (ICMP)]] — ICMP error messages
- [[CSE461/Definitions/Maximum Transmission Unit (MTU)|Maximum Transmission Unit (MTU)]] — max packet size
- [[CSE461/Definitions/Time to Live (TTL)|Time to Live (TTL)]] — packet hop limit
- [[CSE461/Network Layer/Network Layer - Mobility|Network Layer - Mobility]] — mobile IP (Home/Foreign Agents)
- [[CSE461/Network Layer/Network Layer - MPLS|Network Layer - MPLS]] — MPLS label switching (Traffic Engineering, VPNs)
- [[CSE461/Network Layer/Network Layer - Multicast|Network Layer - Multicast]] — multicast routing (IGMP, PIM, Distribution Trees)

### Transport Layer
- [[CSE461/Transport/Transport Layer - Transmission Control Protocol (TCP)|Transport Layer - Transmission Control Protocol (TCP)]] — TCP in depth (Handshake, Flow Control, Sliding Window)
- [[CSE461/Definitions/Transmission Control Protocol (TCP)|Transmission Control Protocol (TCP)]] — TCP definition
- [[CSE461/Definitions/Advertised Window (rwnd)|Advertised Window (rwnd)]] — TCP receiver window size
- [[CSE461/Transport/Transport Layer - TCP Congestion Control|Transport Layer - TCP Congestion Control]] — TCP congestion control algorithms (AIMD, Slow Start, Reno, RTO calculation)
- [[CSE461/Definitions/Congestion Window (cwnd)|Congestion Window (cwnd)]] — TCP congestion window
- [[CSE461/Definitions/ssthresh|ssthresh]] — TCP slow start threshold
- [[CSE461/Transport/Transport Layer - UDP and Port Demultiplexing|Transport Layer - UDP and Port Demultiplexing]] — UDP and port demuxing (5-tuple, Port ranges, Ephemeral ports)
- [[CSE461/Definitions/User Datagram Protocol (UDP)|User Datagram Protocol (UDP)]] — UDP definition
- [[CSE461/Transport/Transport Layer - Real-Time Transport (RTP and RTCP)|Transport Layer - Real-Time Transport (RTP and RTCP)]] — real-time streaming (Sequencing, Timestamps, Jitter removal)
- [[CSE461/Transport/Transport Layer - Resource Allocation and QoS|Transport Layer - Resource Allocation and QoS]] — resource allocation (Max-Min Fairness, DiffServ, RSVP)
- [[CSE461/Definitions/Quality of Service (QoS)|Quality of Service (QoS)]] — QoS definition
- [[CSE461/Transport/Transport Layer - Advanced Transport (QUIC, SCTP, and RPC)|Transport Layer - Advanced Transport (QUIC, SCTP, and RPC)]] — QUIC, SCTP, RPC (HTTP/3, Multi-streaming)
- [[CSE461/Transport/Timeout Misfortune|Timeout Misfortune]] — TCP timeout issues (ACK Clock loss, Retransmission Ambiguity)

### Routing
- [[CSE461/Routing Layer/Routing Layer - Intradomain Routing (DV and LS)|Routing Layer - Intradomain Routing (DV and LS)]] — distance-vector and link-state (RIP, Dijkstra, Flooding)
- [[CSE461/Definitions/Routing Information Protocol (RIP)|Routing Information Protocol (RIP)]] — RIP distance-vector protocol
- [[CSE461/Routing Layer/Routing Layer - Open Shortest Path First (OSPF)|Routing Layer - Open Shortest Path First (OSPF)]] — OSPF details (Areas, ABRs, LSA types)
- [[CSE461/Definitions/Open Shortest Path First (OSPF)|Open Shortest Path First (OSPF)]] — OSPF link-state protocol
- [[CSE461/Routing Layer/Routing Layer - Border Gateway Protocol (BGP)|Routing Layer - Border Gateway Protocol (BGP)]] — BGP interdomain routing (Path Vector, Peering, Policies)
- [[CSE461/Routing Layer/Routing Layer - Interdomain Concepts|Routing Layer - Interdomain Concepts]] — interdomain routing concepts (AS types, ASN, Aggregation)
- [[CSE461/Definitions/Autonomous System (AS)|Autonomous System (AS)]] — autonomous system in routing
- [[CSE461/Routing Layer/Routing Layer - Delivery Models|Routing Layer - Delivery Models]] — unicast, broadcast, multicast, anycast

### Application Layer
- [[CSE461/Application/Domain Name System (DNS)|Domain Name System (DNS)]] — DNS overview (Resolution, Root/TLD, Resource Records)
- [[CSE461/Application/Domain Name System (DNS)#Low-Level Primer|DNS protocol]] — DNS protocol mechanics
- [[CSE461/Application/Iterative vs Recursive Queries|Iterative vs Recursive Queries]] — DNS query resolution styles
- [[CSE461/Application/Root Nameservers|Root Nameservers]] — DNS root nameservers
- [[CSE461/Application/HTTP - Protocol Mechanics and Evolution|HTTP - Protocol Mechanics and Evolution]] — HTTP versions and mechanics (In-depth HTTP/1.1, 2, and 3)
- [[CSE461/Definitions/World Wide Web - Architecture, Identifiers, and Caching|World Wide Web - Architecture, Identifiers, and Caching]] — URL syntax, Cookies, Proxies
- [[CSE461/Application/Web Caching|Web Caching]] — web proxy caching
- [[CSE461/Application/Web Proxies|Web Proxies]] — forward and reverse web proxies
- [[CSE461/Application/Page Load Time (PLT)|Page Load Time (PLT)]] — web page load time optimization (Web performance metrics)
- [[CSE461/Application/Web Services - SOAP, REST, and gRPC|Web Services - SOAP, REST, and gRPC]] — web service protocols (Service architectures)
- [[CSE461/Application/Multimedia - RTP, RTCP, and Playout Buffers|Multimedia - RTP, RTCP, and Playout Buffers]] — multimedia streaming protocols (Real-time transport)
- [[CSE461/Application/Session Control - SIP and SDP|Session Control - SIP and SDP]] — SIP and SDP protocols (Call signaling)
- [[CSE461/Application/QoS and Admission Control - DiffServ and RSVP|QoS and Admission Control - DiffServ and RSVP]] — quality of service mechanisms (Resource guarantees)
- [[CSE461/Application/Network Management - SNMP and gNMI|Network Management - SNMP and gNMI]] — network management protocols (Monitoring and telemetry)
- [[CSE461/Application/Overlay Networks - Fundamental Mechanics|Overlay Networks - Fundamental Mechanics]] — overlay network mechanics (Virtualization, Tunneling)
- [[CSE461/Application/Routing Overlays|Routing Overlays]] — overlay routing techniques (Resilient routing, End-system multicast)
- [[CSE461/Application/Peer-to-Peer Networks|Peer-to-Peer Networks]] — P2P architecture (Unstructured, Structured, BitTorrent)
- [[CSE461/Application/Content Distribution Networks (CDN)|Content Distribution Networks (CDN)]] — CDN architecture and purpose (Redirection, Edge caching)
- [[CSE461/Application/Caching|Caching]] — caching at the application layer

### Reference
- [[CSE461/Definitions/Definitions Overview|Definitions Overview]] — index of CSE461 definitions

## Cross-Course Concepts
- [[CSE451/Concurrency/Synchronization/Mechanics/Locks|Locks]] — synchronization mechanics
- [[CSE451/Concurrency/Synchronization/Mechanics/Race Conditions/Race Condition|Race Condition]] — concurrency hazards
