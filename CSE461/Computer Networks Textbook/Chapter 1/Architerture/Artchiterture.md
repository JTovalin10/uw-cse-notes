# Layering and Protocols

## Layering
Abstraction naturally leads to layering. Layering lets us:
1. Decompose the problem of building a network into manageable components
2. Provide a modular design — adding a new service may only require modifying one layer

Non-abstracted:
![[Pasted image 20260123021528.png]]
Abstracted:
![[Pasted image 20260123021543.png]]

## Protocols
The abstracted objects that make up network layers are called **protocols**. They provide a communication service that higher-level objects use to exchange messages.

Each protocol defines two interfaces:
1. **Service interface** — the operations that local objects can perform on the protocol
2. **Peer interface** — the form and meaning of messages exchanged between protocol peers to implement the communication service

![[Pasted image 20260123021812.png]]

## Encapsulation
Each layer wraps data with its own header info that the layer above doesn't care about but is needed for the network to function. This wrapping process is called [[Encapsulation]].

![[Pasted image 20260123021953.png]]

## The OSI Model
The **Open Systems Interconnection** model defines a layered architecture. From bottom to top:

| Layer | Unit | Role |
|---|---|---|
| **Physical** | Bits | Transmits raw bits over a link |
| **Data Link** | [[Frame]] | Collects bits into frames; implemented by [[Network Adaptor]]s and device drivers |
| **Network** | Packet | Handles [[Routing]] among nodes in a packet-switched network |
| **Transport** | Message | Provides process-to-process channels (e.g. [[TCP]], [[UDP]]) |

![[Pasted image 20260123022103.png]]

The lower three layers run on **all** network nodes (switches and hosts). Transport and above run **only on end hosts**.

## Internet Architecture
Sometimes called **TCP/IP** after its two main protocols.

![[Pasted image 20260123022234.png]]

From bottom to top:
1. **net (network layer)** — a wide variety of network protocols, implemented in hardware and software
2. **IP** — the central layer; interconnects multiple networking technologies into a single logical internetwork
3. **Transport layer** — two main protocols:
	- **[[TCP]]** — reliable byte-stream channel
	- **[[UDP]]** — unreliable datagram delivery channel (faster than TCP)
	- Both are end-to-end (transport) protocols
4. **Application layer** — HTTP, FTP, DNS, TFTP
