# CSE 461 - Computer Networks

Overview and index for all CSE4616 notes. Data transmission from physical layer up through application protocols.

## Layer overview

| Layer | Overview | What it covers |
|-------|----------|----------------|
| **Physical** | [[Physical Layer]] | Raw bits over links, media, signals, encoding |
| **Link** | [[Link Layer Overview]] | Frames, error detection, MAC, switching |
| **Network** | [[Network Layer]] | Packets, IP, routing, internetworking |
| **Transport** | [[Transmission Control Protocol (TCP)]], [[User Datagram Protocol (UDP)]] | Process-to-process delivery, TCP/UDP |
| **Routing** | [[Routing Layer]] | Intradomain, interdomain, BGP |

## Quick navigation

### Stack and concepts
- [[Layering]] — [[Protocols and Layers]] — [[Encapsulation (stack)]] — [[OSI Layers]]
- [[Host]], [[Router]], [[Application]], [[Link]] — [[Computer Network Names by Scale]]
- [[Network]] — [[Internetwork (IP)]] — [[Store and forward packet switching]] — [[Datagrams vs virtual circuits]]
- [[Routing]] vs [[Forwarding]] — [[Datagram model]] — [[Network service models]]
- [[Types of Links]] — [[Performance Cheat Sheet]] — [[Layer Addresses (L(n))]]

### Transport
- [[Transmission Control Protocol (TCP)]] — reliable byte stream, handshake, flow control
- [[User Datagram Protocol (UDP)]] — unreliable datagrams
- [[Flow Control]] — [[Sliding Window]], [[ACK Clocking]]
- [[Timeout Misfortune]] — Adaptive RTO, Karn/Partridge, Jacobson/Karels
- [[Congestion Control]] — [[Slow Start (TCP Additive Increase)]], [[Fast Recovery (TCP Multiplicative Decrease)]]
- [[Ports]] — demultiplexing

### Network Layer
- [[Internet (IP)]] — IP addressing, packets, protocols, routers
- [[Multicast]] — IP multicast
- [[Multiprotocol Label Switching]] — MPLS
- [[Routing Among Mobile Devices]] — Mobile IP
- [[Network-Side Congestion Control]] — ECN, RED

### Application Layer
- [[Domain Name System (DNS)]] — Resolution, Root/TLD, Resource Records
- [[Email - SMTP, IMAP, and MIME]] — Message transfer and access
- [[HTTP - Protocol Mechanics and Evolution]] — In-depth HTTP/1.1, 2, and 3
- [[World Wide Web - HTTP Evolution and Caching]] — URIs, URLs, and Web Caching
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

### Routing
- [[Routing Layer Overview]] — Routing algorithms, BGP, interdomain
- [[Routing Overview]] — RIP, OSPF, routing areas
- [[Interdomain Overview]] — BGP mechanics, AS policies

### Reference
- [[Definitions Overview]] — Term definitions (use for quick lookup)
